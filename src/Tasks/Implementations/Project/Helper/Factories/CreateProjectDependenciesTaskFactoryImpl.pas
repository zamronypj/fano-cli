(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateProjectDependenciesTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf,
    TextFileCreatorIntf,
    ContentModifierIntf;

type

    (*!--------------------------------------
     * Helper factory class for create project dependency task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectDependenciesTaskFactory = class(TInterfacedObject, ITaskFactory)
    private
        function buildConfigProjectTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask;
        function buildSessionProjectTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask;

        function buildMiddlewareProjectTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask;

        function buildBasicProjectTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask;

        function buildProjectTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask;
    public
        function build() : ITask;
    end;

implementation

uses

    FileContentReaderIntf,
    NullTaskImpl,
    DirectoryCreatorImpl,
    TextFileCreatorImpl,
    ContentModifierImpl,
    CreateCompilerConfigsTaskImpl,
    CreateAppConfigsTaskImpl,
    CreateSessionJsonAppConfigsTaskImpl,
    CreateSessionIniAppConfigsTaskImpl,
    CreateSessionAppConfigsTaskImpl,
    CreateFileSessionDependenciesTaskImpl,
    CompositeSessionTypeTaskImpl,
    CompositeSessionTaskImpl,
    CreateShellScriptsTaskImpl,
    RegisterConfigDependencyTaskImpl,
    CreateConfigMethodTaskImpl,
    FileHelperAppendImpl,
    GroupTaskImpl,
    CompositeTaskImpl,
    BasicKeyGeneratorImpl,
    WithSessionOrMiddlewareTaskImpl,
    CreateMiddlewareDependenciesTaskImpl,
    CreateNoMiddlewareDependenciesTaskImpl,
    CreateSessionDirTaskImpl,
    ForceConfigDecoratorTaskImpl;

    function TCreateProjectDependenciesTaskFactory.buildConfigProjectTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    var fileReader : IFileContentReader;
    begin
        fileReader := TFileHelperAppender.create();
        result := TGroupTask.create([
            TCreateConfigMethodTask.create(
                textFileCreator,
                contentModifier,
                fileReader
            ),
            TRegisterConfigDependencyTask.create(
                textFileCreator,
                contentModifier,
                fileReader
            )
        ]);

    end;

    function TCreateProjectDependenciesTaskFactory.buildSessionProjectTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    var registerCfgTask : ITask;
    begin
        registerCfgTask := buildConfigProjectTask(textFileCreator, contentModifier);

        result := TGroupTask.create([
            TCreateCompilerConfigsTask.create(textFileCreator, contentModifier),
            TCompositeSessionTask.create(
                //force --config always set if --with-session is set
                TForceConfigDecoratorTask.create(
                    TCreateSessionAppConfigsTask.create(
                        TCreateSessionJsonAppConfigsTask.create(
                            textFileCreator,
                            contentModifier,
                            TBasicKeyGenerator.create()
                        ),
                        TCreateSessionIniAppConfigsTask.create(
                            textFileCreator,
                            contentModifier,
                            TBasicKeyGenerator.create()
                        )
                    )
                ),
                TCreateAppConfigsTask.create(textFileCreator, contentModifier)
            ),
            TCompositeSessionTask.create(
                //force --config always set if --with-session is set
                TForceConfigDecoratorTask.create(registerCfgTask),
                registerCfgTask
            ),
            TCompositeSessionTypeTask.create(
                //run this task if --with-session=file is set
                TCreateSessionDirTask.create(TDirectoryCreator.create()),
                //run this task if --with-session=cookie is set
                TNullTask.create(),
                //run this task if --with-session=db is set
                TNullTask.create()
            )
        ]);
    end;

    function TCreateProjectDependenciesTaskFactory.buildMiddlewareProjectTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    var registerCfgTask : ITask;
    begin
        registerCfgTask := buildConfigProjectTask(textFileCreator, contentModifier);

        result := TGroupTask.create([
            TCreateCompilerConfigsTask.create(textFileCreator, contentModifier),
            TCreateAppConfigsTask.create(textFileCreator, contentModifier),
            registerCfgTask,
            TCreateMiddlewareDependenciesTask.create(
                textFileCreator,
                contentModifier,
                TFileHelperAppender.create()
            )
        ]);
    end;

    function TCreateProjectDependenciesTaskFactory.buildBasicProjectTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    var registerCfgTask : ITask;
    begin
        registerCfgTask := buildConfigProjectTask(textFileCreator, contentModifier);
        result := TGroupTask.create([
            TCreateCompilerConfigsTask.create(textFileCreator, contentModifier),
            TCreateAppConfigsTask.create(textFileCreator, contentModifier),
            registerCfgTask,
            //add no middleware support
            TCreateNoMiddlewareDependenciesTask.create(
                textFileCreator,
                contentModifier,
                TFileHelperAppender.create()
            )
        ]);
    end;

    function TCreateProjectDependenciesTaskFactory.buildProjectTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TWithSessionOrMiddlewareTask.create(
            buildSessionProjectTask(textFileCreator, contentModifier),
            buildMiddlewareProjectTask(textFileCreator, contentModifier),
            buildBasicProjectTask(textFileCreator, contentModifier)
        );
    end;

    function TCreateProjectDependenciesTaskFactory.build() : ITask;
    var textFileCreator : ITextFileCreator;
        contentModifier : IContentModifier;
    begin
        textFileCreator := TTextFileCreator.create();
        try
            contentModifier := TContentModifier.create();
            try
                try
                    result := buildProjectTask(textFileCreator, contentModifier);
                except
                    result := nil;
                end;
            finally
                contentModifier := nil;
            end;
        finally
            textFileCreator := nil;
        end;
    end;

end.

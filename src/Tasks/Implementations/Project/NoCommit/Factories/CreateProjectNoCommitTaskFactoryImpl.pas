(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateProjectNoCommitTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    CreateProjectTaskFactoryImpl;

type

    (*!--------------------------------------
     * Factory class for create project task that
     * initialize git repository but without actually
     * commit them.
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectNoCommitTaskFactory = class(TCreateProjectTaskFactory)
    protected
        function buildProjectTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; override;
    end;

implementation

uses

    DirectoryCreatorImpl,
    NullTaskImpl,
    CreateDirTaskImpl,
    CreateCompilerConfigsTaskImpl,
    CreateAppConfigsTaskImpl,
    CreateSessionJsonAppConfigsTaskImpl,
    CreateSessionIniAppConfigsTaskImpl,
    CreateSessionAppConfigsTaskImpl,
    CreateSessionDependenciesTaskImpl,
    CreateFileSessionDependenciesTaskImpl,
    CreateJsonFileSessionDependenciesTaskImpl,
    CreateIniFileSessionDependenciesTaskImpl,
    CreateCookieSessionDependenciesTaskImpl,
    CompositeAppConfigsTaskImpl,
    CreateAdditionalFilesTaskImpl,
    CreateShellScriptsTaskImpl,
    CreateAppBootstrapTaskImpl,
    InitGitRepoTaskImpl,
    CreateProjectTaskImpl,
    RegisterConfigDependencyTaskImpl,
    FileHelperAppendImpl,
    CompositeTaskImpl,
    BasicKeyGeneratorImpl;

    function TCreateProjectNoCommitTaskFactory.buildProjectTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TCreateProjectTask.create(
            TCreateDirTask.create(TDirectoryCreator.create()),
            TCreateShellScriptsTask.create(textFileCreator, contentModifier),
            TCompositeTask.create(
                TCompositeTask.create(
                    TCreateCompilerConfigsTask.create(textFileCreator, contentModifier),
                    TCompositeAppConfigsTask.create(
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
                        ),
                        TCreateAppConfigsTask.create(textFileCreator, contentModifier)
                    )
                ),
                TCompositeTask.create(
                    TRegisterConfigDependencyTask.create(
                        textFileCreator,
                        contentModifier,
                        TFileHelperAppender.create()
                    ),
                    TCreateSessionDependenciesTask.create(
                        TCreateFileSessionDependenciesTask.create(
                            TCreateJsonFileSessionDependenciesTask.create(
                                textFileCreator,
                                contentModifier,
                                TFileHelperAppender.create()
                            ),
                            TCreateIniFileSessionDependenciesTask.create(
                                textFileCreator,
                                contentModifier,
                                TFileHelperAppender.create()
                            )
                        ),
                        TCreateCookieSessionDependenciesTask.create(),
                        TNullTask.create()
                    )
                )
            ),
            TCreateAdditionalFilesTask.create(textFileCreator, contentModifier),
            TCreateAppBootstrapTask.create(textFileCreator, contentModifier),
            //replace git commit task with NullTaskImpl to disable Git commit
            TInitGitRepoTask.create(TNullTask.create())
        );
    end;

end.

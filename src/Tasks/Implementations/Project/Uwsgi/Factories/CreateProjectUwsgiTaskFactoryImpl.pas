(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateProjectUwsgiTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    CreateProjectTaskFactoryImpl,
    RegisterConfigDependencyTaskImpl,
    FileHelperAppendImpl,
    CompositeTaskImpl;

type

    (*!--------------------------------------
     * Factory class for create project task for
     * FastCGI web application
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectUwsgiTaskFactory = class(TCreateProjectTaskFactory)
    protected
        function buildProjectTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; override;
    end;

implementation

uses

    NullTaskImpl,
    DirectoryCreatorImpl,
    InitGitRepoTaskImpl,
    CommitGitRepoTaskImpl,
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
    CreateUwsgiAppBootstrapTaskImpl,
    CreateProjectTaskImpl,
    BasicKeyGeneratorImpl;

    function TCreateProjectUwsgiTaskFactory.buildProjectTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TCreateProjectTask.create(
            TCreateDirTask.create(TDirectoryCreator.create()),
            TCreateShellScriptsTask.create(textFileCreator, contentModifier, 'bin'),
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
            TCreateUwsgiAppBootstrapTask.create(textFileCreator, contentModifier),
            TInitGitRepoTask.create(TCommitGitRepoTask.create())
        );
    end;

end.

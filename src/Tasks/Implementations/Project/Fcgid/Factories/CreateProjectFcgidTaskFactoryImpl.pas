(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateProjectFcgidTaskFactoryImpl;

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
     * Factory class for create project task for
     * FastCGI web application running with mod_fcgid
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectFcgidTaskFactory = class(TCreateProjectTaskFactory)
    protected
        function buildProjectTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; override;
    end;

implementation

uses

    DirectoryCreatorImpl,
    InitGitRepoTaskImpl,
    CommitGitRepoTaskImpl,
    CreateDirTaskImpl,
    CreateAppConfigsTaskImpl,
    CreateAdditionalFilesTaskImpl,
    CreateShellScriptsTaskImpl,
    CreateFcgidAppBootstrapTaskImpl,
    CreateProjectTaskImpl,
    RegisterConfigDependencyTaskImpl,
    FileHelperAppendImpl,
    CompositeTaskImpl;

    function TCreateProjectFcgidTaskFactory.buildProjectTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TCreateProjectTask.create(
            TCreateDirTask.create(TDirectoryCreator.create()),
            TCreateShellScriptsTask.create(textFileCreator, contentModifier),
            TCompositeTask.create(
                TCreateAppConfigsTask.create(textFileCreator, contentModifier),
                TRegisterConfigDependencyTask.create(
                    textFileCreator,
                    contentModifier,
                    TFileHelperAppender.create()
                )
            ),
            TCreateAdditionalFilesTask.create(textFileCreator, contentModifier),
            TCreateFcgidAppBootstrapTask.create(textFileCreator, contentModifier),
            TInitGitRepoTask.create(TCommitGitRepoTask.create())
        );
    end;
end.

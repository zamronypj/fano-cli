(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDaemonProjectTaskFactoryImpl;

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
     * Factory class for create daemon project task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateDaemonProjectTaskFactory = class(TCreateProjectTaskFactory)
    protected
        function buildProjectTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; override;
    end;

implementation

uses

    DirectoryCreatorImpl,
    CreateDirTaskImpl,
    CreateAdditionalFilesTaskImpl,
    CreateShellScriptsTaskImpl,
    InitGitRepoTaskImpl,
    CommitGitRepoTaskImpl,
    CreateProjectTaskImpl;

    function TCreateDaemonProjectTaskFactory.buildProjectTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TCreateProjectTask.create(
            TCreateDirTask.create(TDirectoryCreator.create()),
            TCreateShellScriptsTask.create(textFileCreator, contentModifier, 'bin'),
            fProjectDepTaskFactory.build(),
            TCreateAdditionalFilesTask.create(textFileCreator, contentModifier),
            fBootstrapTaskFactory.build(),
            TInitGitRepoTask.create(TCommitGitRepoTask.create())
        );
    end;
end.

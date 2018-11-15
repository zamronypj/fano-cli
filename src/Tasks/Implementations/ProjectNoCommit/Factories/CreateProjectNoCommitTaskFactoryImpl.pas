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
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create project task that
     * initialize git repository but without actually
     * commit them.
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectNoCommitTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    TextFileCreatorIntf,
    TextFileCreatorImpl,
    DirectoryCreatorImpl,
    NullTaskImpl,
    CreateDirTaskImpl,
    CreateAppConfigsTaskImpl,
    CreateAdditionalFilesTaskImpl,
    CreateShellScriptsTaskImpl,
    CreateAppBootstrapTaskImpl,
    InitGitRepoTaskImpl,
    CreateProjectTaskImpl,
    InvRunCheckTaskImpl;

    function TCreateProjectNoCommitTaskFactory.build() : ITask;
    var textFileCreator : ITextFileCreator;
        createPrjTask : ITask;
    begin
        textFileCreator := TTextFileCreator.create();
        createPrjTask := TCreateProjectTask.create(
            TCreateDirTask.create(TDirectoryCreator.create()),
            TCreateShellScriptsTask.create(textFileCreator),
            TCreateAppConfigsTask.create(textFileCreator),
            TCreateAdditionalFilesTask.create(textFileCreator),
            TCreateAppBootstrapTask.create(textFileCreator),
            //replace git commit task with NullTaskImpl to disable Git commit
            TInitGitRepoTask.create(TNullTask.create())
        );

        //protect to avoid accidentally creating another project inside Fano-CLI
        //project directory structure
        result := TInvRunCheckTask.create(createPrjTask);
    end;

end.

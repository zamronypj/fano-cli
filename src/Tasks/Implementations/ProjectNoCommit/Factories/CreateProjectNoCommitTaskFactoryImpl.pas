(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
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
    NullTaskImpl,
    CreateDirTaskImpl,
    CreateAppConfigsTaskImpl,
    CreateAdditionalFilesTaskImpl,
    CreateShellScriptsTaskImpl,
    CreateAppBootstrapTaskImpl,
    InitGitRepoTaskImpl,
    CreateProjectTaskImpl;

    function TCreateProjectNoCommitTaskFactory.build() : ITask;
    begin
        result := TCreateProjectTask.create(
            TCreateDirTask.create(),
            TCreateShellScriptsTask.create(),
            TCreateAppConfigsTask.create(),
            TCreateAdditionalFilesTask.create(),
            TCreateAppBootstrapTask.create(),
            //replace git commit task with NullTaskImpl to disable Git commit
            TInitGitRepoTask.create(TNullTask.create())
        );
    end;

end.

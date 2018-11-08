(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateProjectTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create project task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    CreateDirTaskImpl,
    CreateAppConfigsTaskImpl,
    CreateAdditionalFilesTaskImpl,
    CreateShellScriptsTaskImpl,
    CreateAppBootstrapTaskImpl,
    InitGitRepoTaskImpl,
    CreateProjectTaskImpl;

    function TCreateProjectTaskFactory.build() : ITask;
    begin
        result := TCreateProjectTask.create(
            TCreateDirTask.create(),
            TCreateShellScriptsTask.create(),
            TCreateAppConfigsTask.create(),
            TCreateAdditionalFilesTask.create(),
            TCreateAppBootstrapTask.create(),
            TInitGitRepoTask.create()
        );
    end;

end.

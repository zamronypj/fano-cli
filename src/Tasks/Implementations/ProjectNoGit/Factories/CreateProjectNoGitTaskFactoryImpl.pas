(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateProjectNoGitTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create project task but
     * without initialize git repository
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectNoGitTaskFactory = class(TInterfacedObject, ITaskFactory)
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
    CreateProjectTaskImpl;

    function TCreateProjectNoGitTaskFactory.build() : ITask;
    begin
        result := TCreateProjectTask.create(
            TCreateDirTask.create(),
            TCreateShellScriptsTask.create(),
            TCreateAppConfigsTask.create(),
            TCreateAdditionalFilesTask.create(),
            //replace git task with NullTaskImpl to disable GIT
            TNullTask.create()
        );
    end;

end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateControllerTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create controller task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateControllerTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    CreateControllerTaskImpl;

    function TCreateControllerTaskFactory.build() : ITask;
    begin
        result := TCreateControllerTask.create(
            TCreateDirTask.create(),
            TCreateShellScriptsTask.create(),
            TCreateAppConfigsTask.create(),
            TCreateAdditionalFilesTask.create(),
            TCreateAppBootstrapTask.create(),
            TInitGitRepoTask.create(TCommitGitRepoTask.create())
        );
    end;

end.

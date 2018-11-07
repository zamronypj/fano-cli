(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit InfoTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf;
type

    (*!--------------------------------------
     * Task that display help information
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TInfoTask = class(TInterfacedObject, ITask)
    public
        function run() : ITask;
    end;

implementation

    function TInfoTask.run() : ITask;
    begin
        writeln('Fano CLI');
        writeln('Usage: fanocli [Task] [Task Parameters]');
        writeln('Available task:');
        writeln('   -cp [project name], --create-project=[project-name]');
        result := self;
    end;
end.

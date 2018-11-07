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
        writeln('Fano CLI 0.1, utility for Fano Web Framework');
        writeln('(c) Zamrony P. Juhara');
        writeln('Usage: fanocli [Task] [Task Parameters]');
        writeln('Available task:');
        writeln('   -h, --help display help information');
        writeln('   -cp [project name], --create-project=[project-name] create project');
        result := self;
    end;
end.

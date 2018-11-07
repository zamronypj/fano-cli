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

    contnrs,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that display help information
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TInfoTask = class(TInterfacedObject, ITask)
    private
        taskList : TFPHashList;
    public
        constructor create(const tasks : TFPHashList);
        function run() : ITask;
    end;

implementation

uses

    TaskItemTypes;

    constructor TInfoTask.create(const tasks : TFPHashList);
    begin
        taskList := tasks;
    end;

    function TInfoTask.run() : ITask;
    var i:integer;
        item : PTaskItem;
    begin
        writeln('Fano CLI 0.1, utility for Fano Web Framework');
        writeln('(c) Zamrony P. Juhara');
        writeln('Usage: fanocli [Task] [Task Parameters]');
        writeln('Available task:');
        for i:=0 to taskList.count-1 do
        begin
            item := taskList[i];
            writeln('   ', item^.shortOptionDesc, ', ', item^.longOptionDesc, ' ', item^.description);
        end;
        result := self;
    end;
end.

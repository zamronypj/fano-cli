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

    ListIntf,
    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that display help information
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TInfoTask = class(TInterfacedObject, ITask)
    private
        taskList : IList;
        function displayAvailableTask() : ITask;
    public
        constructor create(const tasks : IList);
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    TaskItemTypes;

    constructor TInfoTask.create(const tasks : IList);
    begin
        taskList := tasks;
    end;

    function TInfoTask.displayAvailableTask() : ITask;
    var i, taskCount : integer;
        item : PTaskItem;
    begin
        taskCount := taskList.count();
        for i:=0 to taskCount-1 do
        begin
            item := taskList.get(i);
            writeln('   ', item^.longOptionDesc, ' ', item^.description);
        end;
        result := self;
    end;

    function TInfoTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        writeln('Fano CLI v0.1, utility for Fano Framework');
        writeln('(c) Zamrony P. Juhara');
        writeln();
        writeln('Usage: fanocli [Task] [Task Parameters]');
        writeln();
        writeln('Available task:');
        writeln();
        result := displayAvailableTask();
    end;
end.

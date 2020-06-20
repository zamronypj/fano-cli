(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit GroupTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    TTaskArray = array of ITask;

    (*!--------------------------------------
     * Task that compose from other tasks
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TGroupTask = class(TInterfacedObject, ITask)
    private
        fTasks : TTaskArray;
    public
        constructor create(const tasks : array of ITask);
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

    function initTasks(const atasks : array of ITask) : TTaskArray;
    var i, len : integer;
    begin
        result := default(TTaskArray);
        len := high(atasks) - low(atasks) + 1;
        setLength(result, len);
        for i := 0 to len -1 do
        begin
            result[i] := atasks[i];
        end;
    end;

    function freeTasks(var atasks : TTaskArray) : TTaskArray;
    var i, len : integer;
    begin
        len := length(atasks);
        for i := 0 to len -1 do
        begin
            atasks[i] := nil;
        end;
        setLength(atasks, 0);
        atasks := nil;
        result := atasks;
    end;

    constructor TGroupTask.create(const tasks : array of ITask);
    begin
        fTasks := initTasks(tasks);
    end;

    destructor TGroupTask.destroy();
    begin
        fTasks := freeTasks(fTasks);
        inherited destroy();
    end;

    function TGroupTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var i, len : integer;
    begin
        len := length(fTasks);
        for i := 0 to len - 1 do
        begin
            fTasks[i].run(opt, longOpt);
        end;
        result := self;
    end;
end.

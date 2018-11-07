(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit fanoapp;

interface

{$MODE OBJFPC}
{$H+}

uses
    sysutils,
    classes,
    custapp,
    contnrs,
    TaskOptionsIntf,
    TaskIntf;

type

    TFanoCliApplication = class (TCustomApplication, ITaskOptions)
    private
        taskList : TFPHashList;

        procedure clearTasks();
    protected
        procedure doRun(); override;
    public
        constructor create(AOwner : TComponent); override;
        destructor destroy(); override;
        procedure registerTask(
            const shortOpt : char;
            const longOpt : string;
            const shortOptDesc : string;
            const longOptDesc : string;
            const desc : string;
            const task : ITask
        );
        function getTaskList() : TFPHashList;
    end;

implementation

uses

    TaskItemTypes;

resourcestring
    sErrTaskAlreadyRegistered = 'Task -%s --%s is already registered';


    constructor TFanoCliApplication.create(AOwner : TComponent);
    begin
        inherited create(AOwner);
        taskList := TFPHashList.create();
    end;

    procedure TFanoCliApplication.registerTask(
        const shortOpt : char;
        const longOpt : string;
        const shortOptDesc : string;
        const longOptDesc : string;
        const desc : string;
        const task : ITask
    );
    var item : PTaskItem;
    begin
        item := taskList.find(shortOpt);
        if (item <> nil) then
        begin
            raise Exception.createFmt(sErrTaskAlreadyRegistered, [shortOpt, longOpt]);
        end;

        new(item);
        item^.shortOption := shortOpt;
        item^.longOption := longOpt;
        item^.description := desc;
        item^.shortOptionDesc := shortOptDesc;
        item^.longOptionDesc := longOptDesc;
        item^.task := task;
        taskList.add(shortOpt, item);
    end;

    procedure TFanoCliApplication.clearTasks();
    var item : PTaskItem;
        i : integer;
    begin
        for i:= taskList.count-1 downto 0 do
        begin
            item := taskList[i];
            item^.task := nil;
            setLength(item^.longOption, 0);
            setLength(item^.description, 0);
            setLength(item^.shortOptionDesc, 0);
            setLength(item^.longOptionDesc, 0);
            dispose(item);
            taskList.delete(i);
        end;
    end;

    function TFanoCliApplication.getTaskList() : TFPHashList;
    begin
        result := taskList;
    end;

    destructor TFanoCliApplication.destroy();
    begin
        inherited destroy();
        clearTasks();
        freeAndNil(taskList);
    end;

    procedure TFanoCliApplication.doRun();
    var item : PTaskItem;
        i : integer;
    begin
        for i:=0 to taskList.count-1 do
        begin
            item := taskList[i];
            if (hasOption(item^.shortOption, item^.longOption)) then
            begin
                item^.task.run(self, item^.shortOption, item^.longOption);
                terminate();
                exit();
            end;
        end;

        if (taskList.count>0) then
        begin
            //default task is at zero-index
            item := taskList[0];
            item^.task.run(self, item^.shortOption, item^.longOption);
        end;
        terminate();
    end;

end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit FanoAppImpl;

interface

{$MODE OBJFPC}
{$H+}

uses
    sysutils,
    classes,
    custapp,
    ListIntf,
    TaskOptionsIntf,
    TaskListAwareIntf,
    TaskIntf;

type

    (*!------------------------------------------------------------
     * Main application
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------------------- *)
    TFanoCliApplication = class (TCustomApplication, ITaskOptions, ITaskListAware)
    private
        taskList : IList;

        procedure clearTasks();
        procedure tryRun();
    protected
        procedure doRun(); override;
    public
        constructor create(AOwner : TComponent); override;
        destructor destroy(); override;

        (*!------------------------------------------------------------
         * register task to application
         *-------------------------------------------------------------
         * @param longOpt long option value for example value of
         *        'create-project' will make the task available via
         *        --create-project option
         * @param desc description that is used
         *        to display descriptive information how to use
         *        task when displaying help.
         * @param task actual instance that will handle task
         *------------------------------------------------------------- *)
        procedure registerTask(
            const longOpt : shortstring;
            const desc : string;
            const task : ITask
        );
        function getTaskList() : IList;
    end;

implementation

uses
    HashListImpl,
    TaskItemTypes;

resourcestring
    sErrTaskAlreadyRegistered = 'Task -%s --%s is already registered';


    constructor TFanoCliApplication.create(AOwner : TComponent);
    begin
        inherited create(AOwner);
        taskList := THashList.create();
    end;

    procedure TFanoCliApplication.registerTask(
        const longOpt : shortstring;
        const desc : string;
        const task : ITask
    );
    var item : PTaskItem;
    begin
        item := taskList.find(longOpt);
        if (item <> nil) then
        begin
            raise Exception.createFmt(sErrTaskAlreadyRegistered, [longOpt]);
        end;

        new(item);
        item^.longOption := longOpt;
        item^.description := desc;
        item^.task := task;
        taskList.add(longOpt, item);
    end;

    procedure TFanoCliApplication.clearTasks();
    var item : PTaskItem;
        i, taskCount : integer;
    begin
        taskCount := taskList.count();
        for i:= taskCount-1 downto 0 do
        begin
            item := taskList.get(i);
            item^.task := nil;
            setLength(item^.longOption, 0);
            setLength(item^.description, 0);
            dispose(item);
            taskList.delete(i);
        end;
    end;

    function TFanoCliApplication.getTaskList() : IList;
    begin
        result := taskList;
    end;

    destructor TFanoCliApplication.destroy();
    begin
        inherited destroy();
        clearTasks();
        taskList := nil;
    end;

    procedure TFanoCliApplication.tryRun();
    var item : PTaskItem;
        i, taskCount : integer;
    begin
        taskCount := taskList.count();
        for i:=0 to taskCount-1 do
        begin
            item := taskList.get(i);
            if (hasOption(item^.longOption)) then
            begin
                item^.task.run(self, item^.longOption);
                terminate();
                exit();
            end;
        end;

        if (taskCount > 0) then
        begin
            //default task is at zero-index
            item := taskList.get(0);
            item^.task.run(self, item^.longOption);
        end;
        terminate();
    end;

    procedure TFanoCliApplication.doRun();
    begin
        try
            tryRun();
        except
            terminate();
            raise;
        end;
    end;
end.

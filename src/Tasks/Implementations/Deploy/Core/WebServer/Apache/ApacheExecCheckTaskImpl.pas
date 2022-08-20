(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheExecCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorTaskImpl;

type

    (*!--------------------------------------
     * Task that execute task based on what
     * Apache on Debian/Fedora
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheExecCheckTask = class(TDecoratorTask)
    private
        fApache2Task : ITask;
        fHttpdTask : ITask;
    public
        constructor create(const task : ITask);
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils,
    HttpdExecCheckTaskImpl,
    Apache2ExecCheckTaskImpl;

    constructor TApacheExecCheckTask.create(const task : ITask);
    begin
        inherited create(task);
        fApache2Task := TApache2ExecCheckTask.create(task);
        fHttpdTask := THttpdExecCheckTask.create(task);
    end;

    function TApacheExecCheckTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        if directoryExists('/etc/httpd') then
        begin
            fHttpdTask.run(opt, longOpt);
        end else
        begin
            fApache2Task.run(opt, longOpt);
        end;
        result := self;
    end;
end.

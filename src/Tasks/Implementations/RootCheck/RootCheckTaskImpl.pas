(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit RootCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorTaskImpl;

type

    (*!--------------------------------------
     * Task that run other task only if
     * current task is run as root
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TRootCheckTask = class(TDecoratorTask)
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    SysUtils,
    BaseUnix;

resourcestring

    sErrMustRunAsRoot = 'Cannot run privileged task as ordinary user. Try run with sudo.';

    function TRootCheckTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //get effective user id, 0 mean root
        if fpgeteuid() = 0 then
        begin
            actualTask.run(opt, longOpt);
        end else
        begin
            writeln(sErrMustRunAsRoot);
        end;
        result := self;
    end;
end.

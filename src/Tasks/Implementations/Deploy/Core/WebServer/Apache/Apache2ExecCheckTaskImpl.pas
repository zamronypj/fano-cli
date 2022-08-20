(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit Apache2ExecCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ExecutableCheckTaskImpl;

type

    (*!--------------------------------------
     * Task that check if Apache is installed (Debian)
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApache2ExecCheckTask = class(TExecutableCheckTask)
    public
        constructor create(const task : ITask);

    end;

implementation

    constructor TApache2ExecCheckTask.create(const task : ITask);
    begin
        inherited create(task, 'apache2', ['-v']);
    end;

end.

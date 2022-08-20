(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit HttpdExecCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ExecutableCheckTaskImpl;

type

    (*!--------------------------------------
     * Task that check if Apache is installed (Fedora)
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    THttpdExecCheckTask = class(TExecutableCheckTask)
    public
        constructor create(const task : ITask);

    end;

implementation

    constructor THttpdExecCheckTask.create(const task : ITask);
    begin
        inherited create(task, 'httpd', ['-v']);
    end;

end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit NginxExecCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ExecutableCheckTaskImpl;

type

    (*!--------------------------------------
     * Task that check if nginx is installed
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNginxExecCheckTask = class(TExecutableCheckTask)
    public
        constructor create(const task : ITask);

    end;

implementation

    constructor TNginxExecCheckTask.create(const task : ITask);
    begin
        inherited create(task, 'nginx', ['-v']);
    end;

end.

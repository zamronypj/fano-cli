(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit NullTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf;

type

    (*!--------------------------------------
     * Task that does nothing
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNullTask = class(TInterfacedObject, ITask)
    public
        function run() : ITask;
    end;

implementation

    function TNullTask.run() : ITask;
    begin
        result := self;
    end;
end.

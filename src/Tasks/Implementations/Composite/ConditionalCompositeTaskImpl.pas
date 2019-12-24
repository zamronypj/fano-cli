(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ConditionalCompositeTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CompositeTaskImpl;

type

    (*!--------------------------------------
     * Task that run first task if condition is met
     * otherwise run second task
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TConditionalCompositeTask = class abstract (TCompositeTask)
    protected
        function condition(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : boolean; virtual; abstract;
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    function TConditionalCompositeTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        if condition(opt, longOpt) then
        begin
            firstTask.run(opt, longOpt);
        end else
        begin
            secondTask.run(opt, longOpt);
        end;
        result := self;
    end;
end.

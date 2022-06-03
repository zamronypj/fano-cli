(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WithMultiRouteTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ConditionalCompositeTaskImpl;

type

    (*!--------------------------------------
     * Task that run first task if multiple methods
     * creation or second task if single method
     *----------------------------------------
     * Single method
     *    --method=GET
     * Multiple methods
     *    --method=GET,POST
     *----------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TWithMultiRouteTask = class(TConditionalCompositeTask)
    protected
        function condition(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : boolean; override;
    end;

implementation

uses

    sysutils;

    function TWithMultiRouteTask.condition(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : boolean;
    var routeMethods : TStringArray;
    begin
        routeMethods := lowerCase(opt.getOptionValueDef('method', 'get')).split(',');
        result := (length(routeMethods) > 1);
    end;
end.

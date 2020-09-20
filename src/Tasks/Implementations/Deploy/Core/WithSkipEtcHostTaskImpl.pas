(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WithSkipEtcHostTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ConditionalCompositeTaskImpl;

type

    (*!--------------------------------------
     * Task that run first task if --skip-etc-hosts
     * parameter to skip domain entry creation
     * in /etc/hosts or second task if default behavior
     *----------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TWithSkipEtcHostTask = class(TConditionalCompositeTask)
    protected
        function condition(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : boolean; override;
    end;

implementation

uses

    sysutils;

    function TWithSkipEtcHostTask.condition(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : boolean;
    var routeMethods : TStringArray;
    begin
        result := opt.hasOption('skip-etc-hosts');
    end;
end.

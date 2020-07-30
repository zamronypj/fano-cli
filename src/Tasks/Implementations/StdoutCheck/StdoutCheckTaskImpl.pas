(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit StdoutCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ConditionalCompositeTaskImpl;

type

    (*!--------------------------------------
     * Task runs first task only if
     * there is --stdout command line option otherwise
     * it runs second task
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TStdoutCheckTask = class(TConditionalCompositeTask)
    protected
        function condition(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : boolean; override;
    end;

implementation

    function TStdoutCheckTask.condition(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : boolean;
    begin
        result := opt.hasOption('stdout');
    end;
end.

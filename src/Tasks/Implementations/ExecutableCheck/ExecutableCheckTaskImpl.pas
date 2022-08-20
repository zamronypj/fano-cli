(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ExecutableCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorTaskImpl;

type

    (*!--------------------------------------
     * Task that check if particular executable
     * installed and can be run
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TExecutableCheckTask = class(TDecoratorTask)
    private
        fBin : string;
        fParams : array of string;
    public
        constructor create(
            const task : ITask;
            const aBin : string;
            const aParams : array of string
        );
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils,
    strformats,
    process;

resourcestring

    sBinNotInstalled = 'Cannot run task. Binary %s is not installed.';
    sRunWithHelp = 'Run with --help option to view available task.';

    constructor TExecutableCheckTask.create(
        const task : ITask;
        const aBin : string;
        const aParams : array of string
    );
    var i : integer;
    begin
        inherited create(task);
        fBin := aBin;
        SetLength(fParams, length(aParams));
        for i:= low(aParams) to High(aParams) do
        begin
            fParams[i] := aParams[i];
        end;
    end;

    function TExecutableCheckTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var outstr : string;
    begin
        if RunCommand(fBin, fParams, outstr) then
        begin
            fActualTask.run(opt, longOpt);
        end else
        begin
            writeln(format(sBinNotInstalled, [formatColor(fBin, TXT_GREEN)]));
            writeln(sRunWithHelp);
        end;
        result := self;
    end;
end.

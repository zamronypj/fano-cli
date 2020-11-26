(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DirFileMinifierTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that run minify one or more files
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDirFileMinifierTask = class(TInterfacedObject, ITask)
    private
        fSingleMinifierTask : ITask;
        fMultipleMinifierTask : ITask;
    public
        constructor create(
            const aSingleMinifierTask : ITask;
            const aMultipleMinifierTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils;

resourcestring

    sErrPathNotFound = 'Path %s not found';

    constructor TDirFileMinifierTask.create(
        const aSingleMinifierTask : ITask;
        const aMultipleMinifierTask : ITask
    );
    begin
        fSingleMinifierTask := aSingleMinifierTask;
        fMultipleMinifierTask := aMultipleMinifierTask;
    end;

    destructor TDirFileMinifierTask.destroy();
    begin
        fSingleMinifierTask := nil;
        fMultipleMinifierTask := nil;
        inherited destroy();
    end;

    function TDirFileMinifierTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var jsPath : string;
    begin
        jsPath := opt.getOptionValueDef(longOpt, getCurrentDir());
        if directoryExists(jsPath) then
        begin
            fMultipleMinifierTask.run(opt, longOpt);
        end else
        if fileExists(jsPath) then
        begin
            fSingleMinifierTask.run(opt, longOpt);
        end else
        begin
            writeln(format(sErrPathNotFound, [jsPath]));
        end;
        result := self;
    end;
end.

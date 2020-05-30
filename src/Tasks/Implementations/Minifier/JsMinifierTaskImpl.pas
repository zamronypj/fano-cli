(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit JsMinifierTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorTaskImpl;

type

    (*!--------------------------------------
     * Task that run minify one or more javascript files
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TJsMinifierTask = class(TInterfacedObject, ITask)
    private
        fSingleJsMinifierTask : ITask;
        fMultipleJsMinifierTask : ITask;
    public
        constructor create(
            const aSingleJsMinifierTask : ITask;
            const aMultipleJsMinifierTask : ITask
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

    constructor TJsMinifierTask.create(
        const aSingleJsMinifierTask : ITask;
        const aMultipleJsMinifierTask : ITask
    );
    begin
        fSingleJsMinifierTask := aSingleJsMinifierTask;
        fMultipleJsMinifierTask := aMultipleJsMinifierTask;
    end;

    destructor TJsMinifierTask.destroy();
    begin
        fSingleJsMinifierTask := nil;
        fMultipleJsMinifierTask := nil;
        inherited destroy();
    end;

    function TJsMinifierTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var jsPath : string;
    begin
        jsPath := opt.getOptionValueDef(longOpt, getCurrentDir());
        if directoryExists(jsPath) then
        begin
            fMultipleJsMinifierTask.run(opt, longOpt);
        end else
        if fileExists(jsPath) then
        begin
            fSingleJsMinifierTask.run(opt, longOpt);
        end else
        begin
            writeln(format(sErrPathNotFound, [jsPath]));
        end;
        result := self;
    end;
end.

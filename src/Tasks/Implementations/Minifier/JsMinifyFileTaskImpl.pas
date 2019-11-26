(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit JsMinifyFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorTaskImpl,
    jsminifier;

type

    (*!--------------------------------------
     * Task that minify single JavaScript file
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TJsMinifyFileTask = class(TInterfacedObject, ITask)
    private
        procedure minifyToStdout(
            const minifier : TJSONMinifier;
            const jsInputPath : string
        );
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    Classes,
    SysUtils;

    procedure TJsMinifyFileTask.minifyToStdout(
        const minifier : TJSONMinifier;
        const jsInputPath : string
    );
    var str : TStringStream;
        afile : TFileStream;
    begin
        afile := TFileStream.create(jsInputPath, fmOpenRead);
        try
            str := TStringStream.create('');
            try
                minifier.execute(afile, str);
                write(str.datastring);
            finally
                str.free();
            end;
        finally
            afile.free();
        end;
    end;

    function TJsMinifyFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var minifier : TJSONMinifier;
        jsInputPath, jsOutputPath : string;
    begin
        minifier := TJSONMinifier.create(nil);
        try
            jsInputPath := opt.getOptionValue(longOpt);
            jsOutputPath := changeFileExt(jsInputPath, '.min.js');
            if opt.hasOption('output') then
            begin
                jsOutputPath := opt.getOptionValue('output');
            end;

            if (jsOutputPath = 'stdout') then
            begin
                minifyToStdout(minifier, jsInputPath);
            end else
            begin
                minifier.execute(jsInputPath, jsOutputPath);
            end;

            result := self;
        finally
            minifier.free();
        end;
    end;
end.

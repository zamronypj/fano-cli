(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit JsMinifyDirTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorTaskImpl,
    SysUtils,
    jsminifier;

type

    (*!--------------------------------------
     * Task that minify all JavaScript files in a directory
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TJsMinifyDirTask = class(TInterfacedObject, ITask)
    private
        function getAllJsFilesInDir(const dir : string) : TStringArray;

        procedure minifyToStdout(
            const minifier : TJSONMinifier;
            const jsInputPath : string
        );
        procedure minifyMultipleFilesToStdOut(
            const minifier : TJSONMinifier;
            const jsFiles : TStringArray
        );

        procedure minifyMultipleFiles(
            const minifier : TJSONMinifier;
            const jsFiles : TStringArray
        );
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    Classes;

    function TJsMinifyDirTask.getAllJsFilesInDir(const dir : string) : TStringArray;
    Var info : TSearchRec;
        fileIdx : integer;
    begin
        result := default(TStringArray);
        fileIdx := 0;
        setLength(result, 50);
        if findFirst(dir + '*.js', faAnyFile, info) = 0 then
        begin
            try
                repeat
                    if (fileIdx > length(result) - 1) then
                    begin
                        setLength(result, length(result) + 50);
                    end;
                    result[fileIdx] := dir + info.name;
                    inc(fileIdx);
                until findNext(info) <> 0;

                if (fileIdx < length(result)) then
                begin
                    setLength(result, fileIdx);
                end;

            finally
                findClose(info);
            end;
        end;
    end;

    procedure TJsMinifyDirTask.minifyMultipleFiles(
        const minifier : TJSONMinifier;
        const jsFiles : TStringArray
    );
    var i, len : integer;
    begin
        len := length(jsFiles);
        for i := 0 to len -1 do
        begin
            minifier.execute(jsFiles[i], changeFileExt(jsFiles[i], '.min.js'));
        end;
    end;

    procedure TJsMinifyDirTask.minifyMultipleFilesToStdOut(
        const minifier : TJSONMinifier;
        const jsFiles : TStringArray
    );
    var i, len : integer;
    begin
        len := length(jsFiles);
        for i := 0 to len -1 do
        begin
            minifyToStdOut(minifier, jsFiles[i]);
        end;
    end;

    procedure TJsMinifyDirTask.minifyToStdout(
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
                writeln(str.datastring);
            finally
                str.free();
            end;
        finally
            afile.free();
        end;
    end;

    function TJsMinifyDirTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var minifier : TJSONMinifier;
        jsInputPath, jsOutputPath : string;
        jsFiles : TStringArray;
    begin
        minifier := TJSONMinifier.create(nil);
        try
            jsInputPath := opt.getOptionValueDef(longOpt, getCurrentDir());
            jsOutputPath := '';

            if opt.hasOption('output') then
            begin
                jsOutputPath := opt.getOptionValue('output');
            end;

            jsFiles := getAllJsFilesInDir(IncludeTrailingPathDelimiter(jsInputPath));

            if (jsOutputPath = 'stdout') then
            begin
                minifyMultipleFilesToStdOut(minifier, jsFiles);
            end else
            begin
                if (jsOutputPath = '') then
                begin
                    minifyMultipleFiles(minifier, jsFiles);
                end else
                begin
                    minifier.execute(jsFiles, jsOutputPath);
                end;
            end;

            result := self;
        finally
            minifier.free();
        end;
    end;
end.

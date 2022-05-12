(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit MinifyDirTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    MinifierIntf,
    FileContentReaderIntf,
    SysUtils;

type

    (*!--------------------------------------
     * Task that minify all JavaScript files in a directory
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TMinifyDirTask = class(TInterfacedObject, ITask)
    private
        fMinifier : IMinifier;
        fFileReader : IFileContentReader;

        function getAllFilesInDir(const dir : string) : TStringArray;

        procedure minifyToStdout(
            const inputPath : string
        );
        procedure minifyMultipleFilesToStdOut(
            const jsFiles : TStringArray
        );

        procedure minifyMultipleFiles(
            const jsFiles : TStringArray
        );
        procedure minifyMultipleFilesToSingleFile(
            const jsFiles : TStringArray;
            const outputPath : string
        );
    public
        constructor create(
            const minifier : IMinifier;
            const fileReader  : IFileContentReader
        );

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    Classes;

    constructor TMinifyDirTask.create(
        const minifier : IMinifier;
        const fileReader  : IFileContentReader
    );
    begin
        fMinifier := minifier;
        fFileReader := fileReader;
    end;

    function TMinifyDirTask.getAllFilesInDir(const dir : string) : TStringArray;
    Var info : TSearchRec;
        fileIdx : integer;
    begin
        result := default(TStringArray);
        fileIdx := 0;
        setLength(result, 50);
        if findFirst(dir + '*.' + fMinifier.contentType(), faAnyFile, info) = 0 then
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

    procedure TMinifyDirTask.minifyMultipleFiles(
        const jsFiles : TStringArray
    );
    var i, len : integer;
    begin
        len := length(jsFiles);
        for i := 0 to len -1 do
        begin
            fMinifier.minifyFile(
                jsFiles[i],
                changeFileExt(jsFiles[i], '.min.' + fMinifier.contentType())
            );
        end;
    end;

    procedure TMinifyDirTask.minifyMultipleFilesToStdOut(
        const jsFiles : TStringArray
    );
    var i, len : integer;
    begin
        len := length(jsFiles);
        for i := 0 to len -1 do
        begin
            minifyToStdOut(jsFiles[i]);
        end;
    end;

    procedure TMinifyDirTask.minifyMultipleFilesToSingleFile(
        const jsFiles : TStringArray;
        const outputPath : string
    );
    var i, len : integer;
        aMinifiedContent : string;
        fs : TFileStream;
    begin
        fs := TFileStream.create(outputPath, fmCreate);
        try
            len := length(jsFiles);
            for i := 0 to len -1 do
            begin
                aMinifiedContent := fMinifier.minify(fFileReader.read(jsFiles[i]));
                fs.writeBuffer(aMinifiedContent[1], length(aMinifiedContent));
            end;
        finally
            fs.free();
        end;
    end;

    procedure TMinifyDirTask.minifyToStdout(const inputPath : string);
    begin
        writeln(fMinifier.minify(fFileReader.read(inputPath)));
    end;

    function TMinifyDirTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var inputPath, outputPath : string;
        files : TStringArray;
    begin
        inputPath := opt.getOptionValueDef(longOpt, getCurrentDir());
        outputPath := '';

        if opt.hasOption('output') then
        begin
            outputPath := opt.getOptionValue('output');
        end;

        files := getAllFilesInDir(IncludeTrailingPathDelimiter(inputPath));

        if (outputPath = 'stdout') then
        begin
            minifyMultipleFilesToStdOut(files);
        end else
        begin
            if (outputPath = '') then
            begin
                minifyMultipleFiles(files);
            end else
            begin
                minifyMultipleFilesToSingleFile(files, outputPath);
            end;
        end;

        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit MinifyFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    MinifierIntf,
    FileContentReaderIntf;

type

    (*!--------------------------------------
     * Task that minify single file
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TMinifyFileTask = class(TInterfacedObject, ITask)
    private
        fMinifier : IMinifier;
        fFileReader : IFileContentReader;

        procedure minifyToStdout(const inputPath : string);
    public
        constructor create(
            const minifier : IMinifier;
            const fileReader : IFileContentReader
        );

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    Classes,
    SysUtils;

    constructor TMinifyFileTask.create(
        const minifier : IMinifier;
        const fileReader : IFileContentReader
    );
    begin
        fMinifier := minifier;
        fFileReader := fileReader;
    end;

    procedure TMinifyFileTask.minifyToStdout(const inputPath : string);
    begin
        write(fMinifier.minify(fFileReader.read(inputPath)));
    end;

    function TMinifyFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var inputPath, outputPath : string;
    begin
        inputPath := opt.getOptionValue(longOpt);
        outputPath := changeFileExt(inputPath, '.min.' + fMinifier.contentType());
        if opt.hasOption('output') then
        begin
            outputPath := opt.getOptionValue('output');
        end;

        if (outputPath = 'stdout') then
        begin
            minifyToStdout(inputPath);
        end else
        begin
            fMinifier.minifyFile(inputPath, outputPath);
        end;

        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit LazarusTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that generate Lazarus Project configuration
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TLazarusTask = class(TCreateFileTask)
    private
        procedure createProjectLPIFile(const baseDir: string);

    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    SysUtils,
    Classes,
    Dom,
    XMLRead,
    XMLWrite;

    procedure TLazarusTask.createProjectLPIFile(const baseDir: string);
    var
        lpi: TXMLDocument;
        lpiStream : TStringStream;
        {$INCLUDE src/Tasks/Implementations/Lazarus/Includes/app.lpi.inc}
    begin
        lpiStream := TStringStream.create(strAppLpi);
        try
            try
                ReadXMLFile(lpi, lpiStream);
                // todo: add more files
                writeXMLFile(lpi, baseDir + '/app.lpi');
            finally
                lpi.free();
            end;
        finally
            lpiStream.free();
        end;
    end;

    function TLazarusTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createProjectLPIFile(baseDirectory);
        result := self;
    end;
end.

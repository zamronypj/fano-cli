(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit FileHelperImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    FileContentReaderIntf,
    FileContentWriterIntf;

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to read file content to string
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TFileHelper = class(TInterfacedObject, IFileContentReader, IFileContentWriter)
    private
        function tryRead(const filename : string) : string;
        procedure tryWrite(const filename : string; const content : string);
    public
        function read(const filename : string) : string;
        procedure write(const filename : string; const content : string);
    end;

implementation

uses

    SysUtils,
    Classes;

    function TFileHelper.tryRead(const filename : string) : string;
    var fstream : TFileStream;
        strStream : TStringStream;
    begin
        fstream := TFileStream.create(filename, fmOpenRead);
        strStream := TStringStream.create('');
        try
            strStream.copyfrom(fstream, fstream.size);
            result := strStream.dataString;
        finally
            fstream.free();
            strStream.free();
        end;
    end;

    function TFileHelper.read(const filename : string) : string;
    begin
        try
            result := tryRead(filename);
        except
            on e: EInOutError do
            begin
                //default EInOutError not very clear as it
                //does not include filename information, here we
                //modify its message to make it more clear
                raise EInOutError.create(e.message + ' File:' + filename);
            end;
        end;
    end;

    procedure TFileHelper.tryWrite(const filename : string; const content : string);
    var fstream : TFileStream;
        strStream : TStringStream;
    begin
        fstream := TFileStream.create(filename, fmCreate);
        strStream := TStringStream.create(content);
        try
            fstream.copyfrom(strStream, strStream.size);
        finally
            fstream.free();
            strStream.free();
        end;
    end;

    procedure TFileHelper.write(const filename : string; const content : string);
    begin
        try
            tryWrite(filename, content);
        except
            on e: EInOutError do
            begin
                //default EInOutError not very clear as it
                //does not include filename information, here we
                //modify its message to make it more clear
                raise EInOutError.create(e.message + ' File:' + filename);
            end;
        end;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit FileHelperAppendImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    FileContentAppenderIntf,
    FileHelperImpl;

type

    (*!--------------------------------------
     * class that having capability
     * to append string to file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TFileHelperAppender = class(TFileHelper, IFileContentAppender)
    private
        function getFileMode(const filename : string) : word;
        procedure tryAppend(const filename : string; const content : string);
    public
        procedure append(const filename : string; const content : string);
    end;

implementation

uses

    SysUtils,
    Classes;

    function TFileHelperAppender.getFileMode(const filename : string) : word;
    begin
        if (fileExists(filename)) then
        begin
            result := fmOpenWrite;
        end else
        begin
            result := fmCreate;
        end;
    end;

    procedure TFileHelperAppender.tryAppend(const filename : string; const content : string);
    var fstream : TFileStream;
        strStream : TStringStream;
    begin
        fstream := TFileStream.create(filename, getFileMode(filename));
        strStream := TStringStream.create(content);
        try
            fstream.seek(0, soFromEnd);
            fstream.copyfrom(strStream, strStream.size);
        finally
            fstream.free();
            strStream.free();
        end;
    end;

    procedure TFileHelperAppender.append(const filename : string; const content : string);
    begin
        try
            tryAppend(filename, content);
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

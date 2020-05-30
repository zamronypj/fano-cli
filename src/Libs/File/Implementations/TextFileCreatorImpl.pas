(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit TextFileCreatorImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TextFileCreatorIntf;

type

    (*!--------------------------------------
     * Helper class that create text file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TTextFileCreator = class(TInterfacedObject, ITextFileCreator)
    protected
        function modifyContent(const content : string) : string; virtual;
    public
        procedure createTextFile(const filename : string; const content : string);
    end;

implementation

uses

    sysutils,
    classes;

    function TTextFileCreator.modifyContent(const content : string) : string;
    begin
        result := content;
    end;

    procedure TTextFileCreator.createTextFile(const filename : string; const content : string);
    var fStream : TFileStream;
        str : TStringStream;
    begin
        fStream := TFileStream.create(filename, fmCreate);
        str := TStringStream.create(modifyContent(content));
        try
            fStream.copyFrom(str, str.size);
        finally
            str.free();
            fStream.free();
        end;
    end;
end.

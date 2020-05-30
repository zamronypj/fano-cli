(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BasicKeyGeneratorImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    SysUtils,
    KeyGeneratorIntf;

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to generate random key
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBasicKeyGenerator = class(TInterfacedObject, IKeyGenerator)
    private
        function readRandomBytes(const numberOfBytes : integer) : TBytes;
        function encodeB64(aob: TBytes): string;
    public
        function generate(const len : integer; const prefix : string = '') : string;
    end;

implementation

uses

    Classes,
    Base64,
    BaseUnix;

    function TBasicKeyGenerator.readRandomBytes(const numberOfBytes : integer) : TBytes;
    var fs : TFileStream;
        bytes : TBytes;
    begin
        fs := TFileStream.create('/dev/urandom', fmOpenRead);
        try
            setLength(bytes, numberOfBytes);
            fs.readBuffer(bytes[0], numberOfBytes);
            result := bytes;
        finally
            fs.free();
        end;
    end;

    (*!------------------------------------------------
     * encode array of bytes to Base64 string
     *-------------------------------------------------
     * @param aob array of bytes
     * @return Base64 encoded string
     *-------------------------------------------------
     * @author: howardpc
     * @credit: https://forum.lazarus.freepascal.org/index.php?topic=23646.0
     *-------------------------------------------------*)
    function TBasicKeyGenerator.encodeB64(aob: TBytes): string;
    var
        i: integer;
        tmp: string;
    begin
        setLength(tmp, length(aob));
        for i := low(aob) to high(aob) do
        begin
            tmp[i+1] := char(aob[i]);
        end;
        result := encodeStringBase64(tmp);
    end;

    function TBasicKeyGenerator.generate(const len : integer; const prefix : string = '') : string;
    begin
        result := prefix + encodeB64(readRandomBytes(len));
    end;

end.

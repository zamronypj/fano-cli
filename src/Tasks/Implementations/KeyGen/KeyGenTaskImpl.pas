(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit KeyGenTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    SysUtils;

type

    (*!--------------------------------------
     * Task that generate random key
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TKeyGenTask = class(TInterfacedObject, ITask)
    private
        function readRandomBytes(const numberOfBytes : integer) : TBytes;
        function encodeB64(aob: TBytes): string;
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    Classes,
    Base64,
    BaseUnix;


    function TKeyGenTask.readRandomBytes(const numberOfBytes : integer) : TBytes;
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
    function TKeyGenTask.encodeB64(aob: TBytes): string;
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

    function TKeyGenTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var numberOfBytes : integer;
    begin
        numberOfBytes := strToInt(opt.getOptionValueDef(longOpt, '64'));
        write(encodeB64(readRandomBytes(numberOfBytes)));
        result := self;
    end;
end.

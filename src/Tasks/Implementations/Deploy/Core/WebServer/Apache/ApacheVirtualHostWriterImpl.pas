(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheVirtualHostWriterImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    VirtualHostWriterIntf;

type

    (*!--------------------------------------
     * Task that creates Apache web server virtual host file
     * in Debian, Fedora Linux and FreeBSD
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheVirtualHostWriter = class(TInterfacedObject, IVirtualHostWriter)
    private
        fVhostWriters : TList;
    public
        constructor create();
        destructor destroy(); override;
        procedure addWriter(const dir : string; const writer : IVirtualHostWriter);
        procedure writeVhost(
            const serverName : string;
            const vhostTpl : string;
            const cntModifier : IContentModifier
        );
    end;

implementation

uses

    SysUtils;

type

    TVhostWriter = record
        dir : string;
        writer : IVirtualHostWriter;
    end;

    PVhostWriter = ^TVhostWriter;

    constructor TApacheVirtualHostWriter.create();
    begin
        fVhostWriters := TList.create();
    end;

    destructor TApacheVirtualHostWriter.destroy();
    begin
        fVhostWriters.free();
        inherited destroy();
    end;

    procedure TApacheVirtualHostWriter.addWriter(const dir : string; const writer : IVirtualHostWriter);
    var vhost : PVhostWriter;
    begin
        new(vhost);
        vhost^.dir := dir;
        vhost^.writer := writer;
        fVhostWriters.add(vhost);
    end;

    procedure TApacheVirtualHostWriter.writeVhost(
        const serverName : string;
        const vhostTpl : string;
        const cntModifier : IContentModifier);
    var vhostWriter : PVhostWriter;
    begin
        for i:=0 to fVhostWriters.count-1 do
        begin
            vhostWriter := fVHostWriter[i];

            if directoryExists(vhostWriter^.dir) then
            begin
                vhostWriter^.writer.writeVhost(serverName, vhostTpl, cntModifier);
                break;
            end;
        end;
    end;

end.

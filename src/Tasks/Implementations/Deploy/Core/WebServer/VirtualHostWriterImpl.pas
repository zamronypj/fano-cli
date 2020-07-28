(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit VirtualHostWriterImpl;

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
    TVirtualHostWriter = class(TInterfacedObject, IVirtualHostWriter)
    private
        fVhostWriters : TList;
        procedure cleanupVhosts();
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

    constructor TVirtualHostWriter.create();
    begin
        fVhostWriters := TList.create();
    end;

    procedure TVirtualHostWriter.cleanupVhosts();
    var i : integer;
        vhost : PVhostWriter;
    begin
        for i := fVhostWriters.count - 1 downto 0 do
        begin
            vhost := fVhostWriters[i];
            dispose(vhost);
            fVhostWriters.delete(i);
        end;
    end;

    destructor TVirtualHostWriter.destroy();
    begin
        cleanupVhosts();
        fVhostWriters.free();
        inherited destroy();
    end;

    procedure TVirtualHostWriter.addWriter(const dir : string; const writer : IVirtualHostWriter);
    var vhost : PVhostWriter;
    begin
        new(vhost);
        vhost^.dir := dir;
        vhost^.writer := writer;
        fVhostWriters.add(vhost);
    end;

    procedure TVirtualHostWriter.writeVhost(
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

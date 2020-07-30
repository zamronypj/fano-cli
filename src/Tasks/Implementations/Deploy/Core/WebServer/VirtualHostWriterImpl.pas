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

    Classes,
    TaskOptionsIntf,
    ContentModifierIntf,
    VirtualHostWriterIntf,
    DirectoryExistsIntf;

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
        fDirExists : IDirectoryExists;
        procedure cleanupVhosts();
    public
        constructor create(const dirExists : IDirectoryExists);
        destructor destroy(); override;
        function addWriter(const dir : string; const writer : IVirtualHostWriter) : TVirtualHostWriter;
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

    constructor TVirtualHostWriter.create(const dirExists : IDirectoryExists);
    begin
        fDirExists := dirExists;
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
        fDirExists := nil;
        inherited destroy();
    end;

    function TVirtualHostWriter.addWriter(const dir : string; const writer : IVirtualHostWriter) : TVirtualHostWriter;
    var vhost : PVhostWriter;
    begin
        new(vhost);
        vhost^.dir := dir;
        vhost^.writer := writer;
        fVhostWriters.add(vhost);
        result := self;
    end;

    procedure TVirtualHostWriter.writeVhost(
        const serverName : string;
        const vhostTpl : string;
        const cntModifier : IContentModifier);
    var vhostWriter : PVhostWriter;
        i : integer;
    begin
        for i:=0 to fVhostWriters.count-1 do
        begin
            vhostWriter := fVHostWriters[i];
            if fDirExists.dirExists(vhostWriter^.dir) then
            begin
                vhostWriter^.writer.writeVhost(serverName, vhostTpl, cntModifier);
                break;
            end;
        end;
    end;

end.

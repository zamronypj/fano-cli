(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DirectoryCreatorImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    DirectoryCreatorIntf;

type

    (*!--------------------------------------
     * Helper class that create directory
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDirectoryCreator = class(TInterfacedObject, IDirectoryCreator)
    public
        function createDirIfNotExists(const dir : string) : string;
    end;

implementation

uses

    sysutils;

    function TDirectoryCreator.createDirIfNotExists(const dir : string) : string;
    begin
        result := dir;
        if (not directoryExists(result)) then
        begin
            mkdir(result);
        end;
    end;
end.

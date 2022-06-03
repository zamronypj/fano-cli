(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DirectoryExistsImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    DirectoryExistsIntf;

type

    (*!--------------------------------------
     * Helper class that check if directory is exists
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDirectoryExists = class(TInterfacedObject, IDirectoryExists)
    public
        function dirExists(const dir : string) : boolean;
    end;

implementation

uses

    sysutils;

    function TDirectoryExists.dirExists(const dir : string) : boolean;
    begin
        result := directoryExists(dir);
    end;
end.

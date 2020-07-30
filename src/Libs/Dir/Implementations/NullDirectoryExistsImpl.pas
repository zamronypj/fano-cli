(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit NullDirectoryExistsImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    DirectoryExistsIntf;

type

    (*!--------------------------------------
     * Null class that always report directory
     * as exists
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNullDirectoryExists = class(TInterfacedObject, IDirectoryExists)
    public
        function dirExists(const dir : string) : boolean;
    end;

implementation


    function TNullDirectoryExists.dirExists(const dir : string) : boolean;
    begin
        //intentionally report all directories as exists
        result := true;
    end;
end.

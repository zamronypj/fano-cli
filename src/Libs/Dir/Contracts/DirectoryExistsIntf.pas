(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DirectoryExistsIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to check for directory existence
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IDirectoryExists = interface
        ['{D76D1660-FA8E-4464-B212-76A76B73B946}']

        function dirExists(const dir : string) : boolean;
    end;

implementation

end.

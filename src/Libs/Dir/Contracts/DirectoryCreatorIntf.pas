(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DirectoryCreatorIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to create directory
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IDirectoryCreator = interface
        ['{12FAD249-188B-4660-B107-DB37920423D9}']

        function createDirIfNotExists(const dir : string) : string;
    end;

implementation

end.

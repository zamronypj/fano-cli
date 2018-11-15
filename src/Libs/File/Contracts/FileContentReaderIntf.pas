(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit FileContentReaderIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to read file content to string
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IFileContentReader = interface
        ['{79DD321B-0739-43EF-955B-7B318D3A960D}']

        function read(const filename : string) : string;
    end;

implementation

end.

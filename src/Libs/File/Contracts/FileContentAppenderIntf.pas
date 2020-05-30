(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit FileContentAppenderIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to append string to file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IFileContentAppender = interface
        ['{5CC27588-1116-4BF7-817E-B9AAFE5B6FA6}']

        procedure append(const filename : string; const content : string);
    end;

implementation

end.

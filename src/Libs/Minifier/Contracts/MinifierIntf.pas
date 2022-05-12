(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit MinifierIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to minify string
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IMinifier = interface
        ['{64B1B128-EB1A-46A7-8385-42B2A10656C3}']

        (*!--------------------------------------
         * minify type, for example 'css', 'js'
         *---------------------------------------
         * @return minified type
         *---------------------------------------*)
        function contentType() : string;

        (*!--------------------------------------
         * minify string
         *---------------------------------------
         * @param inputStr input string to minify
         * @return minified string
         *---------------------------------------*)
        function minify(const inputStr : string) : string;

        (*!--------------------------------------
         * minify file
         *---------------------------------------
         * @param inputFile path of file to minify
         * @param outputFile path of minified file
         *---------------------------------------*)
        procedure minifyFile(const inputFile : string; const outputFile : string);
    end;

implementation

end.

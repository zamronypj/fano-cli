(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CssMinifierImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    MinifierIntf;

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to minify CSS
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCssMinifier = class (TInterfacedObject, IMinifier)
    public
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

uses

    Classes,
    SysUtils,
    cssmin;

    (*!--------------------------------------
     * minify type
     *---------------------------------------
     * @return minified type
     *---------------------------------------*)
    function TCssMinifier.contentType() : string;
    begin
        result := 'css';
    end;

    (*!--------------------------------------
     * minify string
     *---------------------------------------
     * @param inputStr input string to minify
     * @return minified string
     *---------------------------------------*)
    function TCssMinifier.minify(const inputStr : string) : string;
    begin
        result := cssmin.cssMin(inputStr);
    end;


    (*!--------------------------------------
     * minify file
     *---------------------------------------
     * @param inputFile path of file to minify
     * @param outputFile path of minified file
     *---------------------------------------*)
    procedure TCssMinifier.minifyFile(const inputFile : string; const outputFile : string);
    begin
        cssMinFile(inputFile, outputFile);
    end;

end.

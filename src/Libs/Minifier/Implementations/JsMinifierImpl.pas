(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit JsMinifierImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    MinifierIntf,
    jsminifier;

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to minify JS
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TJsMinifier = class (TInterfacedObject, IMinifier)
    private
        fMinifier : TJSONMinifier;
    public
        constructor create();
        destructor destroy(); override;

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
    SysUtils;

    constructor TJsMinifier.create();
    begin
        fMinifier := TJSONMinifier.create(nil);
    end;

    destructor TJsMinifier.destroy();
    begin
        fMinifier.free();
        inherited destroy();
    end;

    (*!--------------------------------------
     * minify type
     *---------------------------------------
     * @return minified type
     *---------------------------------------*)
    function TJsMinifier.contentType() : string;
    begin
        result := 'js';
    end;

    (*!--------------------------------------
     * minify string
     *---------------------------------------
     * @param inputStr input string to minify
     * @return minified string
     *---------------------------------------*)
    function TJsMinifier.minify(const inputStr : string) : string;
    var asrc, adst : TStringStream;
    begin
        asrc := TStringStream.create(inputStr);
        try
            adst := TStringStream.create('');
            try
                fMinifier.execute(asrc, adst);
                result := adst.datastring;
            finally
                adst.free();
            end;
        finally
            asrc.free();
        end;
    end;


    (*!--------------------------------------
     * minify file
     *---------------------------------------
     * @param inputFile path of file to minify
     * @param outputFile path of minified file
     *---------------------------------------*)
    procedure TJsMinifier.minifyFile(const inputFile : string; const outputFile : string);
    begin
        fMinifier.execute(inputFile, outputFile);
    end;

end.

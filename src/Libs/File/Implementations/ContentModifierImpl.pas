(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ContentModifierImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    Contnrs,
    ContentModifierIntf;

type

    (*!--------------------------------------
     * Helper class that modify text
     * before it gets written to file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TContentModifier = class(TInterfacedObject, IContentModifier)
    private
        variables : TFPStringHashTable;
        fReplacedContent : string;

        (*!------------------------------------------
         * try modify content
         *-------------------------------------------
         * @param content original content to modify
         * @return modified content
         *-------------------------------------------*)
        function tryModify(
            const oldPattern : string;
            const newPattern : string;
            const content : string
        ) : string;

        procedure iterateKey(item: string; const key: string; var continue: boolean);
    public
        constructor create();
        destructor destroy(); override;

        (*!------------------------------------------
         * set variable name and its value
         *-------------------------------------------
         * @param varName name of variable
         * @param varValue value to replace
         * @return current instance
         *-------------------------------------------*)
        function setVar(const varName : string; const varValue : string) : IContentModifier;

        (*!------------------------------------------
         * Modify content
         *-------------------------------------------
         * @param content original content to modify
         * @return modified content
         *-------------------------------------------*)
        function modify(const content : string) : string;
    end;

implementation

uses

    sysutils,
    classes;

    constructor TContentModifier.create();
    begin
        //default constructor create() initialize 196613 hash size
        //which is quite big, and for our particular usage is too big
        //so we initialize smaller hash size
        variables := TFPStringHashTable.CreateWith(193, @RSHash);
        fReplacedContent := '';
    end;

    destructor TContentModifier.destroy();
    begin
        variables.free();
        inherited destroy();
    end;

    (*!------------------------------------------
     * set variable name and its value
     *-------------------------------------------
     * @param varName name of variable
     * @param varValue value to replace
     * @return current instance
     *-------------------------------------------*)
    function TContentModifier.setVar(const varName : string; const varValue : string) : IContentModifier;
    begin
        if (variables[varName] = '') then
        begin
            variables.add(varName, varValue);
        end else
        begin
            variables[varName] := varValue;
        end;
        result := self;
    end;

    (*!------------------------------------------
     * try modify content
     *-------------------------------------------
     * @param content original content to modify
     * @return modified content
     *-------------------------------------------*)
    function TContentModifier.tryModify(
        const oldPattern : string;
        const newPattern : string;
        const content : string
    ) : string;
    begin
        result := content;
        if (length(newPattern) > 0 ) then
        begin
            result := stringReplace(result, oldPattern, newPattern, [rfReplaceAll]);
        end;
    end;

    procedure TContentModifier.iterateKey(item: string; const key: string; var continue: boolean);
    begin
        fReplacedContent := tryModify(key, item, fReplacedContent);
    end;

    (*!------------------------------------------
     * Modify content
     *-------------------------------------------
     * @param content original content to modify
     * @return modified content
     *-------------------------------------------*)
    function TContentModifier.modify(const content : string) : string;
    begin
        fReplacedContent := content;
        variables.iterate(@iterateKey);
        result := fReplacedContent;
    end;
end.

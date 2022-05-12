(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CopyrightContentModifierImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    Contnrs,
    ContentModifierIntf;

type

    (*!--------------------------------------
     * Helper class that modify copyright section
     * before it gets written to file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCopyrightContentModifier = class(TInterfacedObject, IContentModifier)
    private
        variables : TFPStringHashTable;

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

    constructor TCopyrightContentModifier.create();
    begin
        //default constructor create() initialize 196613 hash size
        //which is quite big, and for our particular usage is too big
        //so we initialize smaller hash size
        variables := TFPStringHashTable.CreateWith(193, @RSHash);
    end;

    destructor TCopyrightContentModifier.destroy();
    begin
        inherited destroy();
        variables.free();
    end;

    (*!------------------------------------------
     * set variable name and its value
     *-------------------------------------------
     * @param varName name of variable
     * @param varValue value to replace
     * @return current instance
     *-------------------------------------------*)
    function TCopyrightContentModifier.setVar(const varName : string; const varValue : string) : IContentModifier;
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
    function TCopyrightContentModifier.tryModify(
        const oldPattern : string;
        const newPattern : string;
        const content : string
    ) : string;
    begin
        result := content;
        if (newPattern <> '' ) then
        begin
            result := stringReplace(result, oldPattern, newPattern, [rfReplaceAll]);
        end;
    end;

    (*!------------------------------------------
     * Modify content
     *-------------------------------------------
     * @param content original content to modify
     * @return modified content
     *-------------------------------------------*)
    function TCopyrightContentModifier.modify(const content : string) : string;
    begin
        result := tryModify('[[APP_NAME]]', variables['[[APP_NAME]]'], content);
        result := tryModify('[[APP_URL]]', variables['[[APP_URL]]'], result);
        result := tryModify(
            '[[APP_REPOSITORY_URL]]',
            variables['[[APP_REPOSITORY_URL]]'],
            result
        );
        result := tryModify(
            '[[COPYRIGHT_YEAR]]',
            variables['[[COPYRIGHT_YEAR]]'],
            result
        );
        result := tryModify(
            '[[COPYRIGHT_HOLDER]]',
            variables['[[COPYRIGHT_HOLDER]]'],
            result
        );
        result := tryModify('[[LICENSE_URL]]', variables['[[LICENSE_URL]]'], result);
        result := tryModify('[[LICENSE]]', variables['[[LICENSE]]'], result);
        result := tryModify('[[AUTHOR_NAME]]', variables['[[AUTHOR_NAME]]'], result);
        result := tryModify(
            '[[AUTHOR_EMAIL]]',
            variables['[[AUTHOR_EMAIL]]'],
            result
        );
    end;
end.

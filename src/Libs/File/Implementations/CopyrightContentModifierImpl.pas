(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
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
        variables : TStringHashTable;
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
        variables := TStringHashTable.CreateWith(193, @RSHash);
    end;

    destructor TCopyrightContentModifier.destroy(); override;
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
    function setVar(const varName : string; const varValue : string) : IContentModifier;
    begin
        if (variables[varName] = '') then
        begin
            variables.add(varName, varValue);
        end else
        begin
            variables[varName] := varValue;
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
        result := stringReplace(
            content,
            '[[APP_NAME]]',
            variables['[[APP_NAME]]'],
            [sfReplaceAll]
        );
        result := stringReplace(
            result,
            '[[APP_URL]]',
            variables['[[APP_URL]]'],
            [sfReplaceAll]
        );
        result := stringReplace(
            result,
            '[[APP_REPOSITORY_URL]]',
            variables['[[APP_REPOSITORY_URL]]'],
            [sfReplaceAll]
        );
        result := stringReplace(
            result,
            '[[COPYRIGHT_YEAR]]',
            variables['[[COPYRIGHT_YEAR]]'],
            [sfReplaceAll]
        );
        result := stringReplace(
            result,
            '[[COPYRIGHT_HOLDER]]',
            variables['[[COPYRIGHT_HOLDER]]'],
            [sfReplaceAll]
        );
        result := stringReplace(
            result,
            '[[LICENSE_URL]]',
            variables['[[LICENSE_URL]]'],
            [sfReplaceAll]
        );
        result := stringReplace(
            result,
            '[[LICENSE]]',
            variables['[[LICENSE]]'],
            [sfReplaceAll]
        );
        result := stringReplace(
            result,
            '[[AUTHOR_NAME]]',
            variables['[[AUTHOR_NAME]]'],
            [sfReplaceAll]
        );
        result := stringReplace(
            result,
            '[[AUTHOR_EMAIL]]',
            variables['[[AUTHOR_EMAIL]]'],
            [sfReplaceAll]
        );
    end;
end.

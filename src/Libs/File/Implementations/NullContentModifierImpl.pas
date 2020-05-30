(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit NullContentModifierImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    ContentModifierIntf;

type

    (*!--------------------------------------
     * Helper class that modify nothing
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNullContentModifier = class(TInterfacedObject, IContentModifier)
    public
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

    (*!------------------------------------------
     * set variable name and its value
     *-------------------------------------------
     * @param varName name of variable
     * @param varValue value to replace
     * @return current instance
     *-------------------------------------------*)
    function TNullContentModifier.setVar(const varName : string; const varValue : string) : IContentModifier;
    begin
        //intentional does nothing
        result := self;
    end;

    (*!------------------------------------------
     * Modify content
     *-------------------------------------------
     * @param content original content to modify
     * @return modified content
     *-------------------------------------------*)
    function TNullContentModifier.modify(const content : string) : string;
    begin
        //intentional does nothing
        result := content;
    end;
end.

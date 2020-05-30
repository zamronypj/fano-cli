(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DecoratorContentModifierImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    ContentModifierIntf;

type

    (*!--------------------------------------
     * decorator class that implement IContentModifier
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDecoratorContentModifier = class(TInterfacedObject, IContentModifier)
    protected
        fActualContentModifier : IContentModifier;
    public
        constructor create(const cntModifier : IContentModifier);
        destructor destroy(); override;

        (*!------------------------------------------
         * set variable name and its value
         *-------------------------------------------
         * @param varName name of variable
         * @param varValue value to replace
         * @return current instance
         *-------------------------------------------*)
        function setVar(const varName : string; const varValue : string) : IContentModifier; virtual;

        (*!------------------------------------------
         * Modify content
         *-------------------------------------------
         * @param content original content to modify
         * @return modified content
         *-------------------------------------------*)
        function modify(const content : string) : string; virtual;
    end;

implementation

    constructor TDecoratorContentModifier.create(const cntModifier : IContentModifier);
    begin
        fActualContentModifier := cntModifier;
    end;

    destructor TDecoratorContentModifier.destroy();
    begin
        fActualContentModifier := nil;
        inherited destroy();
    end;

    (*!------------------------------------------
     * set variable name and its value
     *-------------------------------------------
     * @param varName name of variable
     * @param varValue value to replace
     * @return current instance
     *-------------------------------------------*)
    function TDecoratorContentModifier.setVar(const varName : string; const varValue : string) : IContentModifier;
    begin
        fActualContentModifier.setVar(varName, varValue);
        result := self;
    end;

    (*!------------------------------------------
     * Modify content
     *-------------------------------------------
     * @param content original content to modify
     * @return modified content
     *-------------------------------------------*)
    function TDecoratorContentModifier.modify(const content : string) : string;
    begin
        result := fActualContentModifier.modify(content);
    end;
end.

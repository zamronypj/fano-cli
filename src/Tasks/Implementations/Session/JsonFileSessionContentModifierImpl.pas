(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit JsonFileSessionContentModifierImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    ContentModifierIntf,
    DecoratorContentModifierImpl;

type

    (*!--------------------------------------
     * Helper class that add json session dispatcher
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TJsonFileSessionContentModifier = class(TDecoratorContentModifier)
    public
        (*!------------------------------------------
         * Modify content
         *-------------------------------------------
         * @param content original content to modify
         * @return modified content
         *-------------------------------------------*)
        function modify(const content : string) : string; override;
    end;

implementation


    (*!------------------------------------------
     * Modify content
     *-------------------------------------------
     * @param content original content to modify
     * @return modified content
     *-------------------------------------------*)
    function TJsonFileSessionContentModifier.modify(const content : string) : string;
    var
        {$INCLUDE src/Tasks/Implementations/Session/Includes/decl.dispatcher.method.inc}
        {$INCLUDE src/Tasks/Implementations/Session/Includes/impl.json.file.dispatcher.method.inc}
    begin
        setVar('[[BUILD_DISPATCHER_METHOD_DECL_SECTION]]', strDeclDispatcherMethod);
        setVar('[[BUILD_DISPATCHER_METHOD_IMPL_SECTION]]', strImplJsonFileDispatcherMethod);
        result := inherited modify(content);
    end;
end.

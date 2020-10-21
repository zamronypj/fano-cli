(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit MysqlDbSessionContentModifierImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    ContentModifierIntf,
    DecoratorContentModifierImpl;

type

    (*!--------------------------------------
     * Helper class that modify content of
     * buildDispatcher() method implementation for
     * session that is stored in MySQL database
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TMysqlDbSessionContentModifier = class(TDecoratorContentModifier)
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
    function TMysqlDbSessionContentModifier.modify(const content : string) : string;
    var
        {$INCLUDE src/Tasks/Implementations/Session/Includes/decl.dispatcher.method.inc}
        {$INCLUDE src/Tasks/Implementations/Session/Includes/impl.db.mysql.dispatcher.method.inc}
    begin
        setVar('[[BUILD_DISPATCHER_METHOD_DECL_SECTION]]', strDeclDispatcherMethod);
        setVar('[[BUILD_DISPATCHER_METHOD_IMPL_SECTION]]', strImplDbMysqlDispatcherMethod);
        result := inherited modify(content);
    end;
end.

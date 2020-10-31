(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit SqliteDbSessionContentModifierImpl;

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
     * session that is stored in SQLite database
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TSqliteDbSessionContentModifier = class(TDecoratorContentModifier)
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
    function TSqliteDbSessionContentModifier.modify(const content : string) : string;
    var
        {$INCLUDE src/Tasks/Implementations/Session/Includes/decl.dispatcher.method.inc}
        {$INCLUDE src/Tasks/Implementations/Session/Includes/impl.db.sqlite.dispatcher.method.inc}
    begin
        setVar('[[BUILD_DISPATCHER_METHOD_DECL_SECTION]]', strDeclDispatcherMethod);
        setVar('[[BUILD_DISPATCHER_METHOD_IMPL_SECTION]]', strImplDbSqliteDispatcherMethod);

        //remove irrelevant config value (see config.json.db.inc) for SQLite
        setVar('"version" : "[[DB_VER]]",', '');
        setVar('"host" : "[[DB_HOST]]",', '');
        setVar('"port" : [[DB_PORT]],', '');
        setVar('"user" : "[[DB_USER]]",', '');
        setVar('"passw" : "[[DB_PASSW]]"', '');

        //set default value
        //TODO: allow modification from command line parameter

        //here we replace [[DB_NAME]] and also remove coma
        setVar('"db" : "[[DB_NAME]]",', '"db" : "fano_db"');

        setVar('[[SESSION_TABLE]]', 'sessions');
        setVar('[[SESSION_ID_COLUMN]]', 'id');
        setVar('[[SESSION_DATA_COLUMN]]', 'data');
        setVar('[[SESSION_EXPIRED_AT_COLUMN]]', 'expired_at');

        result := inherited modify(content);
    end;
end.
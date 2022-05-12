(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDbSessionJsonAppConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ContentModifierIntf,
    KeyGeneratorIntf,
    CreateSessionJsonAppConfigsTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application json config files
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateDbSessionJsonAppConfigsTask = class(TCreateSessionJsonAppConfigsTask)
    protected
        function getConfigTemplate() : string; override;
    end;

implementation

uses

    sysutils;

    function TCreateDbSessionJsonAppConfigsTask.getConfigTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Session/Includes/config.json.db.inc}
    begin
        result := strConfigJsonDb;
    end;

end.

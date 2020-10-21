(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDbSessionIniAppConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ContentModifierIntf,
    KeyGeneratorIntf,
    BaseCreateSessionAppConfigsTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application json config files
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateDbSessionIniAppConfigsTask = class(TBaseCreateSessionAppConfigsTask)
    protected
        function getConfigType() : string; override;
        function getConfigTemplate() : string; override;
    end;

implementation

uses

    sysutils;

    function TCreateDbSessionIniAppConfigsTask.getConfigType() : string;
    begin
        result := 'ini';
    end;

    function TCreateDbSessionIniAppConfigsTask.getConfigTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Session/Includes/config.ini.db.inc}
    begin
        result := strConfigJsonIni;
    end;

end.

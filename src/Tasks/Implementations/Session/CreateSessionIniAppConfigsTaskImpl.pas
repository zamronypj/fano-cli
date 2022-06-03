(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateSessionIniAppConfigsTaskImpl;

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
     * Task that create web application ini config files
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateSessionIniAppConfigsTask = class(TBaseCreateSessionAppConfigsTask)
    protected
        function getConfigType() : string; override;
        function getConfigTemplate() : string; override;
    end;

implementation

uses

    sysutils;

    function TCreateSessionIniAppConfigsTask.getConfigType() : string;
    begin
        result := 'ini';
    end;

    function TCreateSessionIniAppConfigsTask.getConfigTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Session/Includes/config.ini.inc}
    begin
        result := strConfigIni;
    end;

end.

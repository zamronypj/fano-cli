(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseNginxVirtualHostTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseWebServerVirtualHostTaskImpl;

type

    (*!--------------------------------------
     * Task that creates nginx virtual host file
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseNginxVirtualHostTask = class(TBaseWebServerVirtualHostTask)
    protected
        procedure createVhostFile(
            const opt : ITaskOptions;
            const serverName : string
        ); override;
    end;

implementation

uses

    SysUtils;

    procedure TBaseNginxVirtualHostTask.createVhostFile(
        const opt : ITaskOptions;
        const serverName : string
    );
    begin
        if directoryExists('/etc/nginx') then
        begin
            contentModifier.setVar('[[NGINX_LOG_DIR]]', '/var/log/nginx');
            createTextFile(
                '/etc/nginx/conf.d/' + serverName + '.conf',
                getVhostTemplate()
            );
            writeln('Create virtual host /etc/nginx/conf.d/' + serverName + '.conf');
        end else
        begin
            writeln('Unsupported platform or web server');
        end;
    end;

end.

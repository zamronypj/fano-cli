(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
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

    SysUtils,
    strformats;

    procedure TBaseNginxVirtualHostTask.createVhostFile(
        const opt : ITaskOptions;
        const serverName : string
    );
    begin
        if directoryExists('/etc/nginx') then
        begin
            //mostly in Linux
            contentModifier.setVar('[[NGINX_LOG_DIR]]', '/var/log/nginx');
            createTextFile(
                '/etc/nginx/conf.d/' + serverName + '.conf',
                getVhostTemplate()
            );
            writeln(
                'Create virtual host ',
                formatColor('/etc/nginx/conf.d/' + serverName + '.conf', TXT_GREEN)
            );
        end else
        if directoryExists('/usr/local/etc/nginx') then
        begin
            //in FreeBSD
            contentModifier.setVar('[[NGINX_LOG_DIR]]', '/var/log/nginx');

            if not directoryExists('/usr/local/etc/nginx/conf.d') then
            begin
                mkdir('/usr/local/etc/nginx/conf.d');
            end;

            if pos('/usr/local/etc/nginx/conf.d', nginXConfigContent) = 0 then
            begin
                fileHelper.append('include /usr/local/etc/nginx/conf.d/*' + LineEnding);
            end;

            createTextFile(
                '/usr/local/etc/nginx/conf.d/' + serverName + '.conf',
                getVhostTemplate()
            );
            writeln(
                'Create virtual host ',
                formatColor('/usr/local/etc/nginx/conf.d/' + serverName + '.conf', TXT_GREEN)
            );
        end else
        begin
            writeln('Unsupported platform or web server');
        end;
    end;

end.

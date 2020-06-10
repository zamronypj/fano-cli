(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseApacheVirtualHostTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseWebServerVirtualHostTaskImpl;

type

    (*!--------------------------------------
     * Task that creates apache virtual host file
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseApacheVirtualHostTask = class(TBaseWebServerVirtualHostTask)
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

    procedure TBaseApacheVirtualHostTask.createVhostFile(
        const opt : ITaskOptions;
        const serverName : string
    );
    begin
        if directoryExists('/etc/apache2') then
        begin
            //debian-based
            contentModifier.setVar('[[APACHE_LOG_DIR]]', '/var/log/apache2');
            createTextFile(
                '/etc/apache2/sites-available/' + serverName + '.conf',
                getVhostTemplate()
            );
            writeln(
                'Create virtual host ',
                formatColor('/etc/apache2/sites-available/' + serverName + '.conf', TXT_GREEN)
            );
        end else
        if directoryExists('/etc/httpd') then
        begin
            //fedora-based
            contentModifier.setVar('[[APACHE_LOG_DIR]]', '/var/log/httpd');
            createTextFile(
                '/etc/httpd/conf.d/' + serverName + '.conf',
                getVhostTemplate()
            );
            writeln(
                'Create virtual host ',
                formatColor('/etc/httpd/conf.d/' + serverName + '.conf', TXT_GREEN)
            );
        end else
        if directoryExists('/usr/local/etc/apache24') then
        begin
            //FreeBSD
            contentModifier.setVar('[[APACHE_LOG_DIR]]', '/var/log');
            createTextFile(
                '/usr/local/etc/apache24/Includes/' + serverName + '.conf',
                getVhostTemplate()
            );
            writeln(
                'Create virtual host ',
                formatColor('/usr/local/etc/apache24/Includes/' + serverName + '.conf', TXT_GREEN)
            );
        end else
        begin
            writeln('Unsupported platform or web server');
        end;
    end;

end.

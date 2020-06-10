(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheEnableVhostTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorTaskImpl;

type

    (*!--------------------------------------
     * Task that enable virtual host
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheEnableVhostTask = class(TInterfacedObject, ITask)
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils,
    strformats,
    BaseUnix;

    function TApacheEnableVhostTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var serverName : shortString;
    begin
        serverName := opt.getOptionValue(longOpt);
        if directoryExists('/etc/apache2/sites-enabled') then
        begin
            //debian-based
            if not fileExists('/etc/apache2/sites-enabled/' + serverName + '.conf') then
            begin
                fpSymlink(
                    PChar('/etc/apache2/sites-available/' + serverName + '.conf'),
                    PChar('/etc/apache2/sites-enabled/' + serverName + '.conf')
                );

                writeln(
                    'Enable virtual host ',
                    formatColor('/etc/apache2/sites-enabled/' + serverName + '.conf', TXT_GREEN)
                );
            end;
        end else
        if directoryExists('/etc/httpd') then
        begin
            //fedora-based we do nothing
            writeln(
                'Enable virtual host ',
                formatColor('/etc/httpd/conf.d/' + serverName + '.conf', TXT_GREEN)
            );
        end else
        if directoryExists('/usr/local/etc/apache24') then
        begin
            //fedora-based we do nothing
            writeln(
                'Enable virtual host ',
                formatColor('/usr/local/etc/apache24/Includes/' + serverName + '.conf', TXT_GREEN)
            );
        end else
        begin
            writeln('Cannot create vhost symlink. Unsupported platform or web server');
        end;
        result := self;
    end;
end.

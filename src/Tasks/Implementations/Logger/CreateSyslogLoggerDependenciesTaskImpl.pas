(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateSyslogLoggerDependenciesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    AbstractCreateLoggerDependenciesTaskImpl;

type

    (*!--------------------------------------
     * Task that add Syslog logger support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateSyslogLoggerDependenciesTask = class(TAbstractCreateLoggerDependenciesTask)
    protected
        procedure createDependencies(
            const dir : string;
            const opt : ITaskOptions;
            const projectType : shortstring
        ); override;
    end;

implementation

    procedure TCreateSyslogLoggerDependenciesTask.createDependencies(
        const dir : string;
        const opt : ITaskOptions;
        const projectType : shortstring
    );
    var
        {$INCLUDE src/Tasks/Implementations/Logger/Includes/sysloglogger.dependencies.inc}
    begin
        fFileAppender.append(
            dir + DirectorySeparator + 'main.dependencies.inc',
            strLoggerDependencies
        );
    end;

end.

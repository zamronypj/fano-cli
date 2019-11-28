(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateIniFileSessionDependenciesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileSessionDependenciesTaskImpl;

type

    (*!--------------------------------------
     * Task that add ini file session support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateIniFileSessionDependenciesTask = class(TBaseCreateFileSessionDependenciesTask)
    protected
        procedure createDependencies(const dir : string);
    end;

implementation

    procedure TCreateIniFileSessionDependenciesTask.createDependencies(const dir : string);
    var
        depStr : string;
        {$INCLUDE src/Tasks/Implementations/Session/Includes/ini.file.session.dependencies.inc.inc}
    begin
        depStr := fContentModifier.modify(strIniFileSession);
        createTextFile(dir + '/session.dependencies.inc', depStr);
        fFileAppender.append(
            dir + '/main.dependencies.inc',
            LineEnding + '{$INCLUDE session.dependencies.inc}'
        );
    end;

end.

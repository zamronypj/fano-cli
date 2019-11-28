(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateJsonFileSessionDependenciesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileSessionDependenciesTaskImpl;

type

    (*!--------------------------------------
     * Task that add json file session support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateJsonFileSessionDependenciesTask = class(TBaseCreateFileSessionDependenciesTask)
    protected
        procedure createDependencies(const dir : string); override;
    end;

implementation


    procedure TCreateJsonFileSessionDependenciesTask.createDependencies(const dir : string);
    var
        depStr : string;
        {$INCLUDE src/Tasks/Implementations/Session/Includes/json.file.session.dependencies.inc.inc}
    begin
        depStr := fContentModifier.modify(strJsonFileSession);
        createTextFile(dir + '/session.dependencies.inc', depStr);
        fFileAppender.append(
            dir + '/main.dependencies.inc',
            LineEnding + '{$INCLUDE session.dependencies.inc}'
        );
    end;
end.

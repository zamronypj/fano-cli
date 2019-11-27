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
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that add ini file session support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateIniFileSessionDependenciesTask = class(TCreateFileTask)
    private
        procedure createIniFileSessionDependencies(const dir : string);
    public
        constructor create();
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    constructor TCreateIniFileSessionDependenciesTask.create();
    begin
    end;

    destructor TCreateIniFileSessionDependenciesTask.destroy();
    begin
        inherited destroy();
    end;

    procedure TCreateIniFileSessionDependenciesTask.createIniFileSessionDependencies(const dir : string);
    begin
    end;

    function TCreateIniFileSessionDependenciesTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        result := self;
    end;
end.

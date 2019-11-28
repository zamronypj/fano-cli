(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateSessionDependenciesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that add session support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateSessionDependenciesTask = class(TInterfacedObject, ITask)
    private
        createFileSessionDependenciesTask : ITask;
        createCookieSessionDependenciesTask : ITask;
        createDbSessionDependenciesTask : ITask;
    public
        constructor create(
            const createFileSessDependenciesTask : ITask;
            const createCookieSessDependenciesTask : ITask;
            const createDbSessDependenciesTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    constructor TCreateSessionDependenciesTask.create(
        const createFileSessDependenciesTask : ITask;
        const createCookieSessDependenciesTask : ITask;
        const createDbSessDependenciesTask : ITask
    );
    begin
        createFileSessionDependenciesTask := createFileSessDependenciesTask;
        createCookieSessionDependenciesTask := createCookieSessDependenciesTask;
        createDbSessionDependenciesTask := createDbSessDependenciesTask;
    end;

    destructor TCreateSessionDependenciesTask.destroy();
    begin
        createFileSessionDependenciesTask := nil;
        createCookieSessionDependenciesTask := nil;
        createDbSessionDependenciesTask := nil;
        inherited destroy();
    end;

    function TCreateSessionDependenciesTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var sessType : string;
    begin
        if opt.hasOption('with-session') then
        begin
            sessType := opt.getOptionValueDef('with-session', 'file');
            case sessType of
                'file' : result := createFileSessionDependenciesTask.run(opt,longOpt);
                'cookie' : result := createCookieSessionDependenciesTask.run(opt,longOpt);
                'db' : result := createDbSessionDependenciesTask.run(opt,longOpt);
            end;
        end;
        result := self;
    end;
end.

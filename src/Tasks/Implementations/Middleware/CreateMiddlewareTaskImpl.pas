(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMiddlewareTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that scaffolding middleware class
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMiddlewareTask = class(TInterfacedObject, ITask)
    private
        createMiddlewareFileTask : ITask;
        createMiddlewareFactoryFileTask : ITask;
        createDependenciesTask : ITask;
    public
        constructor create(
            const createMdlwFileTask : ITask;
            const createMdlwFactoryFileTask : ITask;
            const createMdlwDependenciesTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

    constructor TCreateMiddlewareTask.create(
        const createMdlwFileTask : ITask;
        const createMdlwFactoryFileTask : ITask;
        const createMdlwDependenciesTask : ITask
    );
    begin
        createMiddlewareFileTask := createMdlwFileTask;
        createMiddlewareFactoryFileTask := createMdlwFactoryFileTask;
        createDependenciesTask := createMdlwDependenciesTask;
    end;

    destructor TCreateMiddlewareTask.destroy();
    begin
        createMiddlewareFileTask := nil;
        createMiddlewareFactoryFileTask := nil;
        createDependenciesTask := nil;
        inherited destroy();
    end;

    function TCreateMiddlewareTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var middlewareName : string;
    begin
        middlewareName := opt.getOptionValue(longOpt);
        if (length(middlewareName) = 0) then
        begin
            writeln('Middleware name can not be empty.');
            writeln('Run with --help to view available task.');
            result := self;
            exit();
        end;

        writeln('Creating ' +middlewareName +'Middleware class.');
        createMiddlewareFileTask.run(opt, longOpt);
        createMiddlewareFactoryFileTask.run(opt, longOpt);
        createDependenciesTask.run(opt, longOpt);
        writeln(middlewareName +'Middleware class is created.');
        result := self;
    end;
end.

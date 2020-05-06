(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateControllerTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that scaffolding controller class
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateControllerTask = class(TInterfacedObject, ITask)
    private
        createControllerFileTask : ITask;
        createControllerFactoryFileTask : ITask;
        createDependenciesTask : ITask;
        createRouteTask : ITask;
    public
        constructor create(
            const createCtrlFileTask : ITask;
            const createCtrlFactoryFileTask : ITask;
            const createCtrlDependenciesTask : ITask;
            const createCtrlRouteTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    StrFormats;

    constructor TCreateControllerTask.create(
        const createCtrlFileTask : ITask;
        const createCtrlFactoryFileTask : ITask;
        const createCtrlDependenciesTask : ITask;
        const createCtrlRouteTask : ITask
    );
    begin
        createControllerFileTask := createCtrlFileTask;
        createControllerFactoryFileTask := createCtrlFactoryFileTask;
        createDependenciesTask := createCtrlDependenciesTask;
        createRouteTask := createCtrlRouteTask;
    end;

    destructor TCreateControllerTask.destroy();
    begin
        createControllerFileTask := nil;
        createControllerFactoryFileTask := nil;
        createDependenciesTask := nil;
        createRouteTask := nil;
        inherited destroy();
    end;

    function TCreateControllerTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var controllerName : string;
    begin
        controllerName := opt.getOptionValue(longOpt);
        if (controllerName = '') then
        begin
            writeln('Controller name can not be empty.');
            writeln('Run with --help to view available task.');
            result := self;
            exit();
        end;

        writeln('Creating ', formatColor(controllerName + 'Controller', TXT_GREEN), ' class.');
        createControllerFileTask.run(opt, longOpt);
        createControllerFactoryFileTask.run(opt, longOpt);
        createDependenciesTask.run(opt, longOpt);
        createRouteTask.run(opt, longOpt);
        writeln(formatColor(controllerName + 'Controller', TXT_GREEN),' class is created.');
        result := self;
    end;
end.

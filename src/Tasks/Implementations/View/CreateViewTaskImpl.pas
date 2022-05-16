(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateViewTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that scaffolding view class
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateViewTask = class(TInterfacedObject, ITask)
    private
        createViewFileTask : ITask;
        createViewFactoryFileTask : ITask;
        createDependenciesTask : ITask;
    public
        constructor create(
            const createVwFileTask : ITask;
            const createVwFactoryFileTask : ITask;
            const createVwDependenciesTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    strformats;

    constructor TCreateViewTask.create(
        const createVwFileTask : ITask;
        const createVwFactoryFileTask : ITask;
        const createVwDependenciesTask : ITask
    );
    begin
        createViewFileTask := createVwFileTask;
        createViewFactoryFileTask := createVwFactoryFileTask;
        createDependenciesTask := createVwDependenciesTask;
    end;

    destructor TCreateViewTask.destroy();
    begin
        inherited destroy();
        createViewFileTask := nil;
        createViewFactoryFileTask := nil;
        createDependenciesTask := nil;
    end;

    function TCreateViewTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var viewName : string;
    begin
        viewName := opt.getOptionValue(longOpt);
        if (viewName = '') then
        begin
            writeln('View name can not be empty.');
            writeln('Run with --help to view available task.');
            result := self;
            exit();
        end;

        writeln('Creating ', formatColor(viewName + 'View', TXT_GREEN),' class.');
        createViewFileTask.run(opt, longOpt);
        createViewFactoryFileTask.run(opt, longOpt);
        createDependenciesTask.run(opt, longOpt);
        writeln(formatColor(viewName + 'View', TXT_GREEN), ' class is created.');
        result := self;
    end;
end.

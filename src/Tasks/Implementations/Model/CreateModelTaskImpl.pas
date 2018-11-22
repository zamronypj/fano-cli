(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateModelTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that scaffolding model class
     * TODO: refactor as this class similar to TCreateViewTask
     * and TCreateControllerTask
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateModelTask = class(TInterfacedObject, ITask)
    private
        createModelFileTask : ITask;
        createModelFactoryFileTask : ITask;
        createDependenciesTask : ITask;
    public
        constructor create(
            const createMdlFileTask : ITask;
            const createMdlFactoryFileTask : ITask;
            const createMdlDependenciesTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

    constructor TCreateModelTask.create(
        const createMdlFileTask : ITask;
        const createMdlFactoryFileTask : ITask;
        const createMdlDependenciesTask : ITask
    );
    begin
        createModelFileTask := createMdlFileTask;
        createModelFactoryFileTask := createMdlFactoryFileTask;
        createDependenciesTask := createMdlDependenciesTask;
    end;

    destructor TCreateModelTask.destroy();
    begin
        inherited destroy();
        createModelFileTask := nil;
        createModelFactoryFileTask := nil;
        createDependenciesTask := nil;
    end;

    function TCreateModelTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var modelName : string;
    begin
        modelName := opt.getOptionValue(longOpt);
        if (length(modelName) = 0) then
        begin
            writeln('Model name can not be empty.');
            writeln('Run with --help to view available task.');
            result := self;
            exit();
        end;

        writeln('Creating ' + modelName +'Model class.');
        createModelFileTask.run(opt, longOpt);
        createModelFactoryFileTask.run(opt, longOpt);
        createDependenciesTask.run(opt, longOpt);
        writeln(modelName +'Model class is created.');
        result := self;
    end;
end.

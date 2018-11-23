(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMvcTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create model, controller, view task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMvcTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    CompositeTaskImpl,
    CreateControllerTaskFactoryImpl,
    CreateModelTaskFactoryImpl,
    CreateViewTaskFactoryImpl;

    function TCreateMvcTaskFactory.build() : ITask;
    var controllerFactoryTask : ITaskFactory;
        modelFactoryTask : ITaskFactory;
        viewFactoryTask : ITaskFactory;
        compositeTask : ITask;
    begin
        controllerFactoryTask := TCreateControllerTaskFactory.create();
        viewFactoryTask := TCreateViewTaskFactory.create();
        modelFactoryTask := TCreateModelTaskFactory.create();
        compositeTask := TCompositeTask.create(
            controllerFactoryTask.build(),
            viewFactoryTask.build()
        );
        result := TCompositeTask.create(
            compositeTask,
            modelFactoryTask.build()
        );
    end;

end.

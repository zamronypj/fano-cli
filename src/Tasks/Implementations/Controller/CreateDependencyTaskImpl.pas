(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDependencyTaskImpl;

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
    TCreateDependencyTask = class(TInterfacedObject, ITask)
    private
        addControllerToUsesClauseTask : ITask;
        addControllerToUnitSearchTask : ITask;
        createDependencyRegistrationTask : ITask;
    public
        constructor create(
            const addCtrlToUsesClauseTask : ITask;
            const addCtrlToUnitSearchTask : ITask;
            const createDepRegistrationTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

    constructor TCreateDependencyTask.create(
        const addCtrlToUsesClauseTask : ITask;
        const addCtrlToUnitSearchTask : ITask;
        const createDepRegistrationTask : ITask
    );
    begin
        addControllerToUsesClauseTask := addCtrlToUsesClauseTask;
        addControllerToUnitSearchTask := addCtrlToUnitSearchTask;
        createDependencyRegistrationTask := createDepRegistrationTask;
    end;

    destructor TCreateDependencyTask.destroy();
    begin
        inherited destroy();
        addControllerToUsesClauseTask := nil;
        addControllerToUnitSearchTask := nil;
        createDependencyRegistrationTask := nil;
    end;

    function TCreateDependencyTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        addControllerToUsesClauseTask.run(opt, longOpt);
        addControllerToUnitSearchTask.run(opt, longOpt);
        createDependencyRegistrationTask.run(opt, longOpt);
        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
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
        addObjectToUsesClauseTask : ITask;
        addObjectToUnitSearchTask : ITask;
        createDependencyRegistrationTask : ITask;
    public
        constructor create(
            const addToUsesClauseTask : ITask;
            const addToUnitSearchTask : ITask;
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
        const addToUsesClauseTask : ITask;
        const addToUnitSearchTask : ITask;
        const createDepRegistrationTask : ITask
    );
    begin
        addObjectToUsesClauseTask := addToUsesClauseTask;
        addObjectToUnitSearchTask := addToUnitSearchTask;
        createDependencyRegistrationTask := createDepRegistrationTask;
    end;

    destructor TCreateDependencyTask.destroy();
    begin
        inherited destroy();
        addObjectToUsesClauseTask := nil;
        addObjectToUnitSearchTask := nil;
        createDependencyRegistrationTask := nil;
    end;

    function TCreateDependencyTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        addObjectToUsesClauseTask.run(opt, longOpt);
        addObjectToUnitSearchTask.run(opt, longOpt);
        createDependencyRegistrationTask.run(opt, longOpt);
        result := self;
    end;
end.

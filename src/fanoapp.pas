(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit fanoapp;

interface

{$MODE OBJFPC}
{$H+}

uses
    sysutils,
    classes,
    custapp,
    TaskIntf;

type

    TFanoCliApplication = class (TCustomApplication)
    private
        infoTask : ITask;
        createProjectTask : ITask;
    protected
        procedure doRun(); override;
    public
        constructor create(AOwner : TComponent); override;
        constructor create(
            const AOwner : TComponent;
            const info : ITask;
            const createProject : ITask
        );
        destructor destroy(); override;
    end;

implementation

    constructor TFanoCliApplication.create(AOwner : TComponent);
    begin
        inherited create(AOwner);
        infoTask := nil;
        createProjectTask := nil;
    end;

    constructor TFanoCliApplication.create(
        const AOwner : TComponent;
        const info : ITask;
        const createProject : ITask
    );
    begin
        inherited create(AOwner);
        infoTask := info;
        createProjectTask := createProject;
    end;

    destructor TFanoCliApplication.destroy();
    begin
        inherited destroy();
        infoTask := nil;
        createProjectTask := nil;
    end;

    procedure TFanoCliApplication.doRun();
    begin
        if (hasOption('c', 'create-project')) then
        begin
            createProjectTask.run();
            halt();
        end;

        if (hasOption('h', 'help')) then
        begin
            infoTask.run();
            halt();
        end;

        infoTask.run();
        halt();
    end;

end.

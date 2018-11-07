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
    classes,
    TaskIntf;

type

    TFanoCliApplication = class (TCustomApplication)
    private
        infoTask : ITask;
        createProjectTask : ITask;
    protected
        procedure doRun(); override;
    public
        constructor create(
            const info : ITask;
            const createProject : ITask
        );
        destructor destroy(); override;
    end;

implementation

    constructor create(
        const info : ITask;
        const createProject : ITask
    );
    begin
        inherited create();
        infoTask := info;
        createProjectTask := createProject;
    end;

    destructor destroy();
    begin
        inherited destroy();
        infoTask := nil;
        createProjectTask := nil;
    end;

    procedure TFanoCliApplication.doRun();
    begin
        if (hasOption('h', 'help')) then
        begin
            infoTask.run();
            halt();
        end;

        if (hasOption('cp', 'create-project')) then
        begin
            createProjectTask.run();
            halt();
        end;
    end;

end.

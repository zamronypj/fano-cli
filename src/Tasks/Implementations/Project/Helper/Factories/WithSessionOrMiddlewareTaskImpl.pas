(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WithSessionOrMiddlewareTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that run task conditionally
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TWithSessionOrMiddlewareTask = class(TInterfacedObject, ITask)
    private
        fSessionTask : ITask;
        fMiddlewareTask : ITask;
        fDefaultTask : ITask;
    public
        constructor create(
            const sessionTask : ITask;
            const middlewareTask : ITask;
            const defaultTask : ITask
        );
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

    constructor TWithSessionOrMiddlewareTask.create(
        const sessionTask : ITask;
        const middlewareTask : ITask;
        const defaultTask : ITask
    );
    begin
        fSessionTask := sessionTask;
        fMiddlewareTask := middlewareTask;
        fDefaultTask := defaultTask;
    end;

    destructor TWithSessionOrMiddlewareTask.destroy();
    begin
        fSessionTask := nil;
        fMiddlewareTask := nil;
        fDefaultTask := nil;
        inherited destroy();
    end;

    function TWithSessionOrMiddlewareTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        if (opt.hasOption('with-session')) then
        begin
            fSessionTask.run(opt, longOpt);
        end else
        if (opt.hasOption('with-middleware')) then
        begin
            fMiddlewareTask.run(opt, longOpt);
        end else
        begin
            fDefaultTask.run(opt, longOpt);
        end;
        result := self;
    end;
end.

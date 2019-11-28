(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CompositeAppConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that add session-related application config
     * to project creation or fallback to basic config
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCompositeAppConfigsTask = class(TInterfacedObject, ITask)
    private
        fSessionAppConfigTask : ITask;
        fAppConfigTask : ITask;
    public
        constructor create(
            const aSessionAppConfigTask : ITask;
            const aAppConfigTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

    constructor TCompositeAppConfigsTask.create(
        const aSessionAppConfigTask : ITask;
        const aAppConfigTask : ITask
    );
    begin
        fSessionAppConfigTask := aSessionAppConfigTask;
        fAppConfigTask := aAppConfigTask;
    end;

    destructor TCompositeAppConfigsTask.destroy();
    begin
        fSessionAppConfigTask := nil;
        fAppConfigTask := nil;
        inherited destroy();
    end;

    function TCompositeAppConfigsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        if opt.hasOption('with-session') then
        begin
            fSessionAppConfigTask.run(opt, longOpt);
        end else
        begin
            fAppConfigTask.run(opt, longOpt);
        end;
        result := self;
    end;
end.

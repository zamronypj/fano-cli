(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WithGitInitialCommitTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that create web application project
     * git repository using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TWithGitInitialCommitTask = class(TInterfacedObject, ITask)
    private
        fCommitRepoTask : ITask;
    public
        constructor create(const commitRepo : ITask);
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    sysutils;


    constructor TWithGitInitialCommitTask.create(const commitRepo : ITask);
    begin
        fCommitRepoTask := commitRepo;
    end;

    destructor TWithGitInitialCommitTask.destroy();
    begin
        fCommitRepoTask := nil;
        inherited destroy();
    end;

    function TWithGitInitialCommitTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        if not opt.hasOption('no-initial-commit') then
        begin
            fCommitRepoTask.run(opt, longOpt);
        end;
        result := self;
    end;
end.

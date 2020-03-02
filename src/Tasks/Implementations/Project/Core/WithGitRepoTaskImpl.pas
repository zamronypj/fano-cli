(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WithGitRepoTaskImpl;

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
    TWithGitRepoTask = class(TInterfacedObject, ITask)
    private
        fInitGitRepoTask : ITask;
    public
        constructor create(const initGitRepo : ITask);
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    sysutils;


    constructor TWithGitRepoTask.create(const initGitRepo : ITask);
    begin
        fInitGitRepoTask := initGitRepo;
    end;

    destructor TWithGitRepoTask.destroy();
    begin
        fInitGitRepoTask := nil;
        inherited destroy();
    end;

    function TWithGitRepoTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        if not opt.hasOption('no-git') then
        begin
            fInitGitRepoTask.run(opt, longOpt);
        end;
        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CommitGitRepoTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseGitRepoTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * commit git repository using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCommitGitRepoTask = class(TBaseGitRepoTask)
    private
        procedure initialCommitRepository(const baseDir : string);
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    procedure TCommitGitRepoTask.initialCommitRepository(const baseDir : string);
    var outputString : string;
    begin
        ///$ git commit -m "Initial commit"
        runGit(baseDir, ['commit', '-m', '"Initial commit"'], outputString);
        writeln(outputString);
    end;

    function TCommitGitRepoTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        initialCommitRepository(baseDirectory);
        result := self;
    end;
end.

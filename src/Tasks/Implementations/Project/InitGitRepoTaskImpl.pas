(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit InitGitRepoTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseProjectTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * git repository using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TInitGitRepoTask = class(TBaseProjectTask)
    private
        function runGit(
            const baseDir : string;
            const params : array of string;
            out outputString : string
        ) : boolean;
        procedure initGitRepository(const baseDir : string);
        procedure addFanoRepository(const baseDir : string);
        procedure stageFileToRepository(const baseDir : string);
        procedure initialCommitRepository(const baseDir : string);
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils,
    process;

const

    GIT_BIN = 'git';
    FANO_REPO = 'https://github.com/fanoframework/fano.git';

    function TInitGitRepoTask.runGit(
        const baseDir : string;
        const params : array of string;
        out outputString : string
    ) : boolean;
    begin
        result := runCommandInDir(
            baseDir,
            GIT_BIN,
            params,
            outputString,
            [poStderrToOutPut]
        );
    end;

    procedure TInitGitRepoTask.initGitRepository(const baseDir : string);
    var outputString : string;
    begin
        ///$ git init
        runGit(baseDir, ['init'], outputString);
        writeln(outputString);
    end;

    procedure TInitGitRepoTask.addFanoRepository(const baseDir : string);
    var outputString : string;
    begin
        ///$ git submodule add fano_repo_url
        runGit(baseDir, ['submodule', 'add', FANO_REPO], outputString);
        writeln(outputString);
    end;

    procedure TInitGitRepoTask.stageFileToRepository(const baseDir : string);
    var outputString : string;
    begin
        ///$ git add .
        runGit(baseDir, ['add', '.'], outputString);
        writeln(outputString);
    end;

    procedure TInitGitRepoTask.initialCommitRepository(const baseDir : string);
    var outputString : string;
    begin
        ///$ git commit -m "Initial commit"
        runGit(baseDir, ['commit', '-m', '"Initial commit"'], outputString);
        writeln(outputString);
    end;

    function TInitGitRepoTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        initGitRepository(baseDirectory);
        addFanoRepository(baseDirectory);
        stageFileToRepository(baseDirectory);
        initialCommitRepository(baseDirectory);
        result := self;
    end;
end.

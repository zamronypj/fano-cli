(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit InitGitRepoTaskImpl;

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
     * git repository using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TInitGitRepoTask = class(TBaseGitRepoTask)
    private
        commitRepoTask : ITask;
        procedure initGitRepository(const baseDir : string);
        procedure addFanoRepository(const baseDir : string);
        procedure stageFileToRepository(const baseDir : string);
    public
        constructor create(const commitRepo : ITask);
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;


    constructor TInitGitRepoTask.create(const commitRepo : ITask);
    begin
        commitRepoTask := commitRepo;
    end;

    destructor TInitGitRepoTask.destroy();
    begin
        inherited destroy();
        commitRepoTask := nil;
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
        ///$ git submodule add fano_repo_url vendor/fano
        runGit(baseDir, ['submodule', 'add', FANO_REPO, 'vendor/fano'], outputString);
        writeln(outputString);
    end;

    procedure TInitGitRepoTask.stageFileToRepository(const baseDir : string);
    var outputString : string;
    begin
        ///$ git add .
        runGit(baseDir, ['add', '.'], outputString);
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
        commitRepoTask.run(opt, longOpt);
        result := self;
    end;
end.

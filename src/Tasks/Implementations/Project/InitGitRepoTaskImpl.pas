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
        procedure initGitRepository(const baseDir : string);
        procedure addFanoRepository(const baseDir : string);
        procedure stageFileToRepository(const baseDir : string);
        procedure initialCommitRepository(const baseDir : string);
    public
        function run(
            const opt : ITaskOptions;
            const shortOpt : char;
            const longOpt : string
        ) : ITask; override;
    end;

implementation

uses

    sysutils,
    process;

    procedure TInitGitRepoTask.initGitRepository(const baseDir : string);
    var outputString : string;
    begin
        if (runCommandInDir(baseDir, '/usr/bin/git', ['init'], outputString)) then
        begin
            writeln(outputString);
        end;
    end;

    procedure TInitGitRepoTask.addFanoRepository(const baseDir : string);
    var outputString : string;
        status : boolean;
    begin
        status := runCommandInDir(
            baseDir,
            '/usr/bin/git',
            ['submodule', 'add', 'https://github.com/fanoframework/fano.git'],
            outputString
        );
        if (status) then
        begin
            writeln(outputString);
        end;
    end;

    procedure TInitGitRepoTask.stageFileToRepository(const baseDir : string);
    var outputString : string;
        status : boolean;
    begin
        status := runCommandInDir(
            baseDir,
            '/usr/bin/git',
            ['add', '.'],
            outputString
        );
        if (status) then
        begin
            writeln(outputString);
        end;
    end;

    procedure TInitGitRepoTask.initialCommitRepository(const baseDir : string);
    var outputString : string;
        status : boolean;
    begin
        status := runCommandInDir(
            baseDir,
            '/usr/bin/git',
            ['commit', '-m', '"Initial commit"'],
            outputString
        );
        if (status) then
        begin
            writeln(outputString);
        end;
    end;

    function TInitGitRepoTask.run(
        const opt : ITaskOptions;
        const shortOpt : char;
        const longOpt : string
    ) : ITask;
    begin
        inherited run(opt, shortOpt, longOpt);
        initGitRepository(baseDirectory);
        addFanoRepository(baseDirectory);
        stageFileToRepository(baseDirectory);
        initialCommitRepository(baseDirectory);
        result := self;
    end;
end.

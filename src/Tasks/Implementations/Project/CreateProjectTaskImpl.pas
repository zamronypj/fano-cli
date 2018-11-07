(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateProjectTaskImpl;

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
     * directory structure using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectTask = class(TBaseProjectTask)
    private
        createDirectoryTask : ITask;
        createShellScriptsTask : ITask;
        createAppConfigsTask : ITask;
        createAdditionalFilesTask : ITask;
        createGitRepoTask : ITask;
    public
        constructor create(
            const createDirTask : ITask;
            const createScriptsTask : ITask;
            const createConfigsTask : ITask;
            const createAddFilesTask : ITask;
            const createRepoTask : ITask
        );
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const shortOpt : char;
            const longOpt : string
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    constructor TCreateProjectTask.create(
        const createDirTask : ITask;
        const createScriptsTask : ITask;
        const createConfigsTask : ITask;
        const createAddFilesTask : ITask;
        const createRepoTask : ITask
    );
    begin
        createDirectoryTask := createDirTask;
        createShellScriptsTask := createScriptsTask;
        createAppConfigsTask := createConfigsTask;
        createAdditionalFilesTask := createAddFilesTask;
        createGitRepoTask := createRepoTask;
    end;

    destructor TCreateProjectTask.destroy();
    begin
        inherited destroy();
        createDirectoryTask := nil;
        createShellScriptsTask := nil;
        createAppConfigsTask := nil;
        createAdditionalFilesTask := nil;
        createGitRepoTask := nil;
    end;

    function TCreateProjectTask.run(
        const opt : ITaskOptions;
        const shortOpt : char;
        const longOpt : string
    ) : ITask;
    begin
        inherited run(opt, shortOpt, longOpt);
        writeln('Start creating project in ', baseDirectory, ' directory.');

        createDirectoryTask.run(opt, shortOpt, longOpt);
        createShellScriptsTask.run(opt, shortOpt, longOpt);
        createAppConfigsTask.run(opt, shortOpt, longOpt);
        createAdditionalFilesTask.run(opt, shortOpt, longOpt);
        //TODO: create application bootstrap file
        createGitRepoTask.run(opt, shortOpt, longOpt);
        writeln('Finish creating project.');
        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit AddFanoRepoTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseGitRepoTaskImpl;

type

    (*!--------------------------------------
     * Task that add fano web framework git repository
     * as submodule
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TAddFanoRepoTask = class(TBaseGitRepoTask)
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    function TAddFanoRepoTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var outputString : string;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);

        // following line equals calling following command on shell
        // $ git submodule add fano_repo_url vendor/fano
        runGit(baseDirectory, ['submodule', 'add', FANO_REPO, 'vendor/fano'], outputString);
        writeln(outputString);
        result := self;
    end;
end.

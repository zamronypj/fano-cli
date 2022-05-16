(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
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
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    function TInitGitRepoTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var outputString : string;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);

        //following line equals calling following command on shell
        // $ git init
        runGit(baseDirectory, ['init'], outputString);
        writeln(outputString);

        result := self;
    end;
end.

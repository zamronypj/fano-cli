(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseGitRepoTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    BaseProjectTaskImpl;

const

    FANO_REPO = 'https://github.com/fanoframework/fano.git';

type

    (*!--------------------------------------
     * Base task that create web application project
     * git repository using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseGitRepoTask = class(TBaseProjectTask)
    protected
        function runGit(
            const baseDir : string;
            const params : array of string;
            out outputString : string
        ) : boolean;
    end;

implementation

uses

    sysutils,
    process;

const

    GIT_BIN = 'git';

    function TBaseGitRepoTask.runGit(
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

end.

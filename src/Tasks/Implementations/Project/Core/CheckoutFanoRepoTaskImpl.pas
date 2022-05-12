(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CheckoutFanoRepoTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseGitRepoTaskImpl;

type

    (*!--------------------------------------
     * Task that checkout fano web framework
     * to a specific release version
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCheckoutFanoRepoTask = class(TBaseGitRepoTask)
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    function TCheckoutFanoRepoTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var outputString : string;
        branch, fanoAbsDir : string;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);

        if opt.hasOption('fano-ver') then
        begin
            branch := opt.getOptionValueDef('fano-ver', 'master');
            fanoAbsDir := getCurrentDir() + '/' + baseDirectory + '/vendor/fano';
            // following line equals calling following command on shell
            // $ cd vendor/fano
            // $ git checkout [[tag/branch]]
            runGit(fanoAbsDir, ['checkout', branch ], outputString);
            if (branch <> 'master') then
            begin
                runGit(fanoAbsDir, ['checkout', '-b', 'fano-' + branch ], outputString);
            end;
            writeln(outputString);
        end;
        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateAdditionalFilesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * additional files (README, .gitignore etc)
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAdditionalFilesTask = class(TCreateFileTask)
    private
        procedure createAdditionalFiles(const dir : string);
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    procedure TCreateAdditionalFilesTask.createAdditionalFiles(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/readme.md.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/gitignore.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/htaccess.example.inc}
    begin
        createTextFile(dir + '/README.md', strReadme);
        createTextFile(dir + '/.gitignore', strGitignore);
        createTextFile(dir + '/public/htaccess.example', strHtaccessExampleInc);
        createTextFile(dir + '/public/.htaccess', strHtaccessExampleInc);
        createTextFile(dir + '/bin/README.md', '# directory for binary output');
        createTextFile(dir + '/bin/unit/README.md', '# directory for compiled units');
    end;

    function TCreateAdditionalFilesTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createAdditionalFiles(baseDirectory);
        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateDirTaskImpl;

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
    TCreateDirTask = class(TBaseProjectTask)
    private
        function createDirIfNotExists(const dir : string) : string;
        procedure createDirectoryStructures(const baseDir : string);
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    function TCreateDirTask.createDirIfNotExists(const dir : string) : string;
    begin
        result := dir;
        if (not directoryExists(result)) then
        begin
            mkdir(result);
        end;
    end;

    procedure TCreateDirTask.createDirectoryStructures(const baseDir : string);
    var currentDir : string;
    begin
        createDirIfNotExists(baseDir);
        currentDir := getCurrentDir();
        chDir(baseDir);

        createDirIfNotExists('app');
        createDirIfNotExists('app/App');
        createDirIfNotExists('app/config');
        createDirIfNotExists('app/Dependencies');
        createDirIfNotExists('app/public');
        createDirIfNotExists('app/Routes');
        createDirIfNotExists('app/Templates');
        createDirIfNotExists('app/storages');
        createDirIfNotExists('app/storages/logs');

        createDirIfNotExists('bin');
        createDirIfNotExists('bin/unit');

        createDirIfNotExists('tools');
        chDir(currentDir);
    end;

    function TCreateDirTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createDirectoryStructures(baseDirectory);
        result := self;
    end;
end.

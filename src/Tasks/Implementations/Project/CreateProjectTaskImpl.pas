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
    TaskIntf;

type

    (*!--------------------------------------
     * Task that create web application project
     * directory structure using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectTask = class(TInterfacedObject, ITask)
    private
        function createBaseDirectory(
            const opt : ITaskOptions;
            const shortOpt : char;
            const longOpt : string
        ) : string;
        function createAppDirectory(const baseDir : string) : string;
        procedure createDirectoryStructures(
            const opt : ITaskOptions;
            const shortOpt : char;
            const longOpt : string
        );
    public
        function run(
            const opt : ITaskOptions;
            const shortOpt : char;
            const longOpt : string
        ) : ITask;
    end;

implementation

uses

    sysutils;

resourcestring

    sErrCannotCreateDir = 'Cannot create directory %s';

    function TCreateProjectTask.createBaseDirectory(
        const opt : ITaskOptions;
        const shortOpt : char;
        const longOpt : string
    ) : string;
    begin
        result := opt.getOptionValue(shortOpt, longOpt);
        if (not directoryExists(result)) then
        begin
            mkdir(result);
        end;
    end;

    function TCreateProjectTask.createAppDirectory(const baseDir : string) : string;
    begin
        result := 'app';
        if (not directoryExists(result)) then
        begin
            mkdir(result);
        end;
    end;

    procedure TCreateProjectTask.createDirectoryStructures(
        const opt : ITaskOptions;
        const shortOpt : char;
        const longOpt : string
    );
    var baseDir, currentDir : string;
    begin
        baseDir := createBaseDirectory(opt, shortOpt, longOpt);
        currentDir := getCurrentDir();
        chDir(baseDir);
        createAppDirectory(baseDir);
        chDir(currentDir);
    end;

    function TCreateProjectTask.run(
        const opt : ITaskOptions;
        const shortOpt : char;
        const longOpt : string
    ) : ITask;
    begin
        writeln('Start creating project.');

        writeln('Creating directories structures..');
        createDirectoryStructures(opt, shortOpt, longOpt);

        writeln('Creating shell scripts..');
        //TODO: create shell scripts
        writeln('Creating application compiler config..');
        //TODO: create application compiler config
        writeln('Creating application bootstrap..');
        //TODO: create application bootstrap file
        writeln('Finish creating project.');
        result := self;
    end;
end.

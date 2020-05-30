(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateSessionDirTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DirectoryCreatorIntf,
    BaseProjectTaskImpl;

type

    (*!--------------------------------------
     * Task that create session directory
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateSessionDirTask = class(TBaseProjectTask)
    private
        directoryCreator : IDirectoryCreator;
        procedure createSessionDirectory(const baseDir : string);

    public
        constructor create(const dirCreator : IDirectoryCreator);
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    constructor TCreateSessionDirTask.create(const dirCreator : IDirectoryCreator);
    begin
        directoryCreator := dirCreator;
    end;

    destructor TCreateSessionDirTask.destroy();
    begin
        directoryCreator := nil;
        inherited destroy();
    end;

    procedure TCreateSessionDirTask.createSessionDirectory(const baseDir : string);
    var currentDir : string;
    begin
        directoryCreator.createDirIfNotExists(baseDir);
        currentDir := getCurrentDir();
        chDir(baseDir);
        directoryCreator.createDirIfNotExists('storages/sessions');
        chDir(currentDir);
    end;

    function TCreateSessionDirTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createSessionDirectory(baseDirectory);
        result := self;
    end;
end.

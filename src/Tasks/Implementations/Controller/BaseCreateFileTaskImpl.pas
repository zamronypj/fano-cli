(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit BaseCreateFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    DirectoryCreatorIntf;

type

    (*!--------------------------------------
     * Task that create web application project
     * files using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseCreateFileTask = class(TInterfacedObject, ITask)
    private
        textFileCreator : ITextFileCreator;
        directoryCreator : IDirectoryCreator;
    protected
        procedure createTextFile(const filename : string; const content : string);
        function createDirIfNotExists(const dir : string) : string;
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const dirCreator : IDirectoryCreator
        );
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; virtual; abstract;
    end;

implementation

    constructor TBaseCreateFileTask.create(
        const txtFileCreator : ITextFileCreator;
        const dirCreator : IDirectoryCreator
    );
    begin
        textFileCreator := txtFileCreator;
        directoryCreator := dirCreator;
    end;

    destructor TBaseCreateFileTask.destroy();
    begin
        inherited destroy();
        textFileCreator := nil;
        directoryCreator := nil;
    end;

    function TBaseCreateFileTask.createDirIfNotExists(const dir : string) : string;
    begin
        result := directoryCreator.createDirIfNotExists(dir);
    end;

    procedure TBaseCreateFileTask.createTextFile(const filename : string; const content : string);
    begin
        textFileCreator.createTextFile(filename, content);
    end;
end.

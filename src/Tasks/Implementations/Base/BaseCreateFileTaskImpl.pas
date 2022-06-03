(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseCreateFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    DirectoryCreatorIntf,
    CreateFileConsts;

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
        baseDirectory : string;
        contentModifier : IContentModifier;
        procedure createTextFile(const filename : string; const content : string);
        function createDirIfNotExists(const dir : string) : string;
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const dirCreator : IDirectoryCreator;
            const cntModifier : IContentModifier;
            const baseDir : string = BASE_DIRECTORY
        );
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; virtual;
    end;

implementation

    constructor TBaseCreateFileTask.create(
        const txtFileCreator : ITextFileCreator;
        const dirCreator : IDirectoryCreator;
        const cntModifier : IContentModifier;
        const baseDir : string = BASE_DIRECTORY
    );
    begin
        textFileCreator := txtFileCreator;
        directoryCreator := dirCreator;
        contentModifier := cntModifier;
        baseDirectory := baseDir;
    end;

    destructor TBaseCreateFileTask.destroy();
    begin
        inherited destroy();
        textFileCreator := nil;
        directoryCreator := nil;
        contentModifier := nil;
    end;

    function TBaseCreateFileTask.createDirIfNotExists(const dir : string) : string;
    begin
        result := directoryCreator.createDirIfNotExists(dir);
    end;

    procedure TBaseCreateFileTask.createTextFile(const filename : string; const content : string);
    begin
        textFileCreator.createTextFile(
            filename,
            contentModifier.modify(content)
        );
    end;

    function TBaseCreateFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var appName : string;
    begin
        appName := opt.getOptionValue('app-name');
        if (appName <> '') then
        begin
            contentModifier.setVar('[[APP_NAME]]', appName);
        end;
        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFileWithCopyrightTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    DirectoryCreatorIntf,
    ContentModifierIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * files using fano web framework and modify
     * copyright section
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFileWithCopyrightTask = class(TBaseCreateFileTask)
    private
        copyrightContentModifier : IContentModifier;
    protected
        procedure createTextFile(const filename : string; const content : string);
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const dirCreator : IDirectoryCreator;
            const contentModifier : IContentModifier;
            const baseDir : string = BASE_DIRECTORY
        );
        destructor destroy(); override;

    end;

implementation

    constructor TCreateFileWithCopyrightTask.create(
        const txtFileCreator : ITextFileCreator;
        const dirCreator : IDirectoryCreator;
        const contentModifier : IContentModifier;
        const baseDir : string = BASE_DIRECTORY
    );
    begin
        inherited create(txtFileCreator, dirCreator, baseDir);
        copyrightContentModifier := contentModifier;
    end;

    destructor TCreateFileWithCopyrightTask.destroy();
    begin
        inherited destroy();
        copyrightContentModifier := nil;
    end;

    procedure TCreateFileWithCopyrightTask.createTextFile(const filename : string; const content : string);
    begin
        inherited createTextFile(
            filename,
            copyrightContentModifier.modify(content)
        );
    end;
end.

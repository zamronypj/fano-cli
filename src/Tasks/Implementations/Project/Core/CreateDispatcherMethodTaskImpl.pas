(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDispatcherMethodTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    FileContentReaderIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that add basic setup for buildDispatcher
     * to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateDispatcherMethodTask = class (TCreateFileTask)
    private
        fFileReader : IFileContentReader;
    protected
        procedure createBuildDispatcherDependencyTpl(const methodDecl, methodImpl : string);
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier;
            const fileReader : IFileContentReader
        );
        destructor destroy(); override;

    end;

implementation

    constructor TCreateDispatcherMethodTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const fileReader : IFileContentReader
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fFileReader := fileReader;
    end;

    destructor TCreateDispatcherMethodTask.destroy();
    begin
        fFileReader := nil;
        inherited destroy();
    end;

    procedure TCreateDispatcherMethodTask.createBuildDispatcherDependencyTpl(const methodDecl, methodImpl : string);
    var
        bootstrapContent : string;
    begin
        fContentModifier.setVar(
            '[[BUILD_DISPATCHER_METHOD_DECL_SECTION]]',
            methodDecl
        );

        fContentModifier.setVar(
            '[[BUILD_DISPATCHER_METHOD_IMPL_SECTION]]',
            methodImpl
        );

        bootstrapContent := fFileReader.read(baseDirectory + '/src/bootstrap.pas');

        createTextFile(
            baseDirectory + '/src/bootstrap.pas',
            fContentModifier.modify(bootstrapContent)
        );
    end;

end.

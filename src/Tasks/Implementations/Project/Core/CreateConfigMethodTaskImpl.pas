(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateConfigMethodTaskImpl;

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
     * Task that add buildConfig() method
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateConfigMethodTask = class(TCreateFileTask)
    private
        fFileReader : IFileContentReader;
        procedure createBuildConfigDependencyTpl(const methodDecl, methodImpl : string);
        procedure createBuildConfigDependency();
        procedure dontCreateBuildConfigDependency();
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier;
            const fileReader : IFileContentReader
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    constructor TCreateConfigMethodTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const fileReader : IFileContentReader
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fFileReader := fileReader;
    end;

    destructor TCreateConfigMethodTask.destroy();
    begin
        fFileReader := nil;
        inherited destroy();
    end;

    procedure TCreateConfigMethodTask.createBuildConfigDependencyTpl(const methodDecl, methodImpl : string);
    var
        bootstrapContent : string;
    begin
        fContentModifier.setVar(
            '[[BUILD_CONFIG_METHOD_DECL_SECTION]]',
            fContentModifier.modify(methodDecl)
        );

        fContentModifier.setVar(
            '[[BUILD_CONFIG_METHOD_IMPL_SECTION]]',
            fContentModifier.modify(methodImpl)
        );

        bootstrapContent := fFileReader.read(baseDirectory + '/src/bootstrap.pas');
        createTextFile(
            baseDirectory + '/src/bootstrap.pas',
            fContentModifier.modify(bootstrapContent)
        );
    end;

    procedure TCreateConfigMethodTask.createBuildConfigDependency();
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/methods/buildAppConfig.decl.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/methods/buildAppConfig.impl.inc}
    begin
        createBuildConfigDependencyTpl(
            strBuildAppConfigMethodDecl,
            strBuildAppConfigMethodImpl
        );
    end;

    procedure TCreateConfigMethodTask.dontCreateBuildConfigDependency();
    begin
        createBuildConfigDependencyTpl('', '');
    end;

    function TCreateConfigMethodTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);

        if (opt.hasOption('config')) then
        begin
            createBuildConfigDependency();
        end else
        begin
            dontCreateBuildConfigDependency();
        end;

        result := self;
    end;
end.

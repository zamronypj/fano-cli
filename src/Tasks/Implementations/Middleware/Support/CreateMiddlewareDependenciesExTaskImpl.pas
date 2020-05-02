(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMiddlewareDependenciesExTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    FileContentAppenderIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that add middleware support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMiddlewareDependenciesExTask = class(TCreateFileTask)
    private
        fFileAppender : IFileContentAppender;
        procedure createBuildDispatcherDependencyTpl(const methodDecl, methodImpl : string);
        procedure createBuildDispatcherDependency();
        procedure dontCreateBuildDispatcherDependency();
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier;
            const fAppend : IFileContentAppender
        );
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    constructor TCreateMiddlewareDependenciesExTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const fAppend : IFileContentAppender
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fFileAppender := fAppend;
    end;

    destructor TCreateMiddlewareDependenciesExTask.destroy();
    begin
        fFileAppender := nil;
        inherited destroy();
    end;

    procedure TCreateMiddlewareDependenciesExTask.createBuildDispatcherDependencyTpl(const methodDecl, methodImpl : string);
    var
        bootstrapContent : string;
    begin
        fContentModifier.setVar(
            '[[BUILD_DISPATCHER_METHOD_DECL_SECTION]]',
            fContentModifier.modify(methodDecl)
        );

        fContentModifier.setVar(
            '[[BUILD_DISPATCHER_METHOD_IMPL_SECTION]]',
            fContentModifier.modify(methodImpl)
        );

        bootstrapContent := fFileReader.read(baseDirectory + '/src/bootstrap.pas');
        createTextFile(
            baseDirectory + '/src/bootstrap.pas',
            fContentModifier.modify(bootstrapContent)
        );
    end;

    procedure TCreateMiddlewareDependenciesExTask.createBuildDispatcherDependency();
    var
        {$INCLUDE src/Tasks/Implementations/Middleware/Support/Includes/buildDispatcher.decl.inc}
        {$INCLUDE src/Tasks/Implementations/Middleware/Support/Includes/buildDispatcher.impl.inc}
    begin
        createBuildDispatcherDependencyTpl(strBuildDispatcherDecl, strBuildDispatcherImpl);
    end;

    procedure TCreateMiddlewareDependenciesExTask.dontCreateBuildDispatcherDependency();
    begin
        createBuildDispatcherDependencyTpl('', '');
    end;

    function TCreateMiddlewareDependenciesExTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);

        if (opt.hasOption('with-middleware')) then
        begin
            createBuildDispatcherDependency();
        end else
        begin
            dontCreateBuildDispatcherDependency();
        end;

        result := self;
    end;
end.

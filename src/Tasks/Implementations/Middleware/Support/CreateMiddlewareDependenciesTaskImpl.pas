(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMiddlewareDependenciesTaskImpl;

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
    TCreateMiddlewareDependenciesTask = class(TCreateFileTask)
    private
        fFileAppender : IFileContentAppender;
        procedure createDependencies(const dir : string);
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

    constructor TCreateMiddlewareDependenciesTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const fAppend : IFileContentAppender
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fFileAppender := fAppend;
    end;

    destructor TCreateMiddlewareDependenciesTask.destroy();
    begin
        fFileAppender := nil;
        inherited destroy();
    end;

    function TCreateMiddlewareDependenciesTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        if (opt.hasOption('with-middleware')) then
        begin
            createDependencies(baseDirectory + '/src/Dependencies');
        end;
        result := self;
    end;

    procedure TCreateMiddlewareDependenciesTask.createDependencies(const dir : string);
    var
        depStr : string;
        {$INCLUDE src/Tasks/Implementations/Middleware/Support/Includes/middleware.dependencies.inc.inc}
    begin
        depStr := fContentModifier.modify(strMiddlewareDependencies);
        createTextFile(dir + '/middleware.support.dependencies.inc', depStr);
        fFileAppender.append(
            dir + '/main.dependencies.inc',
            LineEnding + '{$INCLUDE middleware.support.dependencies.inc}'
        );
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseCreateSessionDependenciesTaskImpl;

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
     * Base task that add file session support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseCreateSessionDependenciesTask = class(TCreateFileTask)
    protected
        fFileAppender : IFileContentAppender;
        procedure createDependencies(const dir : string); virtual; abstract;
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

    constructor TBaseCreateSessionDependenciesTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const fAppend : IFileContentAppender
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fFileAppender := fAppend;
    end;

    destructor TBaseCreateSessionDependenciesTask.destroy();
    begin
        fFileAppender := nil;
        inherited destroy();
    end;

    function TBaseCreateSessionDependenciesTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createDependencies(baseDirectory + '/src/Dependencies');
        result := self;
    end;
end.

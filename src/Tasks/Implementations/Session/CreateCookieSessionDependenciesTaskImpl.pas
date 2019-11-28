(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateCookieSessionDependenciesTaskImpl;

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
     * Task that add cookie session support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateCookieSessionDependenciesTask = class(TCreateFileTask)
    private
        fFileAppender : IFileContentAppender;
        procedure createDependencies(const sessType : string; const dir : string);
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

    constructor TCreateCookieSessionDependenciesTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const fAppend : IFileContentAppender
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fFileAppender := fAppend;
    end;

    destructor TCreateCookieSessionDependenciesTask.destroy();
    begin
        fFileAppender := nil;
        inherited destroy();
    end;

    procedure TCreateCookieSessionDependenciesTask.createDependencies(
        const sessType : string;
        const dir : string
    );
    var
        depStr : string;
        sessFactory : string;
        {$INCLUDE src/Tasks/Implementations/Session/Includes/cookie.session.dependencies.inc.inc}
    begin
        if (sessType = 'ini') then
        begin
            sessFactory := 'TIniSessionFactory';
        end else
        begin
            sessFactory := 'TJsonSessionFactory';
        end;
        depStr := fContentModifier
            .setVar('[[SESSION_FACTORY]]', sessFactory)
            .modify(strCookieSession);
        createTextFile(dir + '/session.dependencies.inc', depStr);
        fFileAppender.append(
            dir + '/main.dependencies.inc',
            LineEnding + '{$INCLUDE session.dependencies.inc}'
        );
    end;

    function TCreateCookieSessionDependenciesTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var sessType : string;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        sessType := opt.getOptionValueDef('type', 'json');
        createDependencies(sessType, baseDirectory + '/src/Dependencies');
        result := self;
    end;
end.

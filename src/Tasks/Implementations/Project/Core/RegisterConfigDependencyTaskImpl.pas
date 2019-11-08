(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit RegisterConfigDependencyTaskImpl;

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
     * Task that register config dependency
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TRegisterConfigDependencyTask = class(TCreateFileTask)
    private
        fFileAppender : IFileContentAppender;
        procedure registerConfigDependency(
            const dir : string;
            const configType : string;
            const projectType : string
        );
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier;
            const fileAppender : IFileContentAppender
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    constructor TRegisterConfigDependencyTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const fileAppender : IFileContentAppender
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fFileAppender := fileAppender;
    end;

    destructor TRegisterConfigDependencyTask.destroy();
    begin
        fFileAppender := nil;
        inherited destroy();
    end;

    procedure TRegisterConfigDependencyTask.registerConfigDependency(
        const dir : string;
        const configType : string;
        const projectType : string
    );
    var
        factoryClass : string;
        configPath : string;
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/appconfig.dependencies.inc.inc}
    begin
        if (configType = 'ini') then
        begin
            factoryClass := 'TIniFileConfigFactory';
            configPath := '/config/config.ini';
        end else
        begin
            factoryClass := 'TJsonFileConfigFactory';
            configPath := '/config/config.json';
        end;

        if (projectType = 'project') or (projectType = 'project-cgi') or
            (projectType = 'project-fcgid') then
        begin
            appDir := 'extractFileDir(getCurrentDir())';
        end else
        begin
            appDir := 'getCurrentDir()';
        end;

        fContentModifier.setVar('[[FACTORY_CLASS]]', factoryClass);
        fContentModifier.setVar('[[APP_CONFIG_FILE]]', configPath);
        fContentModifier.setVar('[[BASE_DIR]]', appDir);

        createTextFile(
            dir + '/appconfig.dependencies.inc',
            fContentModifier.modify(strAppConfigDependenciesInc)
        );

        fFileAppender.append(
            dir + '/main.dependencies.inc',
            '{$INCLUDE appconfig.dependencies.inc}' + LineEnding
        );
    end;

    function TRegisterConfigDependencyTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        registerConfigDependency(baseDirectory, configType, longOpt);
        result := self;
    end;
end.

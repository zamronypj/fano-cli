(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
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
    FileContentReaderIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that register config dependency
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TRegisterConfigDependencyTask = class(TCreateFileTask)
    private
        fFileReader : IFileContentReader;
        procedure registerConfigDependency(
            const dir : string;
            const configType : string;
            const projectType : string
        );
        procedure registerDefaultConfigDependency();
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

    constructor TRegisterConfigDependencyTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const fileReader : IFileContentReader
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fFileReader := fileReader;
    end;

    destructor TRegisterConfigDependencyTask.destroy();
    begin
        fFileReader := nil;
        inherited destroy();
    end;

    procedure TRegisterConfigDependencyTask.registerDefaultConfigDependency();
    var
        bootstrapContent : string;
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/default.appconfig.dependencies.inc.inc}
    begin
        fContentModifier.setVar(
            '[[CONFIG_IMPL_SECTION]]',
            fContentModifier.modify(strDefaultAppConfigDependenciesInc)
        );

        bootstrapContent := fFileReader.read(baseDirectory + '/src/bootstrap.pas');
        createTextFile(
            baseDirectory + '/src/bootstrap.pas',
            fContentModifier.modify(bootstrapContent)
        );
    end;

    procedure TRegisterConfigDependencyTask.registerConfigDependency(
        const dir : string;
        const configType : string;
        const projectType : string
    );
    var
        factoryClass : string;
        configPath : string;
        appDir : string;
        bootstrapContent : string;
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
        fContentModifier.setVar(
            '[[CONFIG_IMPL_SECTION]]',
            fContentModifier.modify(strAppConfigDependenciesInc)
        );

        bootstrapContent := fFileReader.read(baseDirectory + '/src/bootstrap.pas');
        createTextFile(
            baseDirectory + '/src/bootstrap.pas',
            fContentModifier.modify(bootstrapContent)
        );
    end;

    function TRegisterConfigDependencyTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var configType : string;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);

        if (opt.hasOption('config')) then
        begin
            configType := opt.getOptionValueDef('config', 'json');
            registerConfigDependency(baseDirectory + '/src/Dependencies', configType, longOpt);
        end else
        begin
            registerDefaultConfigDependency();
        end;

        result := self;
    end;
end.

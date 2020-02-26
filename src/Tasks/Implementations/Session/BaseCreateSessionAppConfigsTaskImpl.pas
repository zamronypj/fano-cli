(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseCreateSessionAppConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    KeyGeneratorIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * base task that create web application config files
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseCreateSessionAppConfigsTask = class(TCreateFileTask)
    protected
        fKeyGenerator : IKeyGenerator;
        procedure createAppConfigs(
            const baseDir : string;
            const configDir : string
        ); virtual;

        function getConfigType() : string; virtual; abstract;
        function getConfigTemplate() : string; virtual; abstract;
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier;
            const keyGen : IKeyGenerator
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    constructor TBaseCreateSessionAppConfigsTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const keyGen : IKeyGenerator
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fKeyGenerator := keyGen;
    end;

    destructor TBaseCreateSessionAppConfigsTask.destroy();
    begin
        fKeyGenerator := nil;
        inherited destroy();
    end;

    procedure TBaseCreateSessionAppConfigsTask.createAppConfigs(
        const baseDir : string;
        const configDir : string
    );
    var
        configType,
        configStr,
        configStrWithoutKey,
        configStrWithKey : string;
    begin
        configStr := fContentModifier
            .setVar('[[APP_NAME]]', 'My App')
            .setVar('[[BASE_URL]]', 'http://myapp.fano')
            .setVar('[[SESSION_NAME]]', 'fano_sess')
            .setVar('[[SESSION_DIR]]', getCurrentDir() + '/' + baseDir + '/storages/sessions/')
            .setVar('[[COOKIE_NAME]]', 'fano_sess')
            .setVar('[[COOKIE_DOMAIN]]', 'myapp.fano')
            .setVar('[[COOKIE_MAX_AGE]]', '3600')
            .modify(getConfigTemplate());

        configStrWithoutKey := fContentModifier
            .setVar('[[SECRET_KEY]]', 'replace with your own secret key')
            .modify(configStr);

        configStrWithKey := fContentModifier
            .setVar('[[SECRET_KEY]]', fKeyGenerator.generate(64))
            .modify(configStr);

        configType := getConfigType();
        createTextFile(configDir + '/config.' + configType, configStrWithKey);
        createTextFile(configDir + '/config.'+ configType +'.sample', configStrWithoutKey);
    end;

    function TBaseCreateSessionAppConfigsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createAppConfigs(baseDirectory, baseDirectory + '/config');
        result := self;
    end;
end.

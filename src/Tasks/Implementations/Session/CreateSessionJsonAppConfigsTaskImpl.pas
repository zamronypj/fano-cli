(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateSessionJsonAppConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ContentModifierIntf,
    KeyGeneratorIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * compiler config files using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateSessionAppConfigsTask = class(TCreateFileTask)
    private
        fContentModifier : IContentModifier;
        fKeyGenerator : IKeyGenerator;
        procedure createJsonAppConfigs(const dir : string);
        procedure createIniAppConfigs(const dir : string);
    public
        constructor create(
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

    constructor TCreateSessionAppConfigsTask.create(
        const contentModifier : IContentModifier;
        const keyGen : IKeyGenerator
    );
    begin
        fContentModifier := contentModifier;
        fKeyGenerator := keyGen;
    end;

    destructor TCreateSessionAppConfigsTask.destroy();
    begin
        fContentModifier := nil;
        inherited destroy();
    end;

    procedure TCreateSessionAppConfigsTask.createJsonAppConfigs(const dir : string);
    var
        configStr : string;
        {$INCLUDE src/Tasks/Implementations/Session/Includes/config.json.inc}
    begin
        configStr := fContentModifier
            .setVar('[[APP_NAME]]', 'My App')
            .setVar('[[BASE_URL]]', 'myapp.fano')
            .setVar('[[SECRET_KEY]]', fKeyGenerator.generate(64))
            .setVar('[[SESSION_NAME]]', 'fano_sess')
            .setVar('[[SESSION_DIR]]', 'storages/sessions/')
            .setVar('[[COOKIE_NAME]]', 'fano_sess')
            .setVar('[[COOKIE_DOMAIN]]', 'myapp.fano')
            .setVar('[[COOKIE_MAX_AGE]]', '3600')
            .modify(strConfigJson);
        createTextFile(dir + '/config.json', configStr);
        createTextFile(dir + '/config.json.sample', configStr);
    end;

    procedure TCreateSessionAppConfigsTask.createIniAppConfigs(const dir : string);
    begin
        createTextFile(
            dir + '/config.ini',
            '[fano]' + LineEnding +
            'appName=MyApp'
        );
        createTextFile(
            dir + '/config.ini.sample',
            '[fano]' + LineEnding +
            'appName=MyApp'
        );
    end;

    function TCreateSessionAppConfigsTask.run(
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
            if (configType = 'ini') then
            begin
                createIniAppConfigs(baseDirectory + '/config');
            end else
            begin
                createJsonAppConfigs(baseDirectory + '/config');
            end;
        end;
        result := self;
    end;
end.

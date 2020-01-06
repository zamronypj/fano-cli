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
    BaseCreateSessionAppConfigsTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application json config files
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateSessionJsonAppConfigsTask = class(TBaseCreateSessionAppConfigsTask)
    protected
        procedure createAppConfigs(
            const baseDir : string;
            const configDir : string
        ); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateSessionJsonAppConfigsTask.createAppConfigs(
        const baseDir : string;
        const configDir : string
    );
    var
        configStr : string;
        {$INCLUDE src/Tasks/Implementations/Session/Includes/config.json.inc}
    begin
        configStr := fContentModifier
            .setVar('[[APP_NAME]]', 'My App')
            .setVar('[[BASE_URL]]', 'http://myapp.fano')
            .setVar('[[SECRET_KEY]]', fKeyGenerator.generate(64))
            .setVar('[[SESSION_NAME]]', 'fano_sess')
            .setVar('[[SESSION_DIR]]', getCurrentDir() + '/' + baseDir + '/storages/sessions/')
            .setVar('[[COOKIE_NAME]]', 'fano_sess')
            .setVar('[[COOKIE_DOMAIN]]', 'myapp.fano')
            .setVar('[[COOKIE_MAX_AGE]]', '3600')
            .modify(strConfigJson);
        createTextFile(configDir + '/config.json', configStr);
        createTextFile(configDir + '/config.json.sample', configStr);
    end;

end.

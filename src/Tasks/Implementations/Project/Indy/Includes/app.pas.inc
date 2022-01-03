(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strAppPas: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    'program app;' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '' + LineEnding +
    '    {$IFDEF UNIX}' + LineEnding +
    '    cthreads,' + LineEnding +
    '    {$ENDIF}' + LineEnding +
    '    sysutils,' + LineEnding +
    '    fano,' + LineEnding +
    '    bootstrap;' + LineEnding +
    '' + LineEnding +
    'var' + LineEnding +
    '    appInstance : IWebApplication;' + LineEnding +
    '    cliParams : ICliParams;' + LineEnding +
    '    svrConfig : TFpwebSvrConfig;' + LineEnding +
    '' + LineEnding +
    'begin' + LineEnding +
    '    cliParams := (TGetOptsParams.create() as ICliParamsFactory)' + LineEnding +
    '        .addOption(''host'', 1)' + LineEnding +
    '        .addOption(''port'', 1)' + LineEnding +
    '        .build();' + LineEnding +
    '    svrConfig.host := cliParams.getOption(''host'', ''[[HOST]]'');' + LineEnding +
    '    svrConfig.port := cliParams.getOption(''port'', [[PORT]]);' + LineEnding +
    '    writeln(''Starting application at '', svrConfig.host, '':'', svrConfig.port);' + LineEnding +
    '' + LineEnding +
    '    svrConfig.documentRoot := getCurrentDir() + ''/public'';' + LineEnding +
    '    svrConfig.serverName := ''http.fano'';' + LineEnding +
    '    svrConfig.serverAdmin := ''admin@http.fano'';' + LineEnding +
    '    svrConfig.serverSoftware := ''Fano Framework Web App'';' + LineEnding +
    '    svrConfig.timeout := 120;' + LineEnding +
    '' + LineEnding +
    '    //uncomment following lines support https' + LineEnding +
    '    //svrConfig.useTLS := true;' + LineEnding +
    '    //svrConfig.tlsKey := ''/path/to/ssl/cert/key'';' + LineEnding +
    '    //svrConfig.tlsCert := ''/path/to/ssl/cert/cert'';' + LineEnding +
    '' + LineEnding +
    '    (*!-----------------------------------------------' + LineEnding +
    '     * Bootstrap libmicrohttpd application' + LineEnding +
    '     *' + LineEnding +
    '     * @author AUTHOR_NAME <author@email.tld>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    appInstance := TDaemonWebApplication.create(' + LineEnding +
    '        TIndyAppServiceProvider.create(' + LineEnding +
    '            TAppServiceProvider.create(),' + LineEnding +
    '            svrConfig' + LineEnding +
    '        ),' + LineEnding +
    '        TAppRoutes.create()' + LineEnding +
    '    );' + LineEnding +
    '    appInstance.run();' + LineEnding +
    'end.';

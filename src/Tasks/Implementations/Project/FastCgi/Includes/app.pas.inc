(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
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
    '    fano,' + LineEnding +
    '    bootstrap;' + LineEnding +
    '' + LineEnding +
    'var' + LineEnding +
    '    appInstance : IWebApplication;' + LineEnding +
    '    cliParams : ICliParams;' + LineEnding +
    '    host : string;' + LineEnding +
    '    port : word;' + LineEnding +
    '' + LineEnding +
    'begin' + LineEnding +
    '    cliParams := (TGetOptsParams.create() as ICliParamsFactory)' + LineEnding +
    '        .addOption(''host'', 1)' + LineEnding +
    '        .addOption(''port'', 1)' + LineEnding +
    '        .build();' + LineEnding +
    '    host := cliParams.getOption(''host'', ''[[HOST]]'');' + LineEnding +
    '    port := cliParams.getOption(''port'', [[PORT]]);' + LineEnding +
    '    writeln(''Starting application at '', host, '':'', port);' + LineEnding +
    '' + LineEnding +
    '    (*!-----------------------------------------------' + LineEnding +
    '     * Bootstrap Fast CGI application' + LineEnding +
    '     *' + LineEnding +
    '     * @author AUTHOR_NAME <author@email.tld>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    appInstance := TDaemonWebApplication.create(' + LineEnding +
    '        TFastCgiAppServiceProvider.create(' + LineEnding +
    '            TServerAppServiceProvider.create(' + LineEnding +
    '                TAppServiceProvider.create(),' + LineEnding +
    '                (TInetSvrFactory.create(host, port) as ISocketSvrFactory).build()' + LineEnding +
    '            )' + LineEnding +
    '        ),' + LineEnding +
    '        TAppRoutes.create()' + LineEnding +
    '    );' + LineEnding +
    '    appInstance.run();' + LineEnding +
    'end.';

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
    '' + LineEnding +
    'begin' + LineEnding +
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
    '                (TBoundSvrFactory.create(stdInputHandle) as ISocketSvrFactory).build()' + LineEnding +
    '            )' + LineEnding +
    '        ),' + LineEnding +
    '        TAppRoutes.create()' + LineEnding +
    '    );' + LineEnding +
    '    appInstance.run();' + LineEnding +
    'end.';

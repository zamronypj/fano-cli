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
    '' + LineEnding +
    'begin' + LineEnding +
    '    (*!-----------------------------------------------' + LineEnding +
    '     * Bootstrap application' + LineEnding +
    '     *' + LineEnding +
    '     * @author AUTHOR_NAME <author@email.tld>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    appInstance := TCgiWebApplication.create(' + LineEnding +
    '        TAppServiceProvider.create(),' + LineEnding +
    '        TAppRoutes.create()' + LineEnding +
    '    );' + LineEnding +
    '    appInstance.run();' + LineEnding +
    'end.';

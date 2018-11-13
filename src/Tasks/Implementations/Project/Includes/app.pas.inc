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
    '    appInstance := TBootstrapApp.create(' + LineEnding +
    '        TDependencyContainer.create(TDependencyList.create()),' + LineEnding +
    '        TCGIEnvironment.create(),' + LineEnding +
    '        TErrorHandler.create()' + LineEnding +
    '    );' + LineEnding +
    '    appInstance.run();' + LineEnding +
    'end.';

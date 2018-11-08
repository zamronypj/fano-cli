strAppPas: string = 
    '(*!------------------------------------------------------------' + LineEnding + 
    ' * Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding + 
    ' *' + LineEnding + 
    ' * @link      https://github.com/fanoframework/fano-app' + LineEnding + 
    ' * @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding + 
    ' * @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding + 
    ' *------------------------------------------------------------- *)' + LineEnding + 
    'program app;' + LineEnding + 
    '' + LineEnding + 
    'uses' + LineEnding + 
    '' + LineEnding + 
    '    fano,' + LineEnding + 
    '    myapp;' + LineEnding + 
    '' + LineEnding + 
    'var' + LineEnding + 
    '    appInstance : IWebApplication;' + LineEnding + 
    '' + LineEnding + 
    'begin' + LineEnding + 
    '    (*!-----------------------------------------------' + LineEnding + 
    '     * Bootstrap application' + LineEnding + 
    '     *' + LineEnding + 
    '     * @author Zamrony P. Juhara <zamronypj@yahoo.com>' + LineEnding + 
    '     *------------------------------------------------*)' + LineEnding + 
    '    appInstance := TMyApp.create(' + LineEnding + 
    '        TDependencyContainer.create(TDependencyList.create()),' + LineEnding + 
    '        TCGIEnvironment.create(),' + LineEnding + 
    '        TErrorHandler.create()' + LineEnding + 
    '    );' + LineEnding + 
    '    appInstance.run();' + LineEnding + 
    'end.';

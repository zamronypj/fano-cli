(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strMiddlewareDependencies : string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    '' + LineEnding +
    'container.add(''appMiddlewares'', TMiddlewareListFactory.create());' + LineEnding +
    '' + LineEnding +
    'container.add(' + LineEnding +
    '    GuidToString(IDispatcher),' + LineEnding +
    '    TDispatcherFactory.create(' + LineEnding +
    '        container[''appMiddlewares''] as IMiddlewareLinkList,' + LineEnding +
    '        getRouteMatcher(),' + LineEnding +
    '        TRequestResponseFactory.create()' + LineEnding +
    '    )' + LineEnding +
    ');';

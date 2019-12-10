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
    '        container[''router''] as IRouteMatcher,' + LineEnding +
    '        TRequestResponseFactory.create()' + LineEnding +
    '    )' + LineEnding +
    ');';

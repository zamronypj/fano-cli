strJsonFileSession: string =
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
    '    ''sessionManager'',' + LineEnding +
    '    TJsonFileSessionManagerFactory.create(' + LineEnding +
    '        (container[''config''] as IAppConfiguration).getString(''session.name''),' + LineEnding +
    '        (container[''config''] as IAppConfiguration).getString(''session.dir'')' + LineEnding +
    '    )' + LineEnding +
    ');' + LineEnding +
    '' + LineEnding +
    'container.add(' + LineEnding +
    '    GuidToString(IDispatcher),' + LineEnding +
    '    TSessionDispatcherFactory.create(' + LineEnding +
    '        container[''appMiddlewares''] as IMiddlewareLinkList,' + LineEnding +
    '        container[GuidToString(IRouteMatcher)] as IRouteMatcher,' + LineEnding +
    '        TRequestResponseFactory.create(),' + LineEnding +
    '        container[''sessionManager''] as ISessionManager,' + LineEnding +
    '        (TCookieFactory.create()).domain(' + LineEnding +
    '            (container[''config''] as IAppConfiguration).getString(''cookie.domain'')),' + LineEnding +
    '        (container[''config''] as IAppConfiguration).getInt(''cookie.maxAge'')' + LineEnding +
    '    )' + LineEnding +
    ');';

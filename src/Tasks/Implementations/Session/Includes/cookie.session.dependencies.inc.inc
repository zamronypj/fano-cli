strCookieSession: string =
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
    '    ''encrypter'',' + LineEnding +
    '    TBlowfishEncrypterFactory.create()' + LineEnding +
    '        .secretKey(' + LineEnding +
    '            (container[''config''] as IAppConfiguration).getString(''secretKey'')' + LineEnding +
    '        )' + LineEnding +
    ');' + LineEnding +
    '' + LineEnding +
    'container.add(' + LineEnding +
    '    ''sessionManager'',' + LineEnding +
    '    TCookieSessionManagerFactory.create(' + LineEnding +
    '        [[SESSION_FACTORY]].create(),' + LineEnding +
    '        container[''encrypter''] as IEncrypter,' + LineEnding +
    '        container[''encrypter''] as IDecrypter,' + LineEnding +
    '        (container[''config''] as IAppConfiguration).getString(''session.name'')' + LineEnding +
    '    )' + LineEnding +
    ');' + LineEnding +
    '' + LineEnding +
    'container.add(' + LineEnding +
    '    GuidToString(IDispatcher),' + LineEnding +
    '    TSessionDispatcherFactory.create(' + LineEnding +
    '        container[''appMiddlewares''] as IMiddlewareLinkList,' + LineEnding +
    '        container[''router''] as IRouteMatcher,' + LineEnding +
    '        TRequestResponseFactory.create(),' + LineEnding +
    '        container[''sessionManager''] as ISessionManager,' + LineEnding +
    '        TCookieFactory.create().domain(' + LineEnding +
    '            (container[''config''] as IAppConfiguration).getString(''cookie.domain'')' + LineEnding +
    '        ),' + LineEnding +
    '        (container[''config''] as IAppConfiguration).getInt(''cookie.maxAge'')' + LineEnding +
    '    )' + LineEnding +
    ');';

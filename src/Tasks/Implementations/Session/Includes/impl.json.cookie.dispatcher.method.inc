strImplJsonCookieDispatcherMethod : string =
    '    function TAppServiceProvider.buildDispatcher(' + LineEnding +
    '        const container : IDependencyContainer;' + LineEnding +
    '        const routeMatcher : IRouteMatcher;' + LineEnding +
    '        const config : IAppConfiguration' + LineEnding +
    '    ) : IDispatcher;' + LineEnding +
    '    begin' + LineEnding +
    '        container.add(''appMiddlewares'', TMiddlewareListFactory.create());' + LineEnding +
    '' + LineEnding +
    '        container.add(' + LineEnding +
    '            ''encrypter'',' + LineEnding +
    '            TBlowfishEncrypterFactory.create()' + LineEnding +
    '                .secretKey(config.getString(''secretKey''))' + LineEnding +
    '        );' + LineEnding +
    '' + LineEnding +
    '        container.add(' + LineEnding +
    '            ''sessionManager'',' + LineEnding +
    '            TCookieSessionManagerFactory.create(' + LineEnding +
    '                TJsonSessionFactory.create(),' + LineEnding +
    '                container[''encrypter''] as IEncrypter,' + LineEnding +
    '                container[''encrypter''] as IDecrypter,' + LineEnding +
    '                config.getString(''session.name'')' + LineEnding +
    '            )' + LineEnding +
    '        );' + LineEnding +
    '' + LineEnding +
    '        container.add(' + LineEnding +
    '            GuidToString(IDispatcher),' + LineEnding +
    '            TSessionDispatcherFactory.create(' + LineEnding +
    '                container[''appMiddlewares''] as IMiddlewareLinkList,' + LineEnding +
    '                routeMatcher,' + LineEnding +
    '                TRequestResponseFactory.create(),' + LineEnding +
    '                container[''sessionManager''] as ISessionManager,' + LineEnding +
    '                (TCookieFactory.create()).domain(' + LineEnding +
    '                    config.getString(''cookie.domain'')' + LineEnding +
    '                ),' + LineEnding +
    '                config.getInt(''cookie.maxAge'')' + LineEnding +
    '            )' + LineEnding +
    '        );' + LineEnding +
    '        result := container[GuidToString(IDispatcher)] as IDispatcher;' + LineEnding +
    '    end;' + LineEnding;
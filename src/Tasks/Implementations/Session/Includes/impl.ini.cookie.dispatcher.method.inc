strImplIniCookieDispatcherMethod : string =
    '    procedure TAppServiceProvider.buildDispatcher(' + LineEnding +
    '        const container : IDependencyContainer;' + LineEnding +
    '        const routeMatcher : IRouteMatcher' + LineEnding +
    '    );' + LineEnding +
    '    begin' + LineEnding +
    '        container.add(''appMiddlewares'', TMiddlewareListFactory.create());' + LineEnding +
    '' + LineEnding +
    '        container.add(' + LineEnding +
    '            ''encrypter'',' + LineEnding +
    '            TBlowfishEncrypterFactory.create()' + LineEnding +
    '                .secretKey(' + LineEnding +
    '                    (container[''config''] as IAppConfiguration).getString(''secretKey'')' + LineEnding +
    '                )' + LineEnding +
    '        );' + LineEnding +
    '' + LineEnding +
    '        container.add(' + LineEnding +
    '            ''sessionManager'',' + LineEnding +
    '            TCookieSessionManagerFactory.create(' + LineEnding +
    '                TIniSessionFactory.create(),' + LineEnding +
    '                container[''encrypter''] as IEncrypter,' + LineEnding +
    '                container[''encrypter''] as IDecrypter,' + LineEnding +
    '                (container[''config''] as IAppConfiguration).getString(''session.name'')' + LineEnding +
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
    '                    (container[''config''] as IAppConfiguration).getString(''cookie.domain'')' + LineEnding +
    '                ),' + LineEnding +
    '                (container[''config''] as IAppConfiguration).getInt(''cookie.maxAge'')' + LineEnding +
    '            )' + LineEnding +
    '        );' + LineEnding +
    '    end;' + LineEnding;

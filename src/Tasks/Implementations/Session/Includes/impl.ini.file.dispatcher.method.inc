strImplIniFileDispatcherMethod : string =
    '    function TAppServiceProvider.buildDispatcher(' + LineEnding +
    '        const container : IDependencyContainer;' + LineEnding +
    '        const routeMatcher : IRouteMatcher;' + LineEnding +
    '        const config : IAppConfiguration' + LineEnding +
    '    ) : IDispatcher;' + LineEnding +
    '    begin' + LineEnding +
    '        container.add(''appMiddlewares'', TMiddlewareListFactory.create());' + LineEnding +
    '' + LineEnding +
    '        container.add(' + LineEnding +
    '            ''sessionManager'',' + LineEnding +
    '            TIniFileSessionManagerFactory.create(' + LineEnding +
    '                config.getString(''session.name''),' + LineEnding +
    '                config.getString(''session.dir'')' + LineEnding +
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

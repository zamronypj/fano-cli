strImplJsonFileDispatcherMethod : string =
    '    procedure TAppServiceProvider.buildDispatcher(' + LineEnding +
    '        const container : IDependencyContainer;' + LineEnding +
    '        const routeMatcher : IRouteMatcher' + LineEnding +
    '    );' + LineEnding +
    '    begin' + LineEnding +
    '        container.add(''appMiddlewares'', TMiddlewareListFactory.create());' + LineEnding +
    '' + LineEnding +
    '        container.add(' + LineEnding +
    '            ''sessionManager'',' + LineEnding +
    '            TJsonFileSessionManagerFactory.create(' + LineEnding +
    '                (container[''config''] as IAppConfiguration).getString(''session.name''),' + LineEnding +
    '                (container[''config''] as IAppConfiguration).getString(''session.dir'')' + LineEnding +
    '            )' + LineEnding +
    '        );' + LineEnding +
    '' + LineEnding +
    '        container.add(' + LineEnding +
    '            GuidToString(IDispatcher),' + LineEnding +
    '            TSessionDispatcherFactory.create(' + LineEnding +
    '            container[''appMiddlewares''] as IMiddlewareLinkList,' + LineEnding +
    '            routeMatcher,' + LineEnding +
    '            TRequestResponseFactory.create(),' + LineEnding +
    '            container[''sessionManager''] as ISessionManager,' + LineEnding +
    '            (TCookieFactory.create()).domain(' + LineEnding +
    '                (container[''config''] as IAppConfiguration).getString(''cookie.domain'')),' + LineEnding +
    '                (container[''config''] as IAppConfiguration).getInt(''cookie.maxAge'')' + LineEnding +
    '            )' + LineEnding +
    '        );';
    '    end;' + LineEnding +

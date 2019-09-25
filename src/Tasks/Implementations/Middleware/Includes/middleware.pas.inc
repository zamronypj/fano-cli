strMiddlewarePasInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    'unit %sMiddleware;' + LineEnding +
    '' + LineEnding +
    'interface' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '' + LineEnding +
    '    fano;' + LineEnding +
    '' + LineEnding +
    'type' + LineEnding +
    '' + LineEnding +
    '    (*!-----------------------------------------------' + LineEnding +
    '     * explain what middleware does here ' + LineEnding +
    '     *' + LineEnding +
    '     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    T%sMiddleware = class(TInjectableObject, IMiddleware)' + LineEnding +
    '    public' + LineEnding +
    '        function handleRequest(' + LineEnding +
    '            const request : IRequest;' + LineEnding +
    '            const response : IResponse;' + LineEnding +
    '            const args : IRouteArgsReader;' + LineEnding +
    '            const next : IRequestHandler' + LineEnding +
    '        ) : IResponse;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'implementation' + LineEnding +
    '' + LineEnding +
    '    function T%sMiddleware.handleRequest(' + LineEnding +
    '        const request : IRequest;' + LineEnding +
    '        const response : IResponse;' + LineEnding +
    '        const args : IRouteArgsReader;' + LineEnding +
    '        const next : IRequestHandler' + LineEnding +
    '    ) : IResponse;' + LineEnding +
    '    begin' + LineEnding +
    '        {---put your code here, for example : ---}' + LineEnding +
    '        response.body().write(''%s middleware'');' + LineEnding +
    '        result := next.handleRequest(request, response, args);' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'end.' + LineEnding +
    '';

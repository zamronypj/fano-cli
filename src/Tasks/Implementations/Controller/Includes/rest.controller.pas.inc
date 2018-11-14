strRestControllerPasInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    'unit %sController;' + LineEnding +
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
    '     * controller that handle route :' + LineEnding +
    '     * /%s' + LineEnding +
    '     *' + LineEnding +
    '     * See Routes/%s/routes.inc' + LineEnding +
    '     *' + LineEnding +
    '     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    T%sController = class(TRouteHandler, IDependency)' + LineEnding +
    '    public' + LineEnding +
    '        function handleRequest(' + LineEnding +
    '            const request : IRequest;' + LineEnding +
    '            const response : IResponse' + LineEnding +
    '        ) : IResponse; override;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'implementation' + LineEnding +
    '' + LineEnding +
    '    function T%sController.handleRequest(' + LineEnding +
    '          const request : IRequest;' + LineEnding +
    '          const response : IResponse' + LineEnding +
    '    ) : IResponse;' + LineEnding +
    '    var strName : string;' + LineEnding +
    '    begin' + LineEnding +
    '        {---put your code here---}' + LineEnding +
    '        result := response;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'end.' + LineEnding +
    '';

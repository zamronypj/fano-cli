strViewPasInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    'unit %sView;' + LineEnding +
    '' + LineEnding +
    'interface' + LineEnding +
    '' + LineEnding +
    '{$MODE OBJFPC}' + LineEnding +
    '{$H+}' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '' + LineEnding +
    '    fano;' + LineEnding +
    '' + LineEnding +
    'type' + LineEnding +
    '' + LineEnding +
    '    (*!-----------------------------------------------' + LineEnding +
    '     * View instance ' + LineEnding +
    '     *' + LineEnding +
    '     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    T%sView = class(TInjectableObject, IView)' + LineEnding +
    '    public' + LineEnding +
    '' + LineEnding +
    '        (*!------------------------------------------------' + LineEnding +
    '         * render view' + LineEnding +
    '         *------------------------------------------------' + LineEnding +
    '         * @param viewParams view parameters' + LineEnding +
    '         * @param response response instance' + LineEnding +
    '         * @return response' + LineEnding +
    '         *-----------------------------------------------*)' + LineEnding +
    '        function render(' + LineEnding +
    '            const viewParams : IViewParameters;' + LineEnding +
    '            const response : IResponse' + LineEnding +
    '        ) : IResponse;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'implementation' + LineEnding +
    '' + LineEnding +
    '    (*!------------------------------------------------' + LineEnding +
    '     * render view' + LineEnding +
    '     *------------------------------------------------' + LineEnding +
    '     * @param viewParams view parameters' + LineEnding +
    '     * @param response response instance' + LineEnding +
    '     * @return response' + LineEnding +
    '     *-----------------------------------------------*)' + LineEnding +
    '    function T%sView.render(' + LineEnding +
    '        const viewParams : IViewParameters;' + LineEnding +
    '        const response : IResponse' + LineEnding +
    '    ) : IResponse;' + LineEnding +
    '    begin' + LineEnding +
    '        {---put your code here---}' + LineEnding +
    '        result := response;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'end.';

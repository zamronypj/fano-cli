myStr : string = 
    '(*!------------------------------------------------------------' + LineEnding + 
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding + 
    ' *' + LineEnding + 
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding + 
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding + 
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding + 
    ' *------------------------------------------------------------- *)' + LineEnding + 
    'unit CoreView;' + LineEnding + 
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
    '     * View instance' + LineEnding + 
    '     *' + LineEnding + 
    '     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>' + LineEnding + 
    '     *------------------------------------------------*)' + LineEnding + 
    '    TCoreView = class abstract (TView)' + LineEnding + 
    '    protected' + LineEnding + 
    '        fViewPartial : IViewPartial;' + LineEnding + 
    '' + LineEnding + 
    '        function getTemplatePath() : string; virtual; abstract;' + LineEnding + 
    '    public' + LineEnding + 
    '        constructor create(' + LineEnding + 
    '            const tplParser : ITemplateParser;' + LineEnding + 
    '            const aViewPartial : IViewPartial' + LineEnding + 
    '        );' + LineEnding + 
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
    '        ) : IResponse; override;' + LineEnding + 
    '    end;' + LineEnding + 
    '' + LineEnding + 
    'implementation' + LineEnding + 
    '' + LineEnding + 
    '    constructor TCoreView.create(' + LineEnding + 
    '        const tplParser : ITemplateParser;' + LineEnding + 
    '        const aViewPartial : IViewPartial' + LineEnding + 
    '    );' + LineEnding + 
    '    begin' + LineEnding + 
    '        inherited create(tplParser, readFile(''resources/Templates/base.html''));' + LineEnding + 
    '        fViewPartial := aViewPartial;' + LineEnding + 
    '    end;' + LineEnding + 
    '' + LineEnding + 
    '    (*!------------------------------------------------' + LineEnding + 
    '     * render view' + LineEnding + 
    '     *------------------------------------------------' + LineEnding + 
    '     * @param viewParams view parameters' + LineEnding + 
    '     * @param response response instance' + LineEnding + 
    '     * @return response' + LineEnding + 
    '     *-----------------------------------------------*)' + LineEnding + 
    '    function TCoreView.render(' + LineEnding + 
    '        const viewParams : IViewParameters;' + LineEnding + 
    '        const response : IResponse' + LineEnding + 
    '    ) : IResponse;' + LineEnding + 
    '    begin' + LineEnding + 
    '        viewParams[''content''] := fViewPartial.partial(getTemplatePath(), viewParams);' + LineEnding + 
    '        result := inherited render(viewParams, response);' + LineEnding + 
    '    end;' + LineEnding + 
    '' + LineEnding + 
    'end.';

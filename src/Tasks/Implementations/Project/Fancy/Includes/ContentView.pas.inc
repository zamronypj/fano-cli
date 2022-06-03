myStr : string = 
    '(*!------------------------------------------------------------' + LineEnding + 
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding + 
    ' *' + LineEnding + 
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding + 
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding + 
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding + 
    ' *------------------------------------------------------------- *)' + LineEnding + 
    'unit ContentView;' + LineEnding + 
    '' + LineEnding + 
    'interface' + LineEnding + 
    '' + LineEnding + 
    '{$MODE OBJFPC}' + LineEnding + 
    '{$H+}' + LineEnding + 
    '' + LineEnding + 
    'uses' + LineEnding + 
    '' + LineEnding + 
    '    fano,' + LineEnding + 
    '    CoreView;' + LineEnding + 
    '' + LineEnding + 
    'type' + LineEnding + 
    '' + LineEnding + 
    '    (*!-----------------------------------------------' + LineEnding + 
    '     * View instance' + LineEnding + 
    '     *' + LineEnding + 
    '     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>' + LineEnding + 
    '     *------------------------------------------------*)' + LineEnding + 
    '    TContentView = class(TCoreView)' + LineEnding + 
    '    protected' + LineEnding + 
    '        function getTemplatePath() : string; override;' + LineEnding + 
    '    end;' + LineEnding + 
    '' + LineEnding + 
    'implementation' + LineEnding + 
    '' + LineEnding + 
    '    function TContentView.getTemplatePath() : string;' + LineEnding + 
    '    begin' + LineEnding + 
    '        result := ''resources/Templates/content.html'';' + LineEnding + 
    '    end;' + LineEnding + 
    '' + LineEnding + 
    '' + LineEnding + 
    'end.';

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strViewFactoryPasInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    'unit %sViewFactory;' + LineEnding +
    '' + LineEnding +
    'interface' + LineEnding +
    '' + LineEnding +
    '{$MODE OBJFPC}' + LineEnding +
    '{$H+}' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '    fano;' + LineEnding +
    '' + LineEnding +
    'type' + LineEnding +
    '' + LineEnding +
    '    (*!-----------------------------------------------' + LineEnding +
    '     * Factory for view T%sView' + LineEnding +
    '     *' + LineEnding +
    '     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    T%sViewFactory = class(TFactory)' + LineEnding +
    '    public' + LineEnding +
    '        function build(const container : IDependencyContainer) : IDependency; override;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'implementation' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '' + LineEnding +
    '    SysUtils,' + LineEnding +
    '' + LineEnding +
    '    {*! -------------------------------' + LineEnding +
    '        unit interfaces' + LineEnding +
    '    ----------------------------------- *}' + LineEnding +
    '    %sView;' + LineEnding +
    '' + LineEnding +
    '    function T%sViewFactory.build(const container : IDependencyContainer) : IDependency;' + LineEnding +
    '    begin' + LineEnding +
    '        result := T%sView.create();' + LineEnding +
    '    end;' + LineEnding +
    'end.';

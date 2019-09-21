strRestControllerFactoryPasInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    'unit %sControllerFactory;' + LineEnding +
    '' + LineEnding +
    'interface' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '    fano;' + LineEnding +
    '' + LineEnding +
    'type' + LineEnding +
    '' + LineEnding +
    '    (*!-----------------------------------------------' + LineEnding +
    '     * Factory for controller T%sController' + LineEnding +
    '     *' + LineEnding +
    '     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    T%sControllerFactory = class(TFactory, IDependencyFactory)' + LineEnding +
    '    public' + LineEnding +
    '        function build(const container : IDependencyContainer) : IDependency; override;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'implementation' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '    sysutils,' + LineEnding +
    '' + LineEnding +
    '    {*! -------------------------------' + LineEnding +
    '        unit interfaces' + LineEnding +
    '    ----------------------------------- *}' + LineEnding +
    '    %sController;' + LineEnding +
    '' + LineEnding +
    '    function T%sControllerFactory.build(const container : IDependencyContainer) : IDependency;' + LineEnding +
    '    begin' + LineEnding +
    '        //build your controller instance here.' + LineEnding +
    '        //container will gives you access to all registered services' + LineEnding +
    '        result := T%sController.create();' + LineEnding +
    '    end;' + LineEnding +
    'end.' + LineEnding +
    '';

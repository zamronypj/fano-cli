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
    '     * %s' + LineEnding +
    '     *' + LineEnding +
    '     * See Routes/%s/routes.inc' + LineEnding +
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
    '    var routeMiddlewares : IMiddlewareCollectionAware;' + LineEnding +
    '    begin' + LineEnding +
    '        routeMiddlewares := container.get(''routeMiddlewares'') as IMiddlewareCollectionAware;' + LineEnding +
    '        try' + LineEnding +
    '            result := T%sController.create(' + LineEnding +
    '                routeMiddlewares.getBefore(),' + LineEnding +
    '                routeMiddlewares.getAfter()' + LineEnding +
    '            );' + LineEnding +
    '        finally' + LineEnding +
    '            routeMiddlewares := nil;' + LineEnding +
    '        end;' + LineEnding +
    '    end;' + LineEnding +
    'end.' + LineEnding +
    '';

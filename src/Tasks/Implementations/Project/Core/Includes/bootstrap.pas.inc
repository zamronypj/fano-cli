strBootstrapPas: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    'unit bootstrap;' + LineEnding +
    '' + LineEnding +
    'interface' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '' + LineEnding +
    '    fano;' + LineEnding +
    '' + LineEnding +
    'type' + LineEnding +
    '' + LineEnding +
    '    TAppServiceProvider = class(TBasicAppServiceProvider)' + LineEnding +
    '    public' + LineEnding +
    '        procedure register(const container : IDependencyContainer); override;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    TAppRoutes = class(TRouteBuilder)' + LineEnding +
    '    public' + LineEnding +
    '        procedure buildRoutes(' + LineEnding +
    '            const container : IDependencyContainer;' + LineEnding +
    '            const router : IRouter' + LineEnding +
    '        ); override;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'implementation' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '    sysutils' + LineEnding +
    '' + LineEnding +
    '    (*! -------------------------------' + LineEnding +
    '     *   controllers factory' + LineEnding +
    '     *----------------------------------- *)' + LineEnding +
    '    {---- put your controller factory here ---};' + LineEnding +
    '' + LineEnding +
    '' + LineEnding +
    '    procedure TAppServiceProvider.register(const container : IDependencyContainer);' + LineEnding +
    '    begin' + LineEnding +
    '        {$INCLUDE Dependencies/dependencies.inc}' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    procedure TAppRoutes.buildRoutes(' + LineEnding +
    '        const container : IDependencyContainer;' + LineEnding +
    '        const router : IRouter' + LineEnding +
    '    );' + LineEnding +
    '    begin' + LineEnding +
    '        {$INCLUDE Routes/routes.inc}' + LineEnding +
    '    end;' + LineEnding +
    'end.';

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
    '    TBootstrapApp = class(TSimpleFastCGIWebApplication)' + LineEnding +
    '    protected' + LineEnding +
    '        procedure buildDependencies(const container : IDependencyContainer); override;' + LineEnding +
    '        procedure buildRoutes(const container : IDependencyContainer); override;' + LineEnding +
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
    '    procedure TBootstrapApp.buildDependencies(const container : IDependencyContainer);' + LineEnding +
    '    begin' + LineEnding +
    '        {$INCLUDE Dependencies/dependencies.inc}' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    procedure TBootstrapApp.buildRoutes(const container : IDependencyContainer);' + LineEnding +
    '    var router : IRouter;' + LineEnding +
    '    begin' + LineEnding +
    '        router := container.get(''router'') as IRouter;' + LineEnding +
    '        try' + LineEnding +
    '            {$INCLUDE Routes/routes.inc}' + LineEnding +
    '        finally' + LineEnding +
    '            router := nil;' + LineEnding +
    '        end;' + LineEnding +
    '    end;' + LineEnding +
    'end.';

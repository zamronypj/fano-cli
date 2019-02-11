strMainDependenciesInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    '' + LineEnding +
    ' {-----------------------------------------------' + LineEnding +
    '   register middleware list for each routes that' + LineEnding +
    '   does nothing,' + LineEnding +
    '   need to be use factory so each route will have' + LineEnding +
    '   different middleware list' + LineEnding +
    '   Replace with TMiddlewareCollectionAwareFactory to support middleware' + LineEnding +
    '   or replace with your own implementation if required' + LineEnding +
    ' ------------------------------------------------}' + LineEnding +
    ' container.factory(''routeMiddlewares'', TNullMiddlewareCollectionAwareFactory.create());' + LineEnding +
    '' + LineEnding +
    ' {-----------------------------------------------' + LineEnding +
    '   register application simple router instance' + LineEnding +
    '   Replace with your own implementation if required' + LineEnding +
    ' ------------------------------------------------}' + LineEnding +
    ' container.add(''router'', TSimpleRouterFactory.create());' + LineEnding +
    '' + LineEnding +
    ' {-----------------------------------------------' + LineEnding +
    '   setup application request dispatcher' + LineEnding +
    '   replace with TDispatcherFactory if middleware support is requred' + LineEnding +
    ' ------------------------------------------------}' + LineEnding +
    ' container.add(' + LineEnding +
    '     ''dispatcher'',' + LineEnding +
    '     TSimpleDispatcherFactory.create(' + LineEnding +
    '         container.get(''router'') as IRouteMatcher' + LineEnding +
    '     )' + LineEnding +
    ' );' + LineEnding +
    '';

strModelFactoryPasInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    'unit %sModelFactory;' + LineEnding +
    '' + LineEnding +
    'interface' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '    fano;' + LineEnding +
    '' + LineEnding +
    'type' + LineEnding +
    '' + LineEnding +
    '    (*!-----------------------------------------------' + LineEnding +
    '     * Factory for model T%sModel' + LineEnding +
    '     *' + LineEnding +
    '     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    T%sModelFactory = class(TFactory)' + LineEnding +
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
    '    %sModel;' + LineEnding +
    '' + LineEnding +
    '    function T%sModelFactory.build(const container : IDependencyContainer) : IDependency;' + LineEnding +
    '    var db : IRdbms;'+ LineEnding +
    '    begin' + LineEnding +
    '        {---initialize database here---}' + LineEnding +
    '        { db := container.get(''db'') as IRdbms;}'+ LineEnding +
    '        result := T%sModel.create(db);' + LineEnding +
    '    end;' + LineEnding +
    'end.';

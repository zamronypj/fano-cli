(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strModelPasInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    'unit %sModel;' + LineEnding +
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
    '     * model instance' + LineEnding +
    '     *' + LineEnding +
    '     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>' + LineEnding +
    '     *------------------------------------------------*)' + LineEnding +
    '    T%sModel = class(TInjectableObject, IModelReader, IModelResultSet)' + LineEnding +
    '    private' + LineEnding +
    '        rdbmsInstance : IRdbms;' + LineEnding +
    '        resultSet : IRdbmsResultSet;' + LineEnding +
    '    public' + LineEnding +
    '        constructor create(const db : IRdbms);' + LineEnding +
    '        destructor destroy(); override;' + LineEnding +
    '' + LineEnding +
    '        function read(const params : IModelParams = nil) : IModelResultSet;' + LineEnding +
    '        function data() : IModelResultSet;' + LineEnding +
    '' + LineEnding +
    '        (*!------------------------------------------------' + LineEnding +
    '         * get total data' + LineEnding +
    '         *-----------------------------------------------' + LineEnding +
    '         * @return total data' + LineEnding +
    '         *-----------------------------------------------*)' + LineEnding +
    '        function count() : int64;' + LineEnding +
    '' + LineEnding +
    '        (*!------------------------------------------------' + LineEnding +
    '         * test if in end of result set' + LineEnding +
    '         *-----------------------------------------------' + LineEnding +
    '         * @return true if no more record' + LineEnding +
    '         *-----------------------------------------------*)' + LineEnding +
    '        function eof() : boolean;' + LineEnding +
    '' + LineEnding +
    '        (*!------------------------------------------------' + LineEnding +
    '         * move data pointer to next record' + LineEnding +
    '         *-----------------------------------------------' + LineEnding +
    '         * @return true if successful, false if no more record' + LineEnding +
    '         *-----------------------------------------------*)' + LineEnding +
    '        function next() : boolean;' + LineEnding +
    '' + LineEnding +
    '        (*!------------------------------------------------' + LineEnding +
    '         * read data from current active record by its name' + LineEnding +
    '         *-----------------------------------------------' + LineEnding +
    '         * @return value in record' + LineEnding +
    '         *-----------------------------------------------*)' + LineEnding +
    '        function readString(const key : string) : string;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    'implementation' + LineEnding +
    '' + LineEnding +
    'uses' + LineEnding +
    '' + LineEnding +
    '    Classes,' + LineEnding +
    '    SysUtils;' + LineEnding +
    '' + LineEnding +
    '    constructor T%sModel.create(const db : IRdbms);' + LineEnding +
    '    begin' + LineEnding +
    '        rdbmsInstance := db;' + LineEnding +
    '        resultSet := nil;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    destructor T%sModel.destroy();' + LineEnding +
    '    begin' + LineEnding +
    '        inherited destroy();' + LineEnding +
    '        rdbmsInstance := nil;' + LineEnding +
    '        resultSet := nil;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    function T%sModel.read(' + LineEnding +
    '        const params : IModelParams = nil' + LineEnding +
    '    ) : IModelResultSet;' + LineEnding +
    '    begin' + LineEnding +
    '        {---put code to retrieve data from storage here---}' + LineEnding +
    '        //resultSet := rdbmsInstance.prepare(''SELECT * FROM %ss'').execute();' + LineEnding +
    '        result := self;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    function T%sModel.data() : IModelResultSet;' + LineEnding +
    '    begin' + LineEnding +
    '        result := self;' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    (*!------------------------------------------------' + LineEnding +
    '     * get total data' + LineEnding +
    '     *-----------------------------------------------' + LineEnding +
    '     * @return total data' + LineEnding +
    '     *-----------------------------------------------*)' + LineEnding +
    '    function T%sModel.count() : int64;' + LineEnding +
    '    begin' + LineEnding +
    '        result := resultSet.resultCount();' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    (*!------------------------------------------------' + LineEnding +
    '     * test if in end of result set' + LineEnding +
    '     *-----------------------------------------------' + LineEnding +
    '     * @return true if no more record' + LineEnding +
    '     *-----------------------------------------------*)' + LineEnding +
    '    function T%sModel.eof() : boolean;' + LineEnding +
    '    begin' + LineEnding +
    '        result := resultSet.eof();' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    (*!------------------------------------------------' + LineEnding +
    '     * move data pointer to next record' + LineEnding +
    '     *-----------------------------------------------' + LineEnding +
    '     * @return true if successful, false if no more record' + LineEnding +
    '     *-----------------------------------------------*)' + LineEnding +
    '    function T%sModel.next() : boolean;' + LineEnding +
    '    begin' + LineEnding +
    '        result := not resultSet.eof();' + LineEnding +
    '        resultSet.next();' + LineEnding +
    '    end;' + LineEnding +
    '' + LineEnding +
    '    (*!------------------------------------------------' + LineEnding +
    '     * read data from current active record by its name' + LineEnding +
    '     *-----------------------------------------------' + LineEnding +
    '     * @return value in record' + LineEnding +
    '     *-----------------------------------------------*)' + LineEnding +
    '    function T%sModel.readString(const key : string) : string;' + LineEnding +
    '    begin' + LineEnding +
    '        result := resultSet.fields().fieldByName(key).asString;' + LineEnding +
    '    end;' + LineEnding +
    'end.';

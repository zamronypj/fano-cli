(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMultiRouteTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    FileContentReaderIntf,
    FileContentWriterIntf,
    DirectoryCreatorIntf;

type

    (*!--------------------------------------
     * Task that add controller to multiple routes
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMultiRouteTask = class(TInterfacedObject, ITask)
    private
        fileReader : IFileContentReader;
        fileWriter : IFileContentWriter;
        directoryCreator : IDirectoryCreator;
    public
        constructor create(
            fReader : IFileContentReader;
            fWriter : IFileContentWriter;
            dirCreator : IDirectoryCreator
        );

        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils,
    Classes,
    strformats;

const

    BASE_ROUTE_DIR = 'src' + DirectorySeparator + 'Routes' + DirectorySeparator;

    constructor TCreateMultiRouteTask.create(
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
        dirCreator : IDirectoryCreator
    );
    begin
        fileReader := fReader;
        fileWriter := fWriter;
        directoryCreator := dirCreator;
    end;

    destructor TCreateMultiRouteTask.destroy();
    begin
        fileReader := nil;
        fileWriter := nil;
        directoryCreator := nil;
        inherited destroy();
    end;

    function TCreateMultiRouteTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var controllerName, lowerCtrlName : string;
        routeContent : string;
        routePattern : string;
        routeMethod : string;
        routeMethods : TStringArray;
        i, lenMethod : integer;
        {$INCLUDE src/Tasks/Implementations/Controller/Includes/routes.inc.inc}
    begin
        controllerName := opt.getOptionValue(longOpt);

        //create main entry to main routes file
        routeContent := fileReader.read(BASE_ROUTE_DIR + 'routes.inc');
        routeContent := routeContent +
            '{$INCLUDE ' + controllerName + '/routes.inc}' + LineEnding;
        fileWriter.write(BASE_ROUTE_DIR + 'routes.inc', routeContent);

        lowerCtrlName := lowerCase(controllerName);
        routePattern := opt.getOptionValueDef('route', '/' + lowerCtrlName);
        if (routePattern[1] <> '/') then
        begin
            routePattern := '/' + routePattern;
        end;

        routeMethods := lowerCase(opt.getOptionValueDef('method', 'get')).split(',');
        lenMethod := length(routeMethods);
        routeMethod := '';
        if lenMethod > 0 then
        begin
            for i:= 0 to lenMethod - 2 do
            begin
                routeMethod := routeMethod + '''' + upperCase(routeMethods[i]) + ''',';
            end;
            routeMethod := routeMethod + '''' + upperCase(routeMethods[lenMethod-1]) + '''';
        end;

        //create controller route file
        directoryCreator.createDirIfNotExists(BASE_ROUTE_DIR + controllerName);
        strCtrlRoutesInc := strCtrlRoutesInc + LineEnding +
            format(
              'router.map([%s], ''%s'', container.get(''%sController'') as IRequestHandler);',
              [routeMethod, routePattern, lowerCtrlName]
            ) + LineEnding;
        fileWriter.write(BASE_ROUTE_DIR + controllerName + '/routes.inc', strCtrlRoutesInc);

        writeln(
            'Create route ',
            formatColor(routePattern, TXT_GREEN),
            ' (', formatColor(uppercase(routeMethod), TXT_YELLOW), ')'
        );
        result := self;
    end;
end.

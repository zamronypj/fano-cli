(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDependencyRegistrationTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    FileContentReaderIntf,
    FileContentWriterIntf;

type

    (*!--------------------------------------
     * Task that add controller unit to uses
     * clause of bootstrap application unit
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateDependencyRegistrationTask = class(TInterfacedObject, ITask)
    private
        fileReader : IFileContentReader;
        fileWriter : IFileContentWriter;
    public
        constructor create(
            fReader : IFileContentReader;
            fWriter : IFileContentWriter
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
    Classes;

const

    DEP_FILE = 'src' + DirectorySeparator + 'Dependencies' +
        DirectorySeparator + 'controllers.dependencies.inc';

    constructor TCreateDependencyRegistrationTask.create(
        fReader : IFileContentReader;
        fWriter : IFileContentWriter
    );
    begin
        fileReader := fReader;
        fileWriter := fWriter;
    end;

    destructor TCreateDependencyRegistrationTask.destroy();
    begin
        inherited destroy();
        fileReader := nil;
        fileWriter := nil;
    end;

    function TCreateDependencyRegistrationTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var controllerName : string;
        depContent : string;
    begin
        controllerName := opt.getOptionValue(longOpt);
        //create main entry to controller dependencies file
        depContent := fileReader.read(DEP_FILE);
        depContent := depContent + LineEnding +
            format(
                'container.add(''%sController'', T%sControllerFactory.create());',
                [lowerCase(controllerName), controllerName]
            );
        fileWriter.write(DEP_FILE, depContent);

        result := self;
    end;
end.

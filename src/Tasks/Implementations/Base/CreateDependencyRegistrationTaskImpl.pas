(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
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
        objectType : string;
    public
        constructor create(
            const fReader : IFileContentReader;
            const fWriter : IFileContentWriter;
            const objType : string
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

    DEP_DIR = 'src' + DirectorySeparator + 'Dependencies' + DirectorySeparator;

    constructor TCreateDependencyRegistrationTask.create(
        const fReader : IFileContentReader;
        const fWriter : IFileContentWriter;
        const objType : string
    );
    begin
        fileReader := fReader;
        fileWriter := fWriter;
        objectType := objType;
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
    var objectName : string;
        depContent : string;
    begin
        objectName := opt.getOptionValue(longOpt);
        //create main entry to dependencies file
        depContent := fileReader.read(DEP_DIR + lowerCase(objectType) + 's.dependencies.inc');
        depContent := depContent + LineEnding +
            format(
                'container.add(''%s%s'', T%s%sFactory.create());',
                [lowerCase(objectName), objectType, objectName, objectType]
            );
        fileWriter.write(
            DEP_DIR + lowerCase(objectType) + 's.dependencies.inc',
            depContent
        );

        result := self;
    end;
end.

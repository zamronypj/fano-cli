(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateControllerTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create controller task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateControllerTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    TextFileCreatorIntf,
    TextFileCreatorImpl,
    DirectoryCreatorIntf,
    DirectoryCreatorImpl,
    FileContentReaderIntf,
    FileContentWriterIntf,
    FileHelperImpl,

    CreateControllerFileTaskImpl,
    CreateControllerFactoryFileTaskImpl,
    AddCtrlToUsesClauseTaskImpl,
    AddCtrlToUnitSearchTaskImpl,
    CreateDependencyRegistrationTaskImpl,
    CreateRouteTaskImpl,
    CreateDependencyTaskImpl,
    CreateControllerTaskImpl;

    function TCreateControllerTaskFactory.build() : ITask;
    var textFileCreator : ITextFileCreator;
        directoryCreator : IDirectoryCreator;
        fileReader : IFileContentReader;
        fileWriter : IFileContentWriter;
    begin
        textFileCreator := TTextFileCreator.create();
        directoryCreator := TDirectoryCreator.create();
        fileReader := TFileHelper.create();
        fileWriter := fileReader as IFileContentWriter;
        result := TCreateControllerTask.create(
            TCreateControllerFileTask.create(textFileCreator, directoryCreator),
            TCreateControllerFactoryFileTask.create(textFileCreator, directoryCreator),
            TCreateDependencyTask.create(
                TAddCtrlToUsesClauseTask.create(fileReader, fileWriter),
                TAddCtrlToUnitSearchTask.create(fileReader, fileWriter),
                TCreateDependencyRegistrationTask.create(fileReader, fileWriter)
            ),
            TCreateRouteTask.create(fileReader, fileWriter, directoryCreator)
        );
    end;

end.

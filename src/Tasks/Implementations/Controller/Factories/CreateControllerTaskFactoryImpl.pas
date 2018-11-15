(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
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

    RunCheckTaskImpl,
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
        task : ITask;
    begin
        textFileCreator := TTextFileCreator.create();
        directoryCreator := TDirectoryCreator.create();
        fileReader := TFileHelper.create();
        fileWriter := fileReader as IFileContentWriter;
        task := TCreateControllerTask.create(
            TCreateControllerFileTask.create(textFileCreator, directoryCreator),
            TCreateControllerFactoryFileTask.create(textFileCreator, directoryCreator),
            TCreateDependencyTask.create(
                TAddCtrlToUsesClauseTask.create(fileReader, fileWriter),
                TAddCtrlToUnitSearchTask.create(fileReader, fileWriter),
                TCreateDependencyRegistrationTask.create(fileReader, fileWriter)
            ),
            TCreateRouteTask.create(fileReader, fileWriter, directoryCreator)
        );
        //protect to avoid accidentally creating controller in non Fano-CLI
        //project directory structure
        result := TRunCheckTask.create(task);
    end;

end.

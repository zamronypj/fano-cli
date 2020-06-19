(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
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
    ContentModifierIntf,
    FileHelperImpl,
    CopyrightContentModifierImpl,

    InFanoProjectDirCheckTaskImpl,
    CreateControllerFileTaskImpl,
    CreateControllerFactoryFileTaskImpl,
    AddToUsesClauseTaskImpl,
    AddToUnitSearchTaskImpl,
    CreateDependencyRegistrationTaskImpl,
    CreateRouteTaskImpl,
    WithNoRouteTaskImpl,
    CreateDependencyTaskImpl,
    CreateControllerTaskImpl,
    DuplicateCtrlCheckTaskImpl;

    function TCreateControllerTaskFactory.build() : ITask;
    var textFileCreator : ITextFileCreator;
        directoryCreator : IDirectoryCreator;
        fileReader : IFileContentReader;
        fileWriter : IFileContentWriter;
        contentModifier : IContentModifier;
        task : ITask;
    begin
        textFileCreator := TTextFileCreator.create();
        directoryCreator := TDirectoryCreator.create();
        contentModifier := TCopyrightContentModifier.create();
        fileReader := TFileHelper.create();
        fileWriter := fileReader as IFileContentWriter;
        task := TCreateControllerTask.create(
            TCreateControllerFileTask.create(textFileCreator, directoryCreator, contentModifier),
            TCreateControllerFactoryFileTask.create(textFileCreator, directoryCreator, contentModifier),
            TCreateDependencyTask.create(
                TAddToUsesClauseTask.create(fileReader, fileWriter, 'Controller'),
                TAddToUnitSearchTask.create(fileReader, fileWriter, 'Controller'),
                TCreateDependencyRegistrationTask.create(fileReader, fileWriter, 'Controller')
            ),
            //wrap to handle --no-route argument
            TWithNoRouteTask.create(
                TCreateRouteTask.create(fileReader, fileWriter, directoryCreator)
            )
        );
        //protect to avoid accidentally creating controller in non Fano-CLI
        //project directory structure and also prevent accidentally create
        //controller with same name as existing controller.
        result := TInFanoProjectDirCheckTask.create(TDuplicateCtrlCheckTask.create(task));
    end;

end.

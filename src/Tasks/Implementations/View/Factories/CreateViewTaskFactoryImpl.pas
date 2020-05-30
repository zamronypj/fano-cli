(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateViewTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create view task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateViewTaskFactory = class(TInterfacedObject, ITaskFactory)
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

    RunCheckTaskImpl,
    CreateViewFileTaskImpl,
    CreateViewFactoryFileTaskImpl,
    AddToUsesClauseTaskImpl,
    AddToUnitSearchTaskImpl,
    CreateDependencyRegistrationTaskImpl,
    CreateDependencyTaskImpl,
    CreateViewTaskImpl,
    DuplicateViewCheckTaskImpl;

    function TCreateViewTaskFactory.build() : ITask;
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
        task := TCreateViewTask.create(
            TCreateViewFileTask.create(textFileCreator, directoryCreator, contentModifier),
            TCreateViewFactoryFileTask.create(textFileCreator, directoryCreator, contentModifier),
            TCreateDependencyTask.create(
                TAddToUsesClauseTask.create(fileReader, fileWriter, 'View'),
                TAddToUnitSearchTask.create(fileReader, fileWriter, 'View'),
                TCreateDependencyRegistrationTask.create(fileReader, fileWriter, 'View')
            )
        );
        //protect to avoid accidentally creating view in non Fano-CLI
        //project directory structure and also prevent accidentally create
        //view with same name as existing view
        result := TRunCheckTask.create(TDuplicateViewCheckTask.create(task));
    end;

end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateModelTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create model task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateModelTaskFactory = class(TInterfacedObject, ITaskFactory)
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
    CreateModelFileTaskImpl,
    CreateModelFactoryFileTaskImpl,
    AddToUsesClauseTaskImpl,
    AddToUnitSearchTaskImpl,
    CreateDependencyRegistrationTaskImpl,
    CreateDependencyTaskImpl,
    CreateModelTaskImpl,
    DuplicateModelCheckTaskImpl;

    function TCreateModelTaskFactory.build() : ITask;
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
        task := TCreateModelTask.create(
            TCreateModelFileTask.create(textFileCreator, directoryCreator, contentModifier),
            TCreateModelFactoryFileTask.create(textFileCreator, directoryCreator, contentModifier),
            TCreateDependencyTask.create(
                TAddToUsesClauseTask.create(fileReader, fileWriter, 'Model'),
                TAddToUnitSearchTask.create(fileReader, fileWriter, 'Model'),
                TCreateDependencyRegistrationTask.create(fileReader, fileWriter, 'Model')
            )
        );
        //protect to avoid accidentally creating model in non Fano-CLI
        //project directory structure and also prevent accidentatlly create
        //model with same name as existing model
        result := TInFanoProjectDirCheckTask.create(TDuplicateModelCheckTask.create(task));
    end;

end.

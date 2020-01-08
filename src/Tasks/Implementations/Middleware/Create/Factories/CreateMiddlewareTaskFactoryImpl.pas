(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMiddlewareTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create middleware task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMiddlewareTaskFactory = class(TInterfacedObject, ITaskFactory)
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
    CreateMiddlewareFileTaskImpl,
    CreateMiddlewareFactoryFileTaskImpl,
    AddToUsesClauseTaskImpl,
    MiddlewareAddToUnitSearchTaskImpl,
    CreateDependencyRegistrationTaskImpl,
    CreateRouteTaskImpl,
    CreateDependencyTaskImpl,
    CreateMiddlewareTaskImpl,
    DuplicateMiddlewareCheckTaskImpl;

    function TCreateMiddlewareTaskFactory.build() : ITask;
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
        task := TCreateMiddlewareTask.create(
            TCreateMiddlewareFileTask.create(textFileCreator, directoryCreator, contentModifier),
            TCreateMiddlewareFactoryFileTask.create(textFileCreator, directoryCreator, contentModifier),
            TCreateDependencyTask.create(
                TAddToUsesClauseTask.create(fileReader, fileWriter, 'Middleware'),
                TMiddlewareAddToUnitSearchTask.create(fileReader, fileWriter, 'Middleware'),
                TCreateDependencyRegistrationTask.create(fileReader, fileWriter, 'Middleware')
            )
        );
        //protect to avoid accidentally creating middleware in non Fano-CLI
        //project directory structure and also prevent accidentally create
        //middleware with same name as existing middleware
        result := TRunCheckTask.create(TDuplicateMiddlewareCheckTask.create(task));
    end;

end.

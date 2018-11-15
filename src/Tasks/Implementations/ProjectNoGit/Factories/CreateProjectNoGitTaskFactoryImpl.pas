(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateProjectNoGitTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create project task but
     * without initialize git repository
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectNoGitTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    TextFileCreatorIntf,
    TextFileCreatorImpl,
    DirectoryCreatorImpl,
    NullTaskImpl,
    CreateDirTaskImpl,
    CreateAppConfigsTaskImpl,
    CreateAdditionalFilesTaskImpl,
    CreateShellScriptsTaskImpl,
    CreateAppBootstrapTaskImpl,
    CreateProjectTaskImpl,
    InvRunCheckTaskImpl;

    function TCreateProjectNoGitTaskFactory.build() : ITask;
    var textFileCreator : ITextFileCreator;
        createPrjTask : ITask;
    begin
        textFileCreator := TTextFileCreator.create();
        createPrjTask := TCreateProjectTask.create(
            TCreateDirTask.create(TDirectoryCreator.create()),
            TCreateShellScriptsTask.create(textFileCreator),
            TCreateAppConfigsTask.create(textFileCreator),
            TCreateAdditionalFilesTask.create(textFileCreator),
            TCreateAppBootstrapTask.create(textFileCreator),
            //replace git task with NullTaskImpl to disable git repo creation
            TNullTask.create()
        );

        //protect to avoid accidentally creating another project inside Fano-CLI
        //project directory structure
        result := TInvRunCheckTask.create(createPrjTask);
    end;

end.

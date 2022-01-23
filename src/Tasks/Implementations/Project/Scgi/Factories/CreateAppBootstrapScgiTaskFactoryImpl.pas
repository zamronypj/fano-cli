(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateAppBootstrapScgiTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    CreateAppBootstrapTaskFactoryImpl;

type

    (*!--------------------------------------
     * factory class for SCGI application bootstrap task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAppBootstrapScgiTaskFactory = class(TCreateAppBootstrapTaskFactory)
    protected
        function buildBootstrapTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; override;
    end;

implementation

uses

    GroupTaskImpl,

    CreateScgiAppFileTaskImpl,
    CreateScgiReadmeFileTaskImpl,
    CreateScgiDockerfileTaskImpl,
    CreateDaemonBootstrapFileTaskImpl,
    CreateDepFileTaskImpl,
    CreateRouteFileTaskImpl;


    function TCreateAppBootstrapScgiTaskFactory.buildBootstrapTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TGroupTask.create([
            TCreateScgiAppFileTask.create(textFileCreator, contentModifier),
            TCreateScgiReadmeFileTask.create(textFileCreator, contentModifier),
            TCreateScgiDockerfileTask.create(textFileCreator, contentModifier),
            TCreateDaemonBootstrapFileTask.create(textFileCreator, contentModifier),
            TCreateDepFileTask.create(textFileCreator, contentModifier),
            TCreateRouteFileTask.create(textFileCreator, contentModifier)
        ]);
    end;

end.

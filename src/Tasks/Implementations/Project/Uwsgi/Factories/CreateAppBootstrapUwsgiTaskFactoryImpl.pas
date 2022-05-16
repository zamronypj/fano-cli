(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateAppBootstrapUwsgiTaskFactoryImpl;

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
    TCreateAppBootstrapUwsgiTaskFactory = class(TCreateAppBootstrapTaskFactory)
    protected
        function buildBootstrapTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; override;
    end;

implementation

uses

    GroupTaskImpl,

    CreateUwsgiAppFileTaskImpl,
    CreateUwsgiReadmeFileTaskImpl,
    CreateUwsgiDockerfileTaskImpl,
    CreateDaemonBootstrapFileTaskImpl,
    CreateDepFileTaskImpl,
    CreateRouteFileTaskImpl;


    function TCreateAppBootstrapUwsgiTaskFactory.buildBootstrapTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TGroupTask.create([
            TCreateUwsgiAppFileTask.create(textFileCreator, contentModifier),
            TCreateUwsgiReadmeFileTask.create(textFileCreator, contentModifier),
            TCreateUwsgiDockerfileTask.create(textFileCreator, contentModifier),
            TCreateDaemonBootstrapFileTask.create(textFileCreator, contentModifier),
            TCreateDepFileTask.create(textFileCreator, contentModifier),
            TCreateRouteFileTask.create(textFileCreator, contentModifier)
        ]);
    end;

end.

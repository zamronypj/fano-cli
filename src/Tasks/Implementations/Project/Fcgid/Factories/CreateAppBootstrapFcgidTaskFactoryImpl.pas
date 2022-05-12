(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateAppBootstrapFcgidTaskFactoryImpl;

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
     * factory class for FastCGI application bootstrap task
     * with mod_fcgid
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAppBootstrapFcgidTaskFactory = class(TCreateAppBootstrapTaskFactory)
    protected
        function buildBootstrapTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; override;
    end;

implementation

uses

    GroupTaskImpl,

    CreateFcgidAppFileTaskImpl,
    CreateFcgidReadmeFileTaskImpl,
    CreateFcgidDockerfileTaskImpl,
    CreateDaemonBootstrapFileTaskImpl,
    CreateDepFileTaskImpl,
    CreateRouteFileTaskImpl;


    function TCreateAppBootstrapFcgidTaskFactory.buildBootstrapTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TGroupTask.create([
            TCreateFcgidAppFileTask.create(textFileCreator, contentModifier),
            TCreateFcgidReadmeFileTask.create(textFileCreator, contentModifier),
            TCreateFcgidDockerfileTask.create(textFileCreator, contentModifier),
            TCreateDaemonBootstrapFileTask.create(textFileCreator, contentModifier),
            TCreateDepFileTask.create(textFileCreator, contentModifier),
            TCreateRouteFileTask.create(textFileCreator, contentModifier)
        ]);
    end;

end.

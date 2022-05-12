(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateAppBootstrapCgiTaskFactoryImpl;

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
     * factory class for CGI application bootstrap task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAppBootstrapCgiTaskFactory = class(TCreateAppBootstrapTaskFactory)
    protected
        function buildBootstrapTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; override;
    end;

implementation

uses

    GroupTaskImpl,

    CreateCgiAppFileTaskImpl,
    CreateCgiReadmeFileTaskImpl,
    CreateCgiDockerfileTaskImpl,
    CreateBootstrapFileTaskImpl,
    CreateDepFileTaskImpl,
    CreateRouteFileTaskImpl;


    function TCreateAppBootstrapCgiTaskFactory.buildBootstrapTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TGroupTask.create([
            TCreateCgiAppFileTask.create(textFileCreator, contentModifier),
            TCreateCgiReadmeFileTask.create(textFileCreator, contentModifier),
            TCreateCgiDockerfileTask.create(textFileCreator, contentModifier),
            TCreateBootstrapFileTask.create(textFileCreator, contentModifier),
            TCreateDepFileTask.create(textFileCreator, contentModifier),
            TCreateRouteFileTask.create(textFileCreator, contentModifier)
        ]);
    end;

end.

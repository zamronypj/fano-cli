(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateAppBootstrapFcgiTaskFactoryImpl;

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
     * interface for factory Task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAppBootstrapFcgiTaskFactory = class(TCreateAppBootstrapTaskFactory)
    protected
        function buildBootstrapTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; override;
    end;

implementation

uses

    CreateFcgiAppBootstrapTaskImpl;

    function TCreateAppBootstrapFcgiTaskFactory.buildBootstrapTask(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TCreateFcgiAppBootstrapTask.create(textFileCreator, contentModifier);
    end;

end.

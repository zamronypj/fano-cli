(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateAppBootstrapTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf,
    TextFileCreatorIntf,
    ContentModifierIntf;

type

    (*!--------------------------------------
     * interface for factory Task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAppBootstrapTaskFactory = class(TInterfacedObject, ITaskFactory)
    private
        function buildAppBootstrap(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask;

    public
        function build() : ITask;
    end;

implementation

uses

    TextFileCreatorImpl,
    ContentModifierImpl,
    NullTaskImpl,
    CompositeSessionTaskImpl,
    CompositeSessionTypeTaskImpl,
    CompositeFileTypeTaskImpl,
    CreateAppBootstrapTaskImpl,
    JsonFileSessionContentModifierImpl,
    IniFileSessionContentModifierImpl,
    JsonCookieSessionContentModifierImpl,
    IniCookieSessionContentModifierImpl;

    function TCreateAppBootstrapTaskFactory.buildAppBootstrap(
        const textFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    ) : ITask;
    begin
        result := TCompositeSessionTask.create(
            //run this task when --with-session parameter is set
            TCompositeSessionTypeTask.create(

                //run this task if session use file as storage
                TCompositeFileTypeTask.create(
                    //json file session
                    TCreateAppBootstrapTask.create(
                        textFileCreator,
                        TJsonFileSessionContentModifier.create(contentModifier)
                    ),
                    //json ini file session
                    TCreateAppBootstrapTask.create(
                        textFileCreator,
                        TIniFileSessionContentModifier.create(contentModifier)
                    )
                ),

                //run this task if session use cookie as storage
                TCompositeFileTypeTask.create(
                    //json cookie session
                    TCreateAppBootstrapTask.create(
                        textFileCreator,
                        TJsonCookieSessionContentModifier.create(contentModifier)
                    ),
                    //ini cookie file session
                    TCreateAppBootstrapTask.create(
                        textFileCreator,
                        TIniCookieSessionContentModifier.create(contentModifier)
                    )
                ),

                TNullTask.create()
            ),
            //run this task when --with-session parameter is not set
            TCreateAppBootstrapTask.create(textFileCreator, contentModifier)
        );
    end;

    function TCreateAppBootstrapTaskFactory.build() : ITask;
    var textFileCreator : ITextFileCreator;
        contentModifier : IContentModifier;
    begin
        textFileCreator := TTextFileCreator.create();
        try
            contentModifier := TContentModifier.create();
            try
                try
                    result := buildAppBootstrap(textFileCreator, contentModifier);
                except
                    result := nil;
                end;
            finally
                contentModifier := nil;
            end;
        finally
            textFileCreator := nil;
        end;
    end;
end.

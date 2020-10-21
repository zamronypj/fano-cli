(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
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
    TCreateAppBootstrapTaskFactory = class abstract (TInterfacedObject, ITaskFactory)
    private
        function buildAppBootstrap(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask;
    protected
        function buildBootstrapTask(
            const textFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        ) : ITask; virtual; abstract;
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
                    buildBootstrapTask(
                        textFileCreator,
                        TJsonFileSessionContentModifier.create(contentModifier)
                    ),
                    //json ini file session
                    buildBootstrapTask(
                        textFileCreator,
                        TIniFileSessionContentModifier.create(contentModifier)
                    )
                ),

                //run this task if session use cookie as storage
                TCompositeFileTypeTask.create(
                    //json cookie session
                    buildBootstrapTask(
                        textFileCreator,
                        TJsonCookieSessionContentModifier.create(contentModifier)
                    ),
                    //ini cookie session
                    buildBootstrapTask(
                        textFileCreator,
                        TIniCookieSessionContentModifier.create(contentModifier)
                    )
                ),
                TCompositeDbTypeTask.create([
                    (
                        name :'mysql',
                        task : buildBootstrapTask(
                            textFileCreator,
                            TMysqlDbSessionContentModifier.create(contentModifier)
                        )
                    ),
                    (
                        name :'postgresql',
                        task : buildBootstrapTask(
                            textFileCreator,
                            TPostgresqlDbSessionContentModifier.create(contentModifier)
                        )
                    ),
                    (
                        name :'firebird',
                        task : buildBootstrapTask(
                            textFileCreator,
                            TFirebirdDbSessionContentModifier.create(contentModifier)
                        )
                    ),
                    (
                        name :'sqlite',
                        task : buildBootstrapTask(
                            textFileCreator,
                            TSqliteDbSessionContentModifier.create(contentModifier)
                        )
                    ),
                ])

                //run this task if session use db as storage, not yet supported
                //so just create as if --with-session is not set
                buildBootstrapTask(textFileCreator, contentModifier)
            ),
            //run this task when --with-session parameter is not set
            buildBootstrapTask(textFileCreator, contentModifier)
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

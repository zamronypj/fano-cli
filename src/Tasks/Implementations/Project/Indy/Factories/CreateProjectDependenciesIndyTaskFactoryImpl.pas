(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateProjectDependenciesIndyTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Helper factory class for create project dependency task
     * for Indy-based web application
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectDependenciesIndyTaskFactory = class(TInterfacedObject, ITaskFactory)
    private
        fProjectDepTask : ITaskFactory;
    public
        constructor create(const aProjectDepTask : ITaskFactory);

        destructor destroy(); override;
        function build() : ITask;
    end;

implementation

uses

    FileContentReaderIntf,
    FileContentWriterIntf,
    FileHelperImpl,
    CreateIndyCompilerConfigsTaskImpl;

    constructor TCreateProjectDependenciesIndyTaskFactory.create(const aProjectDepTask : ITaskFactory);
    begin
        fProjectDepTask := aProjectDepTask;
    end;

    destructor TCreateProjectDependenciesIndyTaskFactory.destroy();
    begin
        fProjectDepTask := nil;
        inherited destroy();
    end;

    function TCreateProjectDependenciesIndyTaskFactory.build() : ITask;
    var fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        //wrap compiler config task so that when command --project-indy is detected,
        //it will properly enable conditional define -DUSE_INDY
        result := TCreateIndyCompilerConfigsTask.create(
            fProjectDepTask.build(),
            fReader,
            fWriter
        );
    end;

end.

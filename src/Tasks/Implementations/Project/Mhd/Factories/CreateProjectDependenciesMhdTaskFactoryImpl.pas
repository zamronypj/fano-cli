(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateProjectDependenciesMhdTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Helper factory class for create project dependency task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectDependenciesMhdTaskFactory = class(TInterfacedObject, ITaskFactory)
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
    CreateMhdCompilerConfigsTaskImpl;

    constructor TCreateProjectDependenciesMhdTaskFactory.create(const aProjectDepTask : ITaskFactory);
    begin
        fProjectDepTask := aProjectDepTask;
    end;

    destructor TCreateProjectDependenciesMhdTaskFactory.destroy();
    begin
        fProjectDepTask := nil;
        inherited destroy();
    end;

    function TCreateProjectDependenciesMhdTaskFactory.build() : ITask;
    var fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        //wrap compiler config task so that when command --project-mhd is detected,
        //it will properly enable conditional define -DLIBMICROHTTPD
        result := TCreateMhdCompilerConfigsTask.create(
            fProjectDepTask.build(),
            fReader,
            fWriter
        );      
    end;

end.

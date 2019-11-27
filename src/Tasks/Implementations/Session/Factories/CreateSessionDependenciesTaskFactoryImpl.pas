(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateSessionDependenciesTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create session dependencies task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateSessionDependenciesTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    NullTaskImpl,
    CreateFileSessionDependencyTaskImpl,
    CreateCookieSessionDependencyTaskImpl,
    CreateSessionDependencyTaskImpl;

    function TCreateSessionDependenciesTaskFactory.build() : ITask;
    begin
        result := TCreateSessionDependencyTask.create(
            TCreateFileSessionDependencyTask.create(),
            TCreateCookieSessionDependencyTask.create(),
            TNullTask.create()
        );
    end;

end.

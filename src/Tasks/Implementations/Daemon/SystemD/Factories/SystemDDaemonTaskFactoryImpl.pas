(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit SystemDDaemonTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for setting up web application
     * as daemon service with SystemD
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TSystemDDaemonTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    TextFileCreatorImpl,
    DirectoryCreatorImpl,
    ContentModifierImpl,
    RootCheckTaskImpl,
    SystemDDaemonTaskImpl;

    function TSystemDDaemonTaskFactory.build() : ITask;
    var task : ITask;
    begin
        task := TSystemDDaemonTask.create(
            TTextFileCreator.create(),
            TDirectoryCreator.create(),
            TContentModifier.create()
        );

        //protect to avoid accidentally running without root privilege
        result := TRootCheckTask.create(task);
    end;

end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WritelnTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for create writeln task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TWritelnTaskFactory = class(TInterfacedObject, ITaskFactory)
    private
        fText : string;
        fTaskFactory : ITaskFactory;
    public
        constructor create(const taskFactory : ITaskFactory);
        function build() : ITask;
        function write(const str : string) : ITaskFactory;
    end;

implementation

uses

    GroupTaskImpl,
    WritelnTaskImpl;

    constructor TWritelnTaskFactory.create(const taskFactory : ITaskFactory);
    begin
        fTaskFactory := taskFactory;
        fText := '';
    end;

    function TWritelnTaskFactory.build() : ITask;
    begin
        result := TGroupTask.create([
            fTaskFactory.build(),
            TWritelnTask.create(fText)
        ]);
    end;

    function TWritelnTaskFactory.write(const str : string) : ITaskFactory;
    begin
        fText := str;
        result := self;
    end;

end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFileSessionDependenciesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that add file session support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFileSessionDependenciesTask = class(TInterfacedObject, ITask)
    private
        fCreateJsonFileSessionTask : ITask;
        fCreateIniFileSessionTask : ITask;
    public
        constructor create(
            const createJsonFileSessTask : ITask;
            const createIniFileSessTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    constructor TCreateFileSessionDependenciesTask.create(
        const createJsonFileSessTask : ITask;
        const createIniFileSessTask : ITask
    );
    begin
        fCreateJsonFileSessionTask := createJsonFileSessTask;
        fCreateIniFileSessionTask := createIniFileSessTask;
    end;

    destructor TCreateFileSessionDependenciesTask.destroy();
    begin
        fCreateJsonFileSessionTask := nil;
        fCreateIniFileSessionTask := nil;
        inherited destroy();
    end;

    function TCreateFileSessionDependenciesTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var fType : string;
    begin
        fType := opt.getOptionValueDef('type', 'json');
        if (fType = 'json') then
        begin
            fCreateJsonFileSessionTask.run(opt, longOpt);
        end else
        if (fType = 'ini') then
        begin
            fCreateJsonFileSessionTask.run(opt, longOpt);
        end else
        begin
            fCreateJsonFileSessionTask.run(opt, longOpt);
        end;
        result := self;
    end;
end.

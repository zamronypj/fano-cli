(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CompositeSessionTypeTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that add session support to project creation
     * based on session storage type, i.e, file, cookie or db
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCompositeSessionTypeTask = class(TInterfacedObject, ITask)
    private
        fFileTask : ITask;
        fCookieTask : ITask;
        fDbTask : ITask;
    public
        constructor create(
            const fileSessTask : ITask;
            const cookieSessTask : ITask;
            const dbSessTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

    constructor TCompositeSessionTypeTask.create(
        const fileSessTask : ITask;
        const cookieSessTask : ITask;
        const dbSessTask : ITask
    );
    begin
        fFileTask := fileSessTask;
        fCookieTask := cookieSessTask;
        fDbTask := dbSessTask;
    end;

    destructor TCompositeSessionTypeTask.destroy();
    begin
        fFileTask := nil;
        fCookieTask := nil;
        fDbTask := nil;
        inherited destroy();
    end;

    function TCompositeSessionTypeTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var sessType : string;
    begin
        if opt.hasOption('with-session') then
        begin
            sessType := opt.getOptionValueDef('with-session', 'file');
            case sessType of
                'file' : result := fFileTask.run(opt,longOpt);
                'cookie' : result := fCookieTask.run(opt,longOpt);
                'db' : result := fDbTask.run(opt,longOpt);
            end;
        end;
        result := self;
    end;
end.

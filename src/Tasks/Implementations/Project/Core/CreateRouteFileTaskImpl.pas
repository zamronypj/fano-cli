(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateRouteFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create route.inc file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateRouteFileTask = class(TCreateFileTask)
    protected

        procedure createRoutes(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); virtual;

    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    procedure TCreateRouteFileTask.createRoutes(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/routes.inc.inc}
    begin
        createTextFile(dir + '/routes.inc', strRoutesInc);
    end;

    function TCreateRouteFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createApp(opt, longOpt, baseDirectory + '/src');
        result := self;
    end;
end.

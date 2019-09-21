(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateAppBootstrapTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * application bootstrapper using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAppBootstrapTask = class(TCreateFileTask)
    protected
        procedure createApp(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); virtual;

        procedure createBootstrap(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); virtual;

        procedure createDependencies(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); virtual;

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

    procedure TCreateAppBootstrapTask.createApp(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/app.pas.inc}
    begin
        createTextFile(dir + '/app.pas', strAppPas);
    end;

    procedure TCreateAppBootstrapTask.createBootstrap(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/bootstrap.pas.inc}
    begin
        createTextFile(dir + '/bootstrap.pas', strBootstrapPas);
    end;

    procedure TCreateAppBootstrapTask.createDependencies(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/main.dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/models.dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/controllers.dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/views.dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/middlewares.dependencies.inc.inc}
    begin
        createTextFile(dir + '/dependencies.inc', strDependenciesInc);
        createTextFile(dir + '/main.dependencies.inc', strMainDependenciesInc);
        createTextFile(dir + '/models.dependencies.inc', strModelDependenciesInc);
        createTextFile(dir + '/views.dependencies.inc', strViewDependenciesInc);
        createTextFile(dir + '/controllers.dependencies.inc', strCtrlDependenciesInc);
        createTextFile(dir + '/middlewares.dependencies.inc', strMiddlewaresDependenciesInc);
    end;

    procedure TCreateAppBootstrapTask.createRoutes(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/routes.inc.inc}
    begin
        createTextFile(dir + '/routes.inc', strRoutesInc);
    end;

    function TCreateAppBootstrapTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createApp(opt, longOpt, baseDirectory + '/src');
        createBootstrap(opt, longOpt, baseDirectory + '/src');
        createDependencies(opt, longOpt, baseDirectory + '/src/Dependencies');
        createRoutes(opt, longOpt, baseDirectory + '/src/Routes');
        result := self;
    end;
end.

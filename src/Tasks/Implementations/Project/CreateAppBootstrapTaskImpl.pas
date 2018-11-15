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
    private
        procedure createApp(const dir : string);
        procedure createBootstrap(const dir : string);
        procedure createDependencies(const dir : string);
        procedure createRoutes(const dir : string);
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    procedure TCreateAppBootstrapTask.createApp(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/app.pas.inc}
    begin
        createTextFile(dir + '/app.pas', strAppPas);
    end;

    procedure TCreateAppBootstrapTask.createBootstrap(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/bootstrap.pas.inc}
    begin
        createTextFile(dir + '/bootstrap.pas', strBootstrapPas);
    end;

    procedure TCreateAppBootstrapTask.createDependencies(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/main.dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/controllers.dependencies.inc.inc}
    begin
        createTextFile(dir + '/dependencies.inc', strDependenciesInc);
        createTextFile(dir + '/main.dependencies.inc', strMainDependenciesInc);
        createTextFile(dir + '/controllers.dependencies.inc', strCtrlDependenciesInc);
    end;

    procedure TCreateAppBootstrapTask.createRoutes(const dir : string);
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
        createApp(baseDirectory + '/app');
        createBootstrap(baseDirectory + '/app');
        createDependencies(baseDirectory + '/app/Dependencies');
        createRoutes(baseDirectory + '/app/Routes');
        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDepFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create app.pas file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateDepFileTask = class(TCreateFileTask)
    protected

        procedure createDependencies(
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

    procedure TCreateDepFileTask.createDependencies(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/main.dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/models.dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/controllers.dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/views.dependencies.inc.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/middlewares.dependencies.inc.inc}
    begin
        createTextFile(dir + '/dependencies.inc', strDependenciesInc);
        createTextFile(dir + '/main.dependencies.inc', strMainDependenciesInc);
        createTextFile(dir + '/models.dependencies.inc', strModelDependenciesInc);
        createTextFile(dir + '/views.dependencies.inc', strViewDependenciesInc);
        createTextFile(dir + '/controllers.dependencies.inc', strCtrlDependenciesInc);
        createTextFile(dir + '/middlewares.dependencies.inc', strMiddlewaresDependenciesInc);
    end;

    function TCreateDepFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createDependencies(opt, longOpt, baseDirectory + '/src/Dependencies');
        result := self;
    end;
end.

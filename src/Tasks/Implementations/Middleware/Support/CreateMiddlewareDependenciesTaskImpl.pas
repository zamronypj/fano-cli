(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMiddlewareDependenciesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    FileContentReaderIntf,
    CreateDispatcherMethodTaskImpl;

type

    (*!--------------------------------------
     * Task that add middleware support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMiddlewareDependenciesTask = class(TCreateDispatcherMethodTask)
    private
        procedure createBuildDispatcherDependency();
        procedure dontCreateBuildDispatcherDependency();
    public

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    procedure TCreateMiddlewareDependenciesTask.createBuildDispatcherDependency();
    var
        {$INCLUDE src/Tasks/Implementations/Middleware/Support/Includes/buildDispatcher.decl.inc}
        {$INCLUDE src/Tasks/Implementations/Middleware/Support/Includes/buildDispatcher.impl.inc}
    begin
        createBuildDispatcherDependencyTpl(strBuildDispatcherDecl, strBuildDispatcherImpl);
    end;

    procedure TCreateMiddlewareDependenciesTask.dontCreateBuildDispatcherDependency();
    begin
        createBuildDispatcherDependencyTpl('', '');
    end;

    function TCreateMiddlewareDependenciesTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);

        if (opt.hasOption('with-middleware')) then
        begin
            createBuildDispatcherDependency();
        end else
        begin
            dontCreateBuildDispatcherDependency();
        end;

        result := self;
    end;
end.

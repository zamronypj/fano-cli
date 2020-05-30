(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateNoMiddlewareDependenciesTaskImpl;

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
     * Task that add no middleware support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateNoMiddlewareDependenciesTask = class(TCreateDispatcherMethodTask)
    private
        procedure dontCreateBuildDispatcherDependency();
    public

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    procedure TCreateNoMiddlewareDependenciesTask.dontCreateBuildDispatcherDependency();
    begin
        createBuildDispatcherDependencyTpl('', '');
    end;

    function TCreateNoMiddlewareDependenciesTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);

        dontCreateBuildDispatcherDependency();

        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFileSessionDependenciesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ConditionalCompositeTaskImpl;

type

    (*!--------------------------------------
     * Task that add file session support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFileSessionDependenciesTask = class(TConditionalCompositeTask)
    protected
        function condition(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : boolean; override;
    end;

implementation


    function TCreateFileSessionDependenciesTask.condition(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : boolean;
    begin
        result := (opt.getOptionValueDef('type', 'json') = 'json');
    end;
end.

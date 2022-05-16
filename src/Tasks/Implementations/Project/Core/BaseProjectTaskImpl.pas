(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseProjectTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Base task that create web application project
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseProjectTask = class(TInterfacedObject, ITask)
    protected
        baseDirectory : string;
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; virtual;
    end;

implementation

uses

    sysutils;

    function TBaseProjectTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        baseDirectory := opt.getOptionValue(longOpt);
        result := self;
    end;
end.

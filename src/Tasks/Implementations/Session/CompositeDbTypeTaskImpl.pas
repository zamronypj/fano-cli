(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CompositeDbTypeTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    NamedCompositeTaskImpl;

type

    (*!--------------------------------------
     * Task that run task using value of --db options
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCompositeDbTypeTask = class(TNamedCompositeTask)
    protected
        (*!--------------------------------------
        * get task name
        *---------------------------------------------
        * @param opt current task options
        * @param longOpt current long option name
        * @return task name string
        *---------------------------------------*)
        function getTaskName(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : shortstring; override;
    end;

implementation

    (*!--------------------------------------
    * get task name
    *---------------------------------------------
    * @param opt current task options
    * @param longOpt current long option name
    * @return task name string
    *---------------------------------------*)
    function TCompositeDbTypeTask.getTaskName(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : shortstring;
    begin
        result := opt.getOptionValueDef('db', 'mysql');
    end;
end.

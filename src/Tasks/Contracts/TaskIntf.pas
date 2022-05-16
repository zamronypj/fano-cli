(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit TaskIntf;

interface

{$MODE OBJFPC}
{$H+}

uses
    TaskOptionsIntf;

type

    (*!--------------------------------------
     * interface for task. Task is anything that
     * can be run
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    ITask = interface
        ['{E9FF160F-DE92-4475-91A3-88CEA2A92130}']

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

end.

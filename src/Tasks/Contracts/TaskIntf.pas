(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit TaskIntf;

interface

{$MODE OBJFPC}
{$H+}

uses
    TaskOptionsIntf;

type

    ITask = interface
        ['{E9FF160F-DE92-4475-91A3-88CEA2A92130}']

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

end.

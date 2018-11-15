(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit TaskFactoryIntf;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf;

type

    (*!--------------------------------------
     * interface for factory Task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    ITaskFactory = interface
        ['{4D47A06F-E2E2-4BB3-A611-D7D1732F6B2A}']
        function build() : ITask;
    end;

implementation

end.

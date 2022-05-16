(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit TaskListAwareIntf;

interface

{$MODE OBJFPC}
{$H+}

uses

    ListIntf;

type

    (*!--------------------------------------
     * interface for any class having capability
     * to get list of available tasks.
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    ITaskListAware = interface
        ['{662D0179-97D9-492F-A395-1AFE459D64FD}']
        function getTaskList() : IList;
    end;

implementation

end.

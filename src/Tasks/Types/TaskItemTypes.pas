(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit TaskItemTypes;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf;

type

    TTaskItem = record
        longOption : string;
        description : string;
        task : ITask;
    end;
    PTaskItem = ^TTaskItem;

implementation

end.

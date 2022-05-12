(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit TaskInfoIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    (*!--------------------------------------
     * interface for any class having capability
     * to describe a task. This is mostly use for help
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    ITaskInfo = interface
        ['{D3051780-EFA0-465D-8181-2096DD419BE1}']
        function getLongOption() : string;
        function getDescription() : string;
    end;

implementation

end.

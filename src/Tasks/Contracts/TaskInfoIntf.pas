(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit TaskInfoIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    ITaskInfo = interface
        ['{D3051780-EFA0-465D-8181-2096DD419BE1}']
        function getLongOption() : string;
        function getDescription() : string;
    end;

implementation

end.

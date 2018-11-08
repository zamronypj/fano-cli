(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit AppIntf;

interface

{$MODE OBJFPC}
{$H+}

uses
    TaskIntf;

type

    IFanoCliApplication = interface
        ['{34391655-1357-4DD1-9CD9-FCB81561F903}']

        procedure registerTask(
            const longOpt : shortstring;
            const longOptDesc : string;
            const desc : string;
            const task : ITask
        );
    end;

implementation

end.

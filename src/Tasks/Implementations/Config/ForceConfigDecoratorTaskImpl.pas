(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ForceConfigDecoratorTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    WithOptionsDecoratorTaskImpl;

type

    (*!--------------------------------------
     * Task that force --config parameter always set
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TForceConfigDecoratorTask = class(TWithOptionsDecoratorTask)
    public
        function hasOption(const longOpt: string) : boolean; override;
    end;

implementation

    function TForceConfigDecoratorTask.hasOption(const longOpt: string) : boolean;
    begin
        result := fOrigOpts.hasOption(longOpt);
        if (longOpt = 'config') and (result = false) then
        begin
            //--config not set but we force --config parameter always set
            result := true;
        end;
    end;
end.

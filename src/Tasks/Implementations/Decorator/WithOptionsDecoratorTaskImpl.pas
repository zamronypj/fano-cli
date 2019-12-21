(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WithOptionsDecoratorTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorTaskImpl;

type

    (*!--------------------------------------
     * Task that decorate other task and implement ITaskOptions
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------------
     * Here we intentionally delegate manually not using interface delegation
     * with implements keyword to avoid possible memory leak if developer not careful
     * @link https://stackoverflow.coms/questions/57708303/why-is-this-interface-delegation-causing-memory-leak
     *---------------------------------------*)
    TWithOptionsDecoratorTask = class(TDecoratorTask, ITaskOptions)
    private
        fOpts : ITaskOptions;
    public
        constructor create(const task : ITask; const opts : ITaskOptions);
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;

        function hasOption(const longOpt: string) : boolean; virtual;
        function getOptionValue(const longOpt: string) : string; virtual;
        function getOptionValueDef(const longOpt: string; const defValue : string) : string; virtual;
    end;

implementation

    constructor TWithOptionsDecoratorTask.create(
        const task : ITask;
        const opts : ITaskOptions
    );
    begin
        inherited create(task);
        fOpts := opts;
    end;

    destructor TWithOptionsDecoratorTask.destroy();
    begin
        fOpts := nil;
        inherited destroy();
    end;

    function TWithOptionsDecoratorTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        actualTask.run(self, longOpt);
        result := self;
    end;

    function TWithOptionsDecoratorTask.hasOption(const longOpt: string) : boolean;
    begin
        result := fOpts.hasOption(longOpt);
    end;

    function TWithOptionsDecoratorTask.getOptionValue(const longOpt: string) : string;
    begin
        result := fOpts.getOptionValue(longOpt);
    end;

    function TWithOptionsDecoratorTask.getOptionValueDef(const longOpt: string; const defValue : string) : string;
    begin
        result := fOpts.getOptionValueDef(longOpt ,defValue);
    end;
end.

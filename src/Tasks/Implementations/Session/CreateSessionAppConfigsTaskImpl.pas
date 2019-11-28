(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateSessionAppConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ContentModifierIntf,
    KeyGeneratorIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * compiler config files using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateSessionAppConfigsTask = class(TInterfacedObject, ITask)
    private
        fJsonAppConfigTask : ITask;
        fIniAppConfigTask : ITask;
    public
        constructor create(
            const aJsonAppConfigTask : ITask;
            const aIniAppConfigTask : ITask
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    sysutils;

    constructor TCreateSessionAppConfigsTask.create(
        const aJsonAppConfigTask : ITask;
        const aIniAppConfigTask : ITask
    );
    begin
        fJsonAppConfigTask := aJsonAppConfigTask;
        fIniAppConfigTask := aIniAppConfigTask;
    end;

    destructor TCreateSessionAppConfigsTask.destroy();
    begin
        fJsonAppConfigTask := nil;
        fIniAppConfigTask := nil;
        inherited destroy();
    end;

    function TCreateSessionAppConfigsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var configType : string;
    begin
        if (opt.hasOption('config')) then
        begin
            configType := opt.getOptionValueDef('config', 'json');
            if (configType = 'ini') then
            begin
                fIniAppConfigTask.run(opt, longOpt);
            end else
            begin
                fJsonAppConfigTask.run(opt, longOpt);
            end;
        end;
        result := self;
    end;
end.

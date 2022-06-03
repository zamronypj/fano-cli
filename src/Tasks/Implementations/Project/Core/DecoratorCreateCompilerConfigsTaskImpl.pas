(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DecoratorCreateCompilerConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    FileContentWriterIntf,
    FileContentReaderIntf,
    BaseProjectTaskImpl;

type

    (*!--------------------------------------
     * decorator task that create web application project
     * compiler config files
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDecoratorCreateCompilerConfigsTask = class abstract (TBaseProjectTask)
    protected
        fCompilerCfgTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;

        function doCompilerConfigs(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; virtual; abstract;
    public
        constructor create(
            const aCompilerCfgTask : ITask;
            const aReader : IFileContentReader;
            const aWriter : IFileContentWriter
        );

        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    constructor TDecoratorCreateCompilerConfigsTask.create(
        const aCompilerCfgTask : ITask;
        const aReader : IFileContentReader;
        const aWriter : IFileContentWriter
    );
    begin
        inherited create();
        fCompilerCfgTask := aCompilerCfgTask;
        fReader := aReader;
        fWriter := aWriter;
    end;

    destructor TDecoratorCreateCompilerConfigsTask.destroy();
    begin
        fCompilerCfgTask := nil;
        fReader := nil;
        fWriter := nil;
        inherited destroy();
    end;

    function TDecoratorCreateCompilerConfigsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        fCompilerCfgTask.run(opt, longOpt);
        result := doCompilerConfigs(opt, longOpt);
    end;
end.

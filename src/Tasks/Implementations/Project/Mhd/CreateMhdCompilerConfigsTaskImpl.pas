(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMhdCompilerConfigsTaskImpl;

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
     * Task that create web application project
     * compiler config files and enable conditional 
     * define -DLIBMICROHTTPD if current command is 
     * --project-mhd
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMhdCompilerConfigsTask = class(TBaseProjectTask)
    private
        fCompilerCfgTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
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

uses 

    SysUtils;

    constructor TCreateMhdCompilerConfigsTask.create(
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

    destructor TCreateMhdCompilerConfigsTask.destroy();
    begin
        fCompilerCfgTask := nil;
        fReader := nil;
        fWriter := nil;
        inherited destroy();
    end;

    function TCreateMhdCompilerConfigsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        fCompilerCfgTask.run(opt, longOpt);
        if (longOpt = 'project-mhd') then 
        begin
            fWriter.write(
                baseDirectory + '/build.cfg',
                StringReplace(
                    fReader.read(baseDirectory + '/build.cfg'), 
                    '#-DLIBMICROHTTPD', 
                    '-DLIBMICROHTTPD', 
                    [rfReplaceAll]
                )
            );
        end;
        result := self;
    end;
end.

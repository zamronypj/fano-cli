(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateProjectTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseProjectTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * directory structure using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectTask = class(TBaseProjectTask)
    private
        fTask: ITask;
    protected
        procedure runTasks(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ); virtual;
    public
        constructor create(const aTask : ITask);
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils,
    StrFormats;

    constructor TCreateProjectTask.create(
        const aTask : ITask
    );
    begin
        fTask := aTask;
    end;

    destructor TCreateProjectTask.destroy();
    begin
        fTask := nil;
        inherited destroy();
    end;

    procedure TCreateProjectTask.runTasks(
        const opt : ITaskOptions;
        const longOpt : shortstring
    );
    begin
        fTask.run(opt, longOpt);
    end;

    function TCreateProjectTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);

        if (baseDirectory.length = 0) then
        begin
            writeln('Project target directory can not be empty.');
            writeln('Run with --help to view available tasks.');
            result := self;
            exit();
        end;

        writeln('Start creating project in ', formatColor(baseDirectory, TXT_GREEN), ' directory.');

        runTasks(opt, longOpt);

        writeln('Finish creating project in ', formatColor(baseDirectory, TXT_GREEN), ' directory.');
        writeln('Change directory to ', baseDirectory, ' to start creating controller, view, etc.');
        writeln();
        {$IFDEF WINDOWS}
        writeln(formatColor('> cd ' + baseDirectory, TXT_GREEN));
        writeln(formatColor('> fanocli --controller=Home --route=/', TXT_GREEN));
        {$ELSE}
        writeln(formatColor('$ cd ' + baseDirectory, TXT_GREEN));
        writeln(formatColor('$ fanocli --controller=Home --route=/', TXT_GREEN));
        {$ENDIF}
        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateBootstrapFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create bootstrap.pas file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateBootstrapFileTask = class(TCreateFileTask)
    protected

        procedure createBootstrap(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); virtual;

    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    procedure TCreateBootstrapFileTask.createBootstrap(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/bootstrap.pas.inc}
    begin
        createTextFile(dir + '/bootstrap.pas', strBootstrapPas);
    end;

    function TCreateBootstrapFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createBootstrap(opt, longOpt, baseDirectory + '/src');
        result := self;
    end;
end.

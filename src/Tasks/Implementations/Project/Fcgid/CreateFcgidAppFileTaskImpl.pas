(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFcgidAppFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateAppFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create FastCGI app.pas
     * with Apache web server and mod_fcgid module
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFcgidAppFileTask = class(TCreateAppFileTask)
    protected
        procedure createApp(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateFcgidAppFileTask.createApp(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Fcgid/Includes/app.pas.inc}
    begin
        createTextFile(dir + '/app.pas', strAppPas);
    end;

end.

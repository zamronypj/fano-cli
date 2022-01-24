(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateScgiDockerfileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateBasicFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * custom Dockerfile file for SCGI project
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateScgiDockerfileTask = class(TCreateBasicFileTask)
    private
        procedure createVhostExampleFile(const dir : string);
        procedure createDockerfileFile(const dir : string);
    protected
        procedure createFile(const dir : string); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateScgiDockerfileTask.createVhostExampleFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Scgi/Includes/vhost.example.inc}
    begin
        createTextFile(dir + '/vhost.example', strVhostExample);
    end;

    procedure TCreateScgiDockerfileTask.createDockerfileFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Scgi/Includes/dockerfile.inc}
    begin
        createTextFile(dir + '/Dockerfile', strDockerfile);
    end;

    procedure TCreateScgiDockerfileTask.createFile(const dir : string);
    begin
        createVhostExampleFile(dir);
        createDockerfileFile(dir);
    end;


end.

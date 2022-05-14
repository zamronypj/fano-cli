(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateUwsgiDockerfileTaskImpl;

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
     * custom Dockerfile file for uwsgi project
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateUWsgiDockerfileTask = class(TCreateBasicFileTask)
    private
        procedure createVhostExampleFile(const dir : string);
        procedure createDockerfileFile(const dir : string);
        procedure createHttpdDockerfileFile(const dir : string);
        procedure createDockercomposeFile(const dir : string);
    protected
        procedure createFile(const dir : string); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateUwsgiDockerfileTask.createVhostExampleFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Uwsgi/Includes/vhost.example.inc}
    begin
        createTextFile(dir + '/vhost.example', strVhostExample);
    end;

    procedure TCreateUwsgiDockerfileTask.createDockerfileFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Uwsgi/Includes/fano_dockerfile.inc}
    begin
        createTextFile(dir + '/fano_dockerfile', strDockerfile);
    end;

    procedure TCreateUwsgiDockerfileTask.createHttpdDockerfileFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Uwsgi/Includes/httpd_dockerfile.inc}
    begin
        createTextFile(dir + '/httpd_dockerfile', strHttpdDockerfile);
    end;

    procedure TCreateUwsgiDockerfileTask.createDockercomposeFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Uwsgi/Includes/dockercompose.inc}
    begin
        createTextFile(dir + '/docker-compose.yaml', strDockercompose);
    end;

    procedure TCreateUwsgiDockerfileTask.createFile(const dir : string);
    begin
        createVhostExampleFile(dir);
        createDockerfileFile(dir);
        createHttpdDockerfileFile(dir);
        createDockercomposeFile(dir);
    end;

end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFcgiDockerfileTaskImpl;

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
     * custom Dockerfile file for FastCGI project
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFcgiDockerfileTask = class(TCreateBasicFileTask)
    protected
        procedure createFile(const dir : string); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateFcgiDockerfileTask.createFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/FastCgi/Includes/dockerfile.inc}
    begin
        createTextFile(dir + '/Dockerfile', strDockerfile);
    end;

end.

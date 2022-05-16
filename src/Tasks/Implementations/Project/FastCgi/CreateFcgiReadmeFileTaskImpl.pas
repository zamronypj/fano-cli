(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFcgiReadmeFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateReadmeFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * custom README file for FastCGI project
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFcgiReadmeFileTask = class(TCreateReadmeFileTask)
    protected
        procedure createReadmeFile(const dir : string); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateFcgiReadmeFileTask.createReadmeFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/FastCgi/Includes/readme.md.inc}
    begin
        createTextFile(dir + '/README.md', strReadme);
    end;


end.

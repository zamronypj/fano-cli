(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFcgidReadmeFileTaskImpl;

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
     * custom README file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFcgidReadmeFileTask = class(TCreateReadmeFileTask)
    protected
        procedure createReadmeFile(const dir : string); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateFcgidReadmeFileTask.createReadmeFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Fcgid/Includes/readme.md.inc}
    begin
        createTextFile(dir + '/README.md', strReadme);
    end;

end.

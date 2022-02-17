(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFpwebReadmeFileTaskImpl;

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
     * custom README file for http project
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFpwebReadmeFileTask = class(TCreateReadmeFileTask)
    protected
        procedure createReadmeFile(const dir : string); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateFpwebReadmeFileTask.createReadmeFile(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Fpweb/Includes/readme.md.inc}
    begin
        createTextFile(dir + '/README.md', strReadme);
    end;

end.

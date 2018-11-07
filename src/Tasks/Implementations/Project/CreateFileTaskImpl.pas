(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that create web application project
     * files using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFileTask = class(TBaseProjectTask)
    private
    protected
        procedure createTextFile(const filename : string; const content : string);
    end;

implementation

uses

    sysutils;

    procedure TCreateFileTask.createTextFile(const filename : string; const content : string);
    var fStream : TFileStream;
        str : TStringStream;
    begin
        fStream := TFileStream.create(filename, fmCreate);
        str := TStringStream.create(content);
        try
            fStream.copyFrom(str);
        finally
            str.free();
            fStream.free();
        end;
    end;
end.

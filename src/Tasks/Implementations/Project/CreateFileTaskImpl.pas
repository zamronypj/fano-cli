(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    BaseProjectTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * files using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFileTask = class(TBaseProjectTask)
    private
        textFileCreator : ITextFileCreator;
    protected
        procedure createTextFile(const filename : string; const content : string);
    public
        constructor create(const txtFileCreator : ITextFileCreator);
        destructor destroy(); override;
    end;

implementation

    constructor TCreateFileTask.create(const txtFileCreator : ITextFileCreator);
    begin
        textFileCreator := txtFileCreator;
    end;

    destructor TCreateFileTask.destroy();
    begin
        inherited destroy();
        textFileCreator := nil;
    end;

    procedure TCreateFileTask.createTextFile(const filename : string; const content : string);
    begin
        textFileCreator.createTextFile(filename, content);
    end;
end.

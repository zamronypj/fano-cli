(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
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
    ContentModifierIntf,
    BaseProjectTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * files using fano web framework
     *
     * TODO: refactor as this is similar with TBaseCreateFileTask
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFileTask = class(TBaseProjectTask)
    private
        textFileCreator : ITextFileCreator;
    protected
        fContentModifier : IContentModifier;
        procedure createTextFile(const filename : string; const content : string);
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier
        );
        destructor destroy(); override;
    end;

implementation

    constructor TCreateFileTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier
    );
    begin
        textFileCreator := txtFileCreator;
        fContentModifier := contentModifier;
    end;

    destructor TCreateFileTask.destroy();
    begin
        textFileCreator := nil;
        fContentModifier := nil;
        inherited destroy();
    end;

    procedure TCreateFileTask.createTextFile(const filename : string; const content : string);
    begin
        textFileCreator.createTextFile(filename, fContentModifier.modify(content));
    end;
end.

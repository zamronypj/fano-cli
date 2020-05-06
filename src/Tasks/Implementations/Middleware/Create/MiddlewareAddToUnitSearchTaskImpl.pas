(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit MiddlewareAddToUnitSearchTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    FileContentReaderIntf,
    FileContentWriterIntf,
    AddToUnitSearchTaskImpl;

type

    (*!--------------------------------------
     * Task that add middleware unit to uses
     * clause of bootstrap application unit
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TMiddlewareAddToUnitSearchTask = class(TAddToUnitSearchTask)
    protected
        function addUnitSearchEntry(
            const filename : string;
            const objectName : string
        ) : ITask; override;
    end;

implementation

uses

    SysUtils,
    Classes,
    RegExpr;

    function TMiddlewareAddToUnitSearchTask.addUnitSearchEntry(
        const filename : string;
        const objectName : string
    ) : ITask;
    var content : string;
        modifiedContent : string;
        unitSearch : string;
        modifiedunitSearch : string;
        baseDir : string;
    begin
        content := fileReader.read(filename);
        unitSearch := getUnitSearchEntry(content);
        if (unitSearch <> '') then
        begin
            //add new unit search entry
            baseDir := '-Fu$USER_APP_DIR$/' + objectType + 's/' + objectName;
            modifiedunitSearch := unitSearch + LineEnding +
                baseDir + LineEnding +
                baseDir + '/Factories' + LineEnding;

            //replace file content with modified content
            modifiedContent := stringReplace(
                content,
                unitSearch,
                modifiedUnitSearch,
                []
            );
            fileWriter.write(filename, modifiedContent);
        end;
        result := self;
    end;
end.

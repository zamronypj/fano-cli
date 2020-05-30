(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit AddToUsesClauseTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    FileContentReaderIntf,
    FileContentWriterIntf;

type

    (*!--------------------------------------
     * Task that add unit to uses
     * clause of bootstrap application unit
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TAddToUsesClauseTask = class(TInterfacedObject, ITask)
    private
        fileReader : IFileContentReader;
        fileWriter : IFileContentWriter;
        //object type = ['View', 'Model', 'Controller']
        objectType : string;

        function getUnitNamesFromUsesClause(const unitContent : string) : string;
    public
        constructor create(
            const fReader : IFileContentReader;
            const fWriter : IFileContentWriter;
            const objType : string
        );

        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils,
    Classes,
    RegExpr;

const

    (*!------------------------------------
     * Regex pattern to get list of unit in
     * uses clause in unit implementation section
     *
     * if we have unit
     *
     * unit unitname;
     * interface
     * ...
     * implementation
     * uses
     *    unitA, unitB, unitC;
     * ...
     * ...
     * end.
     *
     * then this regex pattern to match and get
     * string `unitA, unitB, unitC` (without semicolon)
     * After that we can insert new unit declaration
     * append unit name at last
     *-------------------------------------*)
    UNIT_USES_REGEX_PATTERN = 'implementation\s+uses' +
          '\s+([a-zA-Z0-9,\s\{\*\!\-\\(\)}]+);';


    constructor TAddToUsesClauseTask.create(
        const fReader : IFileContentReader;
        const fWriter : IFileContentWriter;
        const objType : string
    );
    begin
        fileReader := fReader;
        fileWriter := fWriter;
        objectType := objType;
    end;

    destructor TAddToUsesClauseTask.destroy();
    begin
        inherited destroy();
        fileReader := nil;
        fileWriter := nil;
    end;

    function TAddToUsesClauseTask.getUnitNamesFromUsesClause(
        const unitContent : string
    ) : string;
    var regex : TRegExpr;
    begin
        result := '';
        regex := TRegExpr.create(UNIT_USES_REGEX_PATTERN);
        try
            if (regex.exec(unitContent)) then
            begin
                //matched, get subgroup match (i.e., unit names will be in index 1)
                //index 0 will contain whole match
                result := regex.match[1];
            end;
        finally
            regex.free();
        end;
    end;

    function TAddToUsesClauseTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var objectName : string;
        bootstrapUnitContent : string;
        modifiedUnitContent : string;
        usesUnits : string;
        modifiedUsesUnits : string;
    begin
        objectName := opt.getOptionValue(longOpt);
        bootstrapUnitContent := fileReader.read('src/bootstrap.pas');
        usesUnits := getUnitNamesFromUsesClause(bootstrapUnitContent);
        if (usesUnits <> '') then
        begin
            //add new controller factory unit with nicely 4 space format
            modifiedUsesUnits := usesUnits + ',' + LineEnding +
                '    ' + objectName + objectType + 'Factory';
            //replace app/bootstrap.pas with modified content
            modifiedUnitContent := stringReplace(
                bootstrapUnitContent,
                usesUnits,
                modifiedUsesUnits,
                []
            );
            fileWriter.write('src/bootstrap.pas', modifiedUnitContent);
        end;
        result := self;
    end;
end.

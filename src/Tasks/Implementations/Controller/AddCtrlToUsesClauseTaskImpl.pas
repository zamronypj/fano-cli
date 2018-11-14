(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit AddCtrlToUsesClauseTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that add controller unit to uses
     * clause of bootstrap application unit
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TAddCtrlToUsesClauseTask = class(TInterfacedObject, ITask)
    private
        function readFileContent(const unitFilename : string) : string;

        procedure writeFileContent(
            const unitFilename : string;
            const unitContent : string
        );

        function getUnitNamesFromUsesClause(const unitContent : string) : string;
    public
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


    function TAddCtrlToUsesClauseTask.readFileContent(const unitFilename : string) : string;
    var fstream : TFileStream;
        strStream : TStringStream;
    begin
        fstream := TFileStream.create(unitFilename, fmOpenRead);
        strStream := TStringStream.create('');
        try
            strStream.copyfrom(fstream, fstream.size);
            result := strStream.dataString;
        finally
            fstream.free();
            strStream.free();
        end;
    end;

    procedure TAddCtrlToUsesClauseTask.writeFileContent(
        const unitFilename : string;
        const unitContent : string
    );
    var fstream : TFileStream;
        strStream : TStringStream;
    begin
        fstream := TFileStream.create(unitFilename, fmOpenWrite);
        strStream := TStringStream.create(unitContent);
        try
            fstream.copyfrom(strStream, strStream.size);
        finally
            fstream.free();
            strStream.free();
        end;
    end;

    function TAddCtrlToUsesClauseTask.getUnitNamesFromUsesClause(
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

    function TAddCtrlToUsesClauseTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var controllerName : string;
        bootstrapUnitContent : string;
        modifiedUnitContent : string;
        usesUnits : string;
        modifiedUsesUnits : string;
    begin
        controllerName := opt.getOptionValue(longOpt);
        bootstrapUnitContent := readFileContent('app/bootstrap.pas');
        usesUnits := getUnitNamesFromUsesClause(bootstrapUnitContent);
        if (length(usesUnits) > 0) then
        begin
            //add new controller factory unit with nicely 4 space format
            modifiedUsesUnits := usesUnits + ',' + LineEnding +
                '    ' + controllerName + 'ControllerFactory';
            //replace app/bootstrap.pas with modified content
            modifiedUnitContent := stringReplace(
                bootstrapUnitContent,
                usesUnits,
                modifiedUsesUnits,
                []
            );
            writeFileContent('app/bootstrap.pas', modifiedUnitContent);
        end;
        result := self;
    end;
end.

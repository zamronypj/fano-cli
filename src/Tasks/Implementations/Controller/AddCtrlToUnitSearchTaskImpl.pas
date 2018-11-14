(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit AddCtrlToUnitSearchTaskImpl;

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
     * Task that add controller unit to uses
     * clause of bootstrap application unit
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TAddCtrlToUnitSearchTask = class(TInterfacedObject, ITask)
    private
        fileReader : IFileContentReader;
        fileWriter : IFileContentWriter;

        function getUnitSearchEntry(const content : string) : string;
        function addUnitSearchEntry(
            const filename : string;
            const controllerName : string
        ) : ITask;
    public
        constructor create(
            fReader : IFileContentReader;
            fWriter : IFileContentWriter
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
     * Regex pattern to get list of unit search
     * in compiler switches configuration
     *
     * If we have following content in build.cfg
     *
     * #----------------------------------------------
     * # Application Unit search path
     * # USER_APP_DIR is contains user application base directory
     * #----------------------------------------------
     * -Fu$USER_APP_DIR$/Dependencies
     * -Fu$USER_APP_DIR$/Routes
     * -Fu$USER_APP_DIR$/App/Image/Controllers
     * -Fu$USER_APP_DIR$/App/Image/Controllers/Factories
     * #-Fu$USER_APP_DIR$/path/to/other/units
     *
     * then this regex pattern to match and get last string of following
     * `-Fu$USER_APP_DIR$/Dependencies`
     * `-Fu$USER_APP_DIR$/Routes`
     * `-Fu$USER_APP_DIR$/App/Image/Controllers`
     * `-Fu$USER_APP_DIR$/App/Image/Controllers/Factories`
     *
     * After that we can insert new unit search
     * append at last
     *-------------------------------------*)
    UNIT_SEARCH_REGEX_PATTERN = '^-Fu[a-zA-Z0-9\/\$\_]+$';

    constructor TAddCtrlToUnitSearchTask.create(
        fReader : IFileContentReader;
        fWriter : IFileContentWriter
    );
    begin
        fileReader := fReader;
        fileWriter := fWriter;
    end;

    destructor TAddCtrlToUnitSearchTask.destroy();
    begin
        inherited destroy();
        fileReader := nil;
        fileWriter := nil;
    end;

    function TAddCtrlToUnitSearchTask.getUnitSearchEntry(
        const content : string
    ) : string;
    var regex : TRegExpr;
    begin
        result := '';
        regex := TRegExpr.create(UNIT_SEARCH_REGEX_PATTERN);
        try
            //turn on /m modifier so ^..$ is done per line instead of
            //from beginning to end of content
            regex.modifierM := true;
            if (regex.exec(content)) then
            begin
                result := regex.match[0];
                //find last match
                while regex.execNext() do
                begin
                    result := regex.match[0];
                end;
            end;
        finally
            regex.free();
        end;
    end;

    function TAddCtrlToUnitSearchTask.addUnitSearchEntry(
        const filename : string;
        const controllerName : string
    ) : ITask;
    var content : string;
        modifiedContent : string;
        unitSearch : string;
        modifiedunitSearch : string;
        baseDir : string;
    begin
        content := fileReader.read(filename);
        unitSearch := getUnitSearchEntry(content);
        if (length(unitSearch) > 0) then
        begin
            //add new unit search entry
            baseDir := '-Fu$USER_APP_DIR$/App/' + controllerName + '/Controllers';
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

    function TAddCtrlToUnitSearchTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var controllerName : string;
    begin
        controllerName := opt.getOptionValue(longOpt);
        addUnitSearchEntry('build.cfg', controllerName);
        addUnitSearchEntry('build.cfg.sample', controllerName);
        result := self;
    end;
end.

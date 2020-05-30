(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit AddToUnitSearchTaskImpl;

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
    TAddToUnitSearchTask = class(TInterfacedObject, ITask)
    protected
        fileReader : IFileContentReader;
        fileWriter : IFileContentWriter;
        //object type = ['Model', 'View', 'Controller']
        objectType : string;
        function getUnitSearchEntry(const content : string) : string;
        function addUnitSearchEntry(
            const filename : string;
            const objectName : string
        ) : ITask; virtual;
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

    constructor TAddToUnitSearchTask.create(
        const fReader : IFileContentReader;
        const fWriter : IFileContentWriter;
        const objType : string
    );
    begin
        fileReader := fReader;
        fileWriter := fWriter;
        objectType := objType;
    end;

    destructor TAddToUnitSearchTask.destroy();
    begin
        inherited destroy();
        fileReader := nil;
        fileWriter := nil;
    end;

    function TAddToUnitSearchTask.getUnitSearchEntry(
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

    function TAddToUnitSearchTask.addUnitSearchEntry(
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
            baseDir := '-Fu$USER_APP_DIR$/App/' + objectName + '/' + objectType + 's';
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

    function TAddToUnitSearchTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var objectName : string;
    begin
        objectName := opt.getOptionValue(longOpt);
        addUnitSearchEntry('build.cfg', objectName);
        addUnitSearchEntry('build.cfg.sample', objectName);
        result := self;
    end;
end.

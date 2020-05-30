(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DuplicateModelCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DuplicateCheckTaskImpl;

type

    (*!--------------------------------------
     * Task that run other task only if model
     * with same name not already defined
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDuplicateModelCheckTask = class(TDuplicateCheckTask)
    protected
        function getType() : string; override;
        function isDuplicate(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const srcDir : string;
            const objName : string
        ) : boolean; override;
    end;

implementation

uses

    SysUtils;

    function TDuplicateModelCheckTask.getType() : string;
    begin
        result := 'model';
    end;

    function TDuplicateModelCheckTask.isDuplicate(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const srcDir : string;
        const objName : string
    ) : boolean;
    var modelFile : string;
    begin
        modelFile := srcDir + DirectorySeparator + 'App' +
            DirectorySeparator + objName +
            DirectorySeparator + 'Models' +
            DirectorySeparator + objName + 'Model.pas';
        result := fileExists(modelFile);
    end;

end.

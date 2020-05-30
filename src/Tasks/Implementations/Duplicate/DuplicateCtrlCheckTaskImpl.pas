(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DuplicateCtrlCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DuplicateCheckTaskImpl;

type

    (*!--------------------------------------
     * Task that run other task only if controller
     * with same name not already defined
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDuplicateCtrlCheckTask = class(TDuplicateCheckTask)
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

    function TDuplicateCtrlCheckTask.getType() : string;
    begin
        result := 'controller';
    end;

    function TDuplicateCtrlCheckTask.isDuplicate(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const srcDir : string;
        const objName : string
    ) : boolean;
    var ctrlFile : string;
    begin
        ctrlFile := srcDir + DirectorySeparator + 'App' +
            DirectorySeparator + objName +
            DirectorySeparator + 'Controllers' +
            DirectorySeparator + objName + 'Controller.pas';
        result := fileExists(ctrlFile);
    end;

end.

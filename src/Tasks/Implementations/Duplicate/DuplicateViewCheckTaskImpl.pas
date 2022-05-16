(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DuplicateViewCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DuplicateCheckTaskImpl;

type

    (*!--------------------------------------
     * Task that run other task only if view
     * with same name not already defined
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDuplicateViewCheckTask = class(TDuplicateCheckTask)
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

    function TDuplicateViewCheckTask.getType() : string;
    begin
        result := 'view';
    end;

    function TDuplicateViewCheckTask.isDuplicate(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const srcDir : string;
        const objName : string
    ) : boolean;
    var viewFile : string;
    begin
        viewFile := srcDir + DirectorySeparator + 'App' +
            DirectorySeparator + objName +
            DirectorySeparator + 'Views' +
            DirectorySeparator + objName + 'View.pas';
        result := fileExists(viewFile);
    end;

end.

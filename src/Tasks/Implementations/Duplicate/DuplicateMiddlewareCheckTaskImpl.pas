(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DuplicateMiddlewareCheckTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DuplicateCheckTaskImpl;

type

    (*!--------------------------------------
     * Task that run other task only if middleware
     * with same name not already defined
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDuplicateMiddlewareCheckTask = class(TDuplicateCheckTask)
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

    function TDuplicateMiddlewareCheckTask.getType() : string;
    begin
        result := 'middleware';
    end;

    function TDuplicateMiddlewareCheckTask.isDuplicate(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const srcDir : string;
        const objName : string
    ) : boolean;
    var mwFile : string;
    begin
        mwFile := srcDir + DirectorySeparator + 'Middlewares' +
            DirectorySeparator + objName +
            DirectorySeparator + objName + 'Middleware.pas';
        result := fileExists(mwFile);
    end;

end.

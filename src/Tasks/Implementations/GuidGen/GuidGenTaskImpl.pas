(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit GuidGenTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    SysUtils;

type

    (*!--------------------------------------
     * Task that generate GUID
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TGuidGenTask = class(TInterfacedObject, ITask)
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

    function TGuidGenTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var guid : TGUID;
    begin
        createGUID(guid);
        write(GuidToString(guid));
        result := self;
    end;
end.

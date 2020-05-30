(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit JsMinifierTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for JavaScript minifier task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TJsMinifierTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    NullTaskImpl,
    JsMinifierTaskImpl,
    JsMinifyFileTaskImpl,
    JsMinifyDirTaskImpl;

    function TJsMinifierTaskFactory.build() : ITask;
    begin
        result := TJsMinifierTask.create(
            TJsMinifyFileTask.create(),
            TJsMinifyDirTask.create()
        );
    end;

end.

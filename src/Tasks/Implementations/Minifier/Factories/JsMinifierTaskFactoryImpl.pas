(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
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
    DirFileMinifierTaskImpl,
    JsMinifierImpl,
    FileHelperImpl,
    MinifyFileTaskImpl,
    MinifyDirTaskImpl;

    function TJsMinifierTaskFactory.build() : ITask;
    begin
        result := TDirFileMinifierTask.create(
            TMinifyFileTask.create(
                TJsMinifier.create(),
                TFileHelper.create()
            ),
            TMinifyDirTask.create(
                TJsMinifier.create(),
                TFileHelper.create()
            )
        );
    end;

end.

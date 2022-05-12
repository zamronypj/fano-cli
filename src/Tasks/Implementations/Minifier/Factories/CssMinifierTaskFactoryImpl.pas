(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CssMinifierTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for CSS minifier task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCssMinifierTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    NullTaskImpl,
    DirFileMinifierTaskImpl,
    CssMinifierImpl,
    FileHelperImpl,
    MinifyFileTaskImpl,
    MinifyDirTaskImpl;

    function TCssMinifierTaskFactory.build() : ITask;
    begin
        result := TDirFileMinifierTask.create(
            TMinifyFileTask.create(
                TCssMinifier.create(),
                TFileHelper.create()
            ),
            TMinifyDirTask.create(
                TCssMinifier.create(),
                TFileHelper.create()
            )
        );
    end;

end.

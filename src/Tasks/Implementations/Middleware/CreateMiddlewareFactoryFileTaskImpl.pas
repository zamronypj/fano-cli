(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMiddlewareFactoryFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that scaffolding middleware factory
     * class file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMiddlewareFactoryFileTask = class(TBaseCreateFileTask)
    private
        procedure createMiddlewareFactoryFile(
            const dir :string;
            const ctrlName : string
        );
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    SysUtils;

    procedure TCreateMiddlewareFactoryFileTask.createMiddlewareFactoryFile(
        const dir :string;
        const ctrlName : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Middleware/Includes/middleware.factory.pas.inc}
    begin
        createTextFile(
            dir + DirectorySeparator + ctrlName +'MiddlewareFactory.pas',
            format(
                strMiddlewareFactoryPasInc,
                [ ctrlName, ctrlName, ctrlName, ctrlName, ctrlName, ctrlName ]
            )
        );
    end;

    function TCreateMiddlewareFactoryFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var middlewareName : string;
        baseDir : string;
    begin
        inherited run(opt, longOpt);
        middlewareName := opt.getOptionValue(longOpt);
        baseDir := ExtractFileDir(baseDirectory) + DirectorySeparator +
            'Middlewares' + DirectorySeparator + middlewareName +
            DirectorySeparator + 'Factories';
        createDirIfNotExists(baseDir);
        createMiddlewareFactoryFile(baseDir, middlewareName);
        result := self;
    end;
end.

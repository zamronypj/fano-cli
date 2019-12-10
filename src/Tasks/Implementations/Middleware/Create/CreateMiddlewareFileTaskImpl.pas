(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMiddlewareFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that scaffolding middleware class
     * file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMiddlewareFileTask = class(TBaseCreateFileTask)
    private
        procedure createMiddlewareFile(
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

    procedure TCreateMiddlewareFileTask.createMiddlewareFile(
        const dir :string;
        const ctrlName : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Middleware/Includes/middleware.pas.inc}
    begin
        createTextFile(
            dir + DirectorySeparator + ctrlName + 'Middleware.pas',
            format(
                strMiddlewarePasInc,
                [ ctrlName, ctrlName, ctrlName, ctrlName ]
            )
        );
    end;

    function TCreateMiddlewareFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var middlewareName : string;
        baseDir : string;
    begin
        inherited run(opt, longOpt);
        middlewareName := opt.getOptionValue(longOpt);
        baseDir := ExtractFileDir(baseDirectory) + DirectorySeparator + 'Middlewares';
        createDirIfNotExists(baseDir);
        baseDir := baseDir + DirectorySeparator + middlewareName;
        createDirIfNotExists(baseDir);
        createMiddlewareFile(baseDir, middlewareName);
        result := self;
    end;
end.

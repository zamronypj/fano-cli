(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateViewFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that scaffolding view class
     * file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateViewFileTask = class(TBaseCreateFileTask)
    private
        procedure createViewFile(
            const dir :string;
            const viewName : string
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

    procedure TCreateViewFileTask.createViewFile(
        const dir :string;
        const viewName : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/View/Includes/view.pas.inc}
    begin
        createTextFile(
            dir + DirectorySeparator + viewName + 'View.pas',
            format(
                strViewPasInc,
                [ viewName, viewName, viewName ]
            )
        );
    end;

    function TCreateViewFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var viewName : string;
        baseDir : string;
    begin
        viewName := opt.getOptionValue(longOpt);
        baseDir := baseDirectory + DirectorySeparator + viewName;
        createDirIfNotExists(baseDir);
        baseDir := baseDir + DirectorySeparator + 'Views';
        createDirIfNotExists(baseDir);
        createViewFile(baseDir, viewName);
        result := self;
    end;
end.

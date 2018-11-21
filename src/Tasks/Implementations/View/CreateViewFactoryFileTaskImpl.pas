(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateViewFactoryFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that scaffolding view factory
     * class file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateViewFactoryFileTask = class(TBaseCreateFileTask)
    private
        procedure createViewFactoryFile(
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

    procedure TCreateViewFactoryFileTask.createViewFactoryFile(
        const dir :string;
        const viewName : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/View/Includes/view.factory.pas.inc}
    begin
        createTextFile(
            dir + DirectorySeparator + viewName +'ViewFactory.pas',
            format(
                strViewFactoryPasInc,
                [ viewName, viewName, viewName, viewName, viewName, viewName ]
            )
        );
    end;

    function TCreateViewFactoryFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var viewName : string;
        baseDir : string;
    begin
        viewName := opt.getOptionValue(longOpt);
        baseDir := baseDirectory + DirectorySeparator +
            viewName + DirectorySeparator + 'Views' +
            DirectorySeparator + 'Factories';
        createDirIfNotExists(baseDir);
        createViewFactoryFile(baseDir, viewName);
        result := self;
    end;
end.

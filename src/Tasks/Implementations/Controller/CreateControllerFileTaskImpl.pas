(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateControllerFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that scaffolding controller class
     * file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateControllerFileTask = class(TBaseCreateFileTask)
    private
        procedure createControllerFile(
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

    procedure TCreateControllerFileTask.createControllerFile(
        const dir :string;
        const ctrlName : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Controller/Includes/rest.controller.pas.inc}
    begin
        createTextFile(
            dir + DirectorySeparator + ctrlName + 'Controller.pas',
            format(
                strRestControllerPasInc,
                [ ctrlName, lowerCase(ctrlName), ctrlName, ctrlName, ctrlName ]
            )
        );
    end;

    function TCreateControllerFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var controllerName : string;
        baseDir : string;
    begin
        controllerName := opt.getOptionValue(longOpt);
        baseDir := baseDirectory + DirectorySeparator + controllerName;
        createDirIfNotExists(baseDir);
        baseDir := baseDir + DirectorySeparator + 'Controllers';
        createDirIfNotExists(baseDir);
        createControllerFile(baseDir, controllerName);
        result := self;
    end;
end.

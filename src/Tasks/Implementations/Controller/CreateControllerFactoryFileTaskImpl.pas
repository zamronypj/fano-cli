(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateControllerFactoryFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that scaffolding controller factory
     * class file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateControllerFactoryFileTask = class(TBaseCreateFileTask)
    private
        procedure createControllerFactoryFile(
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

    procedure TCreateControllerFactoryFileTask.createControllerFactoryFile(
        const dir :string;
        const ctrlName : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Controller/Includes/rest.controller.factory.pas.inc}
    begin
        createTextFile(
            dir + DirectorySeparator + ctrlName +'ControllerFactory.pas',
            format(
                strRestControllerFactoryPasInc,
                [ ctrlName, ctrlName, ctrlName, ctrlName, ctrlName, ctrlName ]
            )
        );
    end;

    function TCreateControllerFactoryFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var controllerName : string;
        baseDir : string;
    begin
        inherited run(opt, longOpt);
        controllerName := opt.getOptionValue(longOpt);
        baseDir := baseDirectory + DirectorySeparator +
            controllerName + DirectorySeparator + 'Controllers' +
            DirectorySeparator + 'Factories';
        createDirIfNotExists(baseDir);
        createControllerFactoryFile(baseDir, controllerName);
        result := self;
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateModelFactoryFileTaskImpl;

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
    TCreateModelFactoryFileTask = class(TBaseCreateFileTask)
    private
        procedure createModelFactoryFile(
            const dir :string;
            const modelName : string
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

    procedure TCreateModelFactoryFileTask.createModelFactoryFile(
        const dir :string;
        const modelName : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Model/Includes/model.factory.pas.inc}
    begin
        createTextFile(
            dir + DirectorySeparator + modelName +'ModelFactory.pas',
            format(
                strModelFactoryPasInc,
                [ modelName, modelName, modelName, modelName, modelName, modelName ]
            )
        );
    end;

    function TCreateModelFactoryFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var modelName : string;
        baseDir : string;
    begin
        inherited run(opt, longOpt);
        modelName := opt.getOptionValue(longOpt);
        baseDir := baseDirectory + DirectorySeparator +
            modelName + DirectorySeparator + 'Models' +
            DirectorySeparator + 'Factories';
        createDirIfNotExists(baseDir);
        createModelFactoryFile(baseDir, modelName);
        result := self;
    end;
end.

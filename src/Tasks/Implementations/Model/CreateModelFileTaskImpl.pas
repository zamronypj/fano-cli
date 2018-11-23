(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateModelFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that scaffolding model class
     * file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateModelFileTask = class(TBaseCreateFileTask)
    private
        procedure createModelFile(
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

    procedure TCreateModelFileTask.createModelFile(
        const dir :string;
        const modelName : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Model/Includes/model.pas.inc}
    begin
        createTextFile(
            dir + DirectorySeparator + modelName + 'Model.pas',
            format(
                strModelPasInc,
                [
                    modelName,
                    modelName,
                    modelName,
                    modelName,
                    modelName,
                    lowerCase(modelName),
                    modelName,
                    modelName,
                    modelName,
                    modelName,
                    modelName
                ]
            )
        );
    end;

    function TCreateModelFileTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var modelName : string;
        baseDir : string;
    begin
        inherited run(opt, longOpt);
        modelName := opt.getOptionValue(longOpt);
        baseDir := baseDirectory + DirectorySeparator + modelName;
        createDirIfNotExists(baseDir);
        baseDir := baseDir + DirectorySeparator + 'Models';
        createDirIfNotExists(baseDir);
        createModelFile(baseDir, modelName);
        result := self;
    end;
end.

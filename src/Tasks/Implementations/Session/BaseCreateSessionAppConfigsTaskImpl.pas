(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseCreateSessionAppConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    KeyGeneratorIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * base task that create web application config files
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseCreateSessionAppConfigsTask = class(TCreateFileTask)
    protected
        fKeyGenerator : IKeyGenerator;
        procedure createAppConfigs(
            const baseDir : string;
            const configDir : string
        ); virtual; abstract;
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier;
            const keyGen : IKeyGenerator
        );
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    constructor TBaseCreateSessionAppConfigsTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const keyGen : IKeyGenerator
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fKeyGenerator := keyGen;
    end;

    destructor TBaseCreateSessionAppConfigsTask.destroy();
    begin
        fKeyGenerator := nil;
        inherited destroy();
    end;

    function TBaseCreateSessionAppConfigsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createAppConfigs(baseDirectory, baseDirectory + '/config');
        result := self;
    end;
end.

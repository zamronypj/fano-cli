(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateIndyCompilerConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorCreateCompilerConfigsTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * compiler config files and enable conditional
     * define -DUSE_INDY if current command is
     * --project-indy
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateIndyCompilerConfigsTask = class(TDecoratorCreateCompilerConfigsTask)
    protected
        function doCompilerConfigs(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    SysUtils;

    function TCreateIndyCompilerConfigsTask.doCompilerConfigs(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        if (longOpt = 'project-indy') then
        begin
            fWriter.write(
                baseDirectory + '/defines.cfg',
                StringReplace(
                    fReader.read(baseDirectory + '/defines.cfg'),
                    '#-dUSE_INDY',
                    '-dUSE_INDY',
                    [rfReplaceAll]
                )
            );
            fWriter.write(
                baseDirectory + '/defines.cfg.sample',
                StringReplace(
                    fReader.read(baseDirectory + '/defines.cfg.sample'),
                    '#-dUSE_INDY',
                    '-dUSE_INDY',
                    [rfReplaceAll]
                )
            );

            //Indy library causing some warnings during compilation so we need
            //to make it stop compilation only on error with -Se rather than -Sew
            fWriter.write(
                baseDirectory + '/build.dev.cfg',
                StringReplace(
                    fReader.read(baseDirectory + '/build.dev.cfg'),
                    '-Sew',
                    '-Se',
                    [rfReplaceAll]
                )
            );
            fWriter.write(
                baseDirectory + '/build.dev.cfg.sample',
                StringReplace(
                    fReader.read(baseDirectory + '/build.dev.cfg.sample'),
                    '-Sew',
                    '-Se',
                    [rfReplaceAll]
                )
            );
        end;
        result := self;
    end;
end.

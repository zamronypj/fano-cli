(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDaemonProjectTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf,
    CreateProjectTaskFactoryImpl;

type

    (*!--------------------------------------
     * Factory class for create daemon project task
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateDaemonProjectTaskFactory = class(TCreateProjectTaskFactory)
    public
        constructor create(
            const depFactory : ITaskFactory;
            const bootstrapFactory : ITaskFactory;
            const execOutputDir : string = 'bin'
        );
    end;

implementation

    constructor TCreateDaemonProjectTaskFactory.create(
        const depFactory : ITaskFactory;
        const bootstrapFactory : ITaskFactory;
        const execOutputDir : string = 'bin'
    );
    begin
        inherited create(depFactory, bootstrapFactory, execOutputDir);
    end;
end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateProjectTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf;

type

    (*!--------------------------------------
     * Task that create web application project
     * directory structure using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateProjectTask = class(TInterfacedObject, ITask)
    public
        function run() : ITask;
    end;

implementation

    function TCreateProjectTask.run() : ITask;
    begin
        writeln('Start creating project.');
        writeln('Creating directories structures..');
        //TODO: create directories structures
        writeln('Creating shell scripts..');
        //TODO: create shell scripts
        writeln('Creating application compiler config..');
        //TODO: create application compiler config
        writeln('Creating application bootstrap..');
        //TODO: create application bootstrap file
        writeln('Finish creating project.');
        result := self;
    end;
end.

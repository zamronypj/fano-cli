(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit KeyGenTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    KeyGeneratorIntf;

type

    (*!--------------------------------------
     * Task that generate random key
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TKeyGenTask = class(TInterfacedObject, ITask)
    private
        fKeyGenerator : IKeyGenerator;
    public
        constructor create(const keyGen : IKeyGenerator);
        destructor destroy(); override;
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils;

    constructor TKeyGenTask.create(const keyGen : IKeyGenerator);
    begin
        fKeyGenerator := keyGen;
    end;

    destructor TKeyGenTask.destroy();
    begin
        fKeyGenerator := nil;
        inherited destroy();
    end;


    function TKeyGenTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var numberOfBytes : integer;
    begin
        numberOfBytes := strToInt(opt.getOptionValueDef(longOpt, '64'));
        write(fKeyGenerator.generate(numberOfBytes));
        result := self;
    end;
end.

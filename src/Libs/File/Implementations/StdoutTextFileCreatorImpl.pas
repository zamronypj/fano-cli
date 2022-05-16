(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit StdoutTextFileCreatorImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TextFileCreatorIntf;

type

    (*!--------------------------------------
     * ITextFileCreator class that just output content to
     * standard output instead of write to file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TStdoutTextFileCreator = class(TInterfacedObject, ITextFileCreator)
    public
        procedure createTextFile(const filename : string; const content : string);
    end;

implementation

    procedure TStdoutTextFileCreator.createTextFile(const filename : string; const content : string);
    begin
        write(content);
    end;
end.

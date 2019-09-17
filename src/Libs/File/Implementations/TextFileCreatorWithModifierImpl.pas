(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit TextFileCreatorWithModifierImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TextFileCreatorIntf,
    ContentModifierIntf;

type

    (*!--------------------------------------
     * Helper class that create text file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TTextFileCreatorWithModifier = class(TTextFileCreator)
    private
        fContentModifier : IContentModifier;
    protected
        function modifyContent(const content : string) : string; override;
    public
        constructor create(const modifier : IContentModifier);
        destructor destroy(); override
    end;

implementation

uses

    sysutils,
    classes;

    function TTextFileCreatorWithModifier.modifyContent(const content : string) : string;
    begin
        result := fContentModifier.modify(content);
    end;

    constructor TTextFileCreatorWithModifier.create(const modifier : IContentModifier);
    begin
        fContentModifier := modifier;
    end;

    destructor TTextFileCreatorWithModifier.destroy();
    begin
        fContentModifier := nil;
        inherited destroy();
    end;

end.

(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ContentModifierIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to modify content
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IContentModifier = interface
        ['{3D2E1028-D84A-418B-A0BB-B8349CEB7892}']

        (*!------------------------------------------
         * set variable name and its value
         *-------------------------------------------
         * @param varName name of variable
         * @param varValue value to replace
         * @return current instance
         *-------------------------------------------*)
        function setVar(const varName : string; const varValue : string) : IContentModifier;

        (*!------------------------------------------
         * Modify content
         *-------------------------------------------
         * @param content original content to modify
         * @return modified content
         *-------------------------------------------*)
        function modify(const content : string) : string;
    end;

implementation

end.

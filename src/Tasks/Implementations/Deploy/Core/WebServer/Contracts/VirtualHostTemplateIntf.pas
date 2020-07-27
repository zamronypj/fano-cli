(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit VirtualHostTemplateIntf;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    ContentModifierIntf;

type

    (*!--------------------------------------
     * interface for any class having capability
     * to query web virtual host template configuration
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IVirtualHostTemplate = interface
        ['{F809C8E0-A14F-41BA-8012-660D2992B87B}']
        function getVhostTemplate(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const cntModifier : IContentModifier
        ) : string;
    end;

implementation

end.

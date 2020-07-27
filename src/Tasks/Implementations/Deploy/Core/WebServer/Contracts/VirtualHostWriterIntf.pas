(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit VirtualHostWriterIntf;

interface

{$MODE OBJFPC}
{$H+}

uses

    ContentModifierIntf;

type

    (*!--------------------------------------
     * interface for any class having capability
     * to write web virtual host configuration
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IVirtualHostWriter = interface
        ['{452E15EC-5647-4D84-BFE3-77F47F8EFBF6}']
        procedure writeVhost(
            const serverName : string;
            const vhostTpl : string;
            const cntModifier : IContentModifier
        );
    end;

implementation

end.

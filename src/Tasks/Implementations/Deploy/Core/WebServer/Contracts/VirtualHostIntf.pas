(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit VirtualHostIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    (*!--------------------------------------
     * interface for any class having capability
     * to query web virtual host configuration
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IVirtualHost = interface
        ['{DA492850-C0B3-483F-A2A3-419C50170033}']
        function getServerName(const opt : ITaskOptions; const longOpt : shortstring) : string;
        function getDocumentRoot(const opt : ITaskOptions; const longOpt : shortstring) : string;
        function getHost(const opt : ITaskOptions; const longOpt : shortstring) : string;
        function getPort(const opt : ITaskOptions; const longOpt : shortstring) : string;
    end;

implementation

end.

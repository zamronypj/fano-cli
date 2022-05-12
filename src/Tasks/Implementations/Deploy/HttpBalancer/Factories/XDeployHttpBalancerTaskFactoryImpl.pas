(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit XDeployHttpBalancerTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    XDeployBalancerTaskFactoryImpl;

type

    (*!--------------------------------------
     * Factory class for deploy http web application with
     * reverse proxy load balancer
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TXDeployHttpBalancerTaskFactory = class(TXDeployBalancerTaskFactory)
    protected
        function getProtocol() : shortstring; override;
        function getProxyPass() : shortstring; override;
        function getProxyParams() : shortstring; override;
        function getServerPrefix() : shortstring; override;
    end;

implementation


    function TXDeployHttpBalancerTaskFactory.getProtocol() : shortstring;
    begin
        result := 'http';
    end;

    function TXDeployHttpBalancerTaskFactory.getProxyPass() : shortstring;
    begin
        result := 'proxy_pass';
    end;

    function TXDeployHttpBalancerTaskFactory.getProxyParams() : shortstring;
    begin
        result := '';
    end;

    function TXDeployHttpBalancerTaskFactory.getServerPrefix() : shortstring;
    begin
        result := 'http://';
    end;
end.

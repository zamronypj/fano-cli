(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DeployHttpBalancerTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    DeployBalancerTaskFactoryImpl;

type

    (*!--------------------------------------
     * Factory class for deploy http web application with
     * reverse proxy load balancer
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDeployHttpBalancerTaskFactory = class(TDeployBalancerTaskFactory)
    protected
        function getProtocol() : shortstring; override;
        function getProxyPass() : shortstring; override;
        function getProxyParams() : shortstring; override;
        function getServerPrefix() : shortstring; override;
    end;

implementation


    function TDeployHttpBalancerTaskFactory.getProtocol() : shortstring;
    begin
        result := 'http';
    end;

    function TDeployHttpBalancerTaskFactory.getProxyPass() : shortstring;
    begin
        result := 'proxy_pass';
    end;

    function TDeployHttpBalancerTaskFactory.getProxyParams() : shortstring;
    begin
        result := '';
    end;

    function TDeployHttpBalancerTaskFactory.getServerPrefix() : shortstring;
    begin
        result := 'http://';
    end;
end.

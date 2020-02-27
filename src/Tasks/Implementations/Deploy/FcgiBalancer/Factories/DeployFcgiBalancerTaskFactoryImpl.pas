(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DeployFcgiBalancerTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    DeployBalancerTaskFactoryImpl;

type

    (*!--------------------------------------
     * Factory class for deploy FastCGI web application with
     * reverse proxy load balancer
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDeployFcgiBalancerTaskFactory = class(TDeployBalancerTaskFactory)
    protected
        function getProtocol() : shortstring; override;
        function getProxyPass() : shortstring; override;
        function getProxyParams() : shortstring; override;
    end;

implementation


    function TDeployFcgiBalancerTaskFactory.getProtocol() : shortstring;
    begin
        result := 'fcgi';
    end;

    function TDeployFcgiBalancerTaskFactory.getProxyPass() : shortstring;
    begin
        //this will be used by nginx
        result := 'fastcgi_pass';
    end;

    function TDeployFcgiBalancerTaskFactory.getProxyParams() : shortstring;
    begin
        //this will be used by nginx
        result := 'include fastcgi_params;';
    end;
end.

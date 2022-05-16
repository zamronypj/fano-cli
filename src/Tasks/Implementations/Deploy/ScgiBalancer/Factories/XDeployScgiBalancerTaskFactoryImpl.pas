(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit XDeployScgiBalancerTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    XDeployBalancerTaskFactoryImpl;

type

    (*!--------------------------------------
     * Factory class for deploy SCGI web application with
     * reverse proxy load balancer
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TXDeployScgiBalancerTaskFactory = class(TXDeployBalancerTaskFactory)
    protected
        function getProtocol() : shortstring; override;
        function getProxyPass() : shortstring; override;
        function getProxyParams() : shortstring; override;
    end;

implementation


    function TXDeployScgiBalancerTaskFactory.getProtocol() : shortstring;
    begin
        result := 'scgi';
    end;

    function TXDeployScgiBalancerTaskFactory.getProxyPass() : shortstring;
    begin
        //this will be used by nginx
        result := 'scgi_pass';
    end;

    function TXDeployScgiBalancerTaskFactory.getProxyParams() : shortstring;
    begin
        //this will be used by nginx
        result := 'include scgi_params;';
    end;

end.

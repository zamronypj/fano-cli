(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DeployUwsgiBalancerTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    DeployBalancerTaskFactoryImpl;

type

    (*!--------------------------------------
     * Factory class for deploy uwsgi web application with
     * reverse proxy load balancer
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDeployUwsgiBalancerTaskFactory = class(TDeployBalancerTaskFactory)
    protected
        function getProtocol() : shortstring; override;
    end;

implementation


    function TDeployUwsgiBalancerTaskFactory.getProtocol() : shortstring;
    begin
        result := 'uwsgi';
    end;

end.

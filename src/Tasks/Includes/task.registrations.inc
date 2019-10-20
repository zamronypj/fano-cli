(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%fanocli.pas}

{$INCLUDE Info/task.registrations.inc}
{$INCLUDE Project/task.registrations.inc}
{$INCLUDE ProjectCgi/task.registrations.inc}
{$INCLUDE ProjectFastCgi/task.registrations.inc}
{$INCLUDE ProjectScgi/task.registrations.inc}
{$INCLUDE ProjectUwsgi/task.registrations.inc}
{$INCLUDE ProjectFcgid/task.registrations.inc}
{$INCLUDE ProjectNoGit/task.registrations.inc}
{$INCLUDE ProjectNoCommit/task.registrations.inc}
{$INCLUDE Controller/task.registrations.inc}
{$INCLUDE View/task.registrations.inc}
{$INCLUDE Model/task.registrations.inc}
{$INCLUDE Mvc/task.registrations.inc}
{$INCLUDE Middleware/task.registrations.inc}
{$INCLUDE DeployScgi/task.registrations.inc}
{$INCLUDE DeployCgi/task.registrations.inc}
{$INCLUDE DeployFcgi/task.registrations.inc}
{$INCLUDE DeployUwsgi/task.registrations.inc}
{$INCLUDE DeployFcgid/task.registrations.inc}
{$INCLUDE DeployScgiBalancer/task.registrations.inc}
{$INCLUDE DeployFcgiBalancer/task.registrations.inc}
{$INCLUDE DeployUwsgiBalancer/task.registrations.inc}

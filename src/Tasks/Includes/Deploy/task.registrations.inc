(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%fanocli.pas}

{$INCLUDE Scgi/task.registrations.inc}
{$INCLUDE Cgi/task.registrations.inc}
{$INCLUDE Fcgi/task.registrations.inc}
{$INCLUDE Uwsgi/task.registrations.inc}
{$INCLUDE Fcgid/task.registrations.inc}
{$INCLUDE Http/task.registrations.inc}
{$INCLUDE ScgiBalancer/task.registrations.inc}
{$INCLUDE FcgiBalancer/task.registrations.inc}
{$INCLUDE UwsgiBalancer/task.registrations.inc}
{$INCLUDE HttpBalancer/task.registrations.inc}

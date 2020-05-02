(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strDependenciesInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    '' + LineEnding +
    '{$INCLUDE main.dependencies.inc}' + LineEnding +
    '{$INCLUDE middlewares.dependencies.inc}' + LineEnding +
    '{$INCLUDE models.dependencies.inc}' + LineEnding +
    '{$INCLUDE views.dependencies.inc}' + LineEnding +
    '{$INCLUDE controllers.dependencies.inc}' + LineEnding +
    '';

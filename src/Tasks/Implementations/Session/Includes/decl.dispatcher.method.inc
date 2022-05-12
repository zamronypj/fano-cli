(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strDeclDispatcherMethod : string =
    '        function buildDispatcher(' + LineEnding +
    '            const container : IDependencyContainer;' + LineEnding +
    '            const routeMatcher : IRouteMatcher;' + LineEnding +
    '            const config : IAppConfiguration' + LineEnding +
    '        ) : IDispatcher; override;' + LineEnding;

strAppConfigDependenciesInc: string =
(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
    '        container.add(' + LineEnding +
    '            ''config'',' + LineEnding +
    '            [[FACTORY_CLASS]].create(' + LineEnding +
    '                [[BASE_DIR]] + ''[[APP_CONFIG_FILE]]''' + LineEnding +
    '            )' + LineEnding +
    '        );' + LineEnding +
    '        result := container[''config''] as IAppConfiguration;' + LineEnding;

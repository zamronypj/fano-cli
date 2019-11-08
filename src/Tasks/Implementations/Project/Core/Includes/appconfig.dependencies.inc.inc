strAppConfigDependenciesInc: string =
    '(*!------------------------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    ' *------------------------------------------------------------- *)' + LineEnding +
    '' + LineEnding +
    'container.add(' + LineEnding +
    '    ''config'',' + LineEnding +
    '    [[FACTORY_CLASS]].create(' + LineEnding +
    '        [[BASE_DIR]] + ''[[APP_CONFIG_FILE]]''' + LineEnding +
    '    )' + LineEnding +
    ');' + LineEnding +
    '';

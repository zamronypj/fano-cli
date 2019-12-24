strAppConfigDependenciesInc: string =
    '        container.add(' + LineEnding +
    '            ''config'',' + LineEnding +
    '            [[FACTORY_CLASS]].create(' + LineEnding +
    '                [[BASE_DIR]] + ''[[APP_CONFIG_FILE]]''' + LineEnding +
    '            )' + LineEnding +
    '        );' + LineEnding +
    '        result := container[''config''] as IAppConfiguration;' + LineEnding;

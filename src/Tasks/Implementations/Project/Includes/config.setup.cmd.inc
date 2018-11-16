strConfigSetupCmd: string =
    'REM------------------------------------------------------------' + LineEnding +
    'REM [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    'REM' + LineEnding +
    'REM @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    'REM @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    'REM @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    'REM-------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    'REM Scripts to setup configuration files' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'copy src\config\config.json.sample src\config\config.json' + LineEnding +
    'copy build.prod.cfg.sample build.prod.cfg' + LineEnding +
    'copy build.dev.cfg.sample build.dev.cfg' + LineEnding +
    'copy build.cfg.sample build.cfg';

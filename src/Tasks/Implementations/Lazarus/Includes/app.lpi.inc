strAppLpi : string =
    '<!--------------------------------------------' + LineEnding +
    ' * [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    ' *' + LineEnding +
    ' * @link [[APP_REPOSITORY_URL]]' + LineEnding +
    ' * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    ' * @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '---------------------------------------------->' + LineEnding +
    '<?xml version="1.0" encoding="UTF-8"?>' + LineEnding +
    '<CONFIG>' + LineEnding +
    '  <ProjectOptions>' + LineEnding +
    '    <Version Value="12"/>' + LineEnding +
    '    <General>' + LineEnding +
    '      <SessionStorage Value="InProjectDir"/>' + LineEnding +
    '      <Title Value="project1"/>' + LineEnding +
    '    </General>' + LineEnding +
    '    <BuildModes>' + LineEnding +
    '      <Item Name="Default" Default="True"/>' + LineEnding +
    '    </BuildModes>' + LineEnding +
    '    <PublishOptions>' + LineEnding +
    '      <Version Value="2"/>' + LineEnding +
    '      <UseFileFilters Value="True"/>' + LineEnding +
    '    </PublishOptions>' + LineEnding +
    '    <RunParams>' + LineEnding +
    '      <FormatVersion Value="2"/>' + LineEnding +
    '    </RunParams>' + LineEnding +
    '    <Units>' + LineEnding +
    '      <Unit>' + LineEnding +
    '        <Filename Value="src/app.pas"/>' + LineEnding +
    '        <IsPartOfProject Value="True"/>' + LineEnding +
    '      </Unit>' + LineEnding +
    '      <Unit>' + LineEnding +
    '        <Filename Value="src/bootstrap.pas"/>' + LineEnding +
    '        <IsPartOfProject Value="True"/>' + LineEnding +
    '      </Unit>' + LineEnding +
    '      <Unit>' + LineEnding +
    '        <Filename Value="src/Dependencies/controllers.inc"/>' + LineEnding +
    '        <IsPartOfProject Value="True"/>' + LineEnding +
    '      </Unit>' + LineEnding +
    '      <Unit>' + LineEnding +
    '        <Filename Value="src/Dependencies/views.inc"/>' + LineEnding +
    '        <IsPartOfProject Value="True"/>' + LineEnding +
    '      </Unit>' + LineEnding +
    '      <Unit>' + LineEnding +
    '        <Filename Value="src/Dependencies/models.inc"/>' + LineEnding +
    '        <IsPartOfProject Value="True"/>' + LineEnding +
    '      </Unit>' + LineEnding +
    '      <Unit>' + LineEnding +
    '        <Filename Value="src/Dependencies/middlewares.inc"/>' + LineEnding +
    '        <IsPartOfProject Value="True"/>' + LineEnding +
    '      </Unit>' + LineEnding +
    '      <Unit>' + LineEnding +
    '        <Filename Value="src/Dependencies/main.inc"/>' + LineEnding +
    '        <IsPartOfProject Value="True"/>' + LineEnding +
    '      </Unit>' + LineEnding +
    '      <Unit>' + LineEnding +
    '        <Filename Value="src/Dependencies/dependencies.inc"/>' + LineEnding +
    '        <IsPartOfProject Value="True"/>' + LineEnding +
    '      </Unit>' + LineEnding +
    '    </Units>' + LineEnding +
    '  </ProjectOptions>' + LineEnding +
    '  <CompilerOptions>' + LineEnding +
    '    <Version Value="11"/>' + LineEnding +
    '    <Target>' + LineEnding +
    '      <Filename Value="src/app.pas"/>' + LineEnding +
    '    </Target>' + LineEnding +
    '    <SearchPaths>' + LineEnding +
    '      <IncludeFiles Value="$(ProjOutDir)"/>' + LineEnding +
    '      <UnitOutputDirectory Value="lib/$(TargetCPU)-$(TargetOS)"/>' + LineEnding +
    '    </SearchPaths>' + LineEnding +
    '    <Linking>' + LineEnding +
    '      <Debugging>' + LineEnding +
    '        <DebugInfoType Value="dsDwarf2"/>' + LineEnding +
    '      </Debugging>' + LineEnding +
    '    </Linking>' + LineEnding +
    '    <Other>' + LineEnding +
    '      <ConfigFile>' + LineEnding +
    '        <CustomConfigFile Value="True"/>' + LineEnding +
    '        <ConfigFilePath Value="build.cfg"/>' + LineEnding +
    '      </ConfigFile>' + LineEnding +
    '    </Other>' + LineEnding +
    '  </CompilerOptions>' + LineEnding +
    '  <Debugging>' + LineEnding +
    '    <Exceptions>' + LineEnding +
    '      <Item>' + LineEnding +
    '        <Name Value="EAbort"/>' + LineEnding +
    '      </Item>' + LineEnding +
    '      <Item>' + LineEnding +
    '        <Name Value="ECodetoolError"/>' + LineEnding +
    '      </Item>' + LineEnding +
    '      <Item>' + LineEnding +
    '        <Name Value="EFOpenError"/>' + LineEnding +
    '      </Item>' + LineEnding +
    '    </Exceptions>' + LineEnding +
    '  </Debugging>' + LineEnding +
    '</CONFIG>';

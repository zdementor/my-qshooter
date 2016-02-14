
require "Helper"

----------------------------------------------------------
-- setting up engine
----------------------------------------------------------

LoadGameOptions(tableOPTIONS.GameOptionsFileName)
SaveGameOptions(tableOPTIONS.GameOptionsFileName)

----------------------------------------------------------
-- executing console commands   
----------------------------------------------------------

Console:execCommand("showfps")
--Console:execCommand("showinfo")

----------------------------------------------------------
-- setup standard gui
---------------------------------------------------------- 

local font_fname = 
    string.format("%s%s", ResMgr:getRelativeRootMediaDir(), "gui/fonts/cour.ttf")

GuiEnv:setSkinFont(font_fname, 14)
GuiEnv:setSkinAlpha(200)

----------------------------------------------------------
-- setup console
---------------------------------------------------------- 

local logo_fname = "";

if Driver:getDriverType()==vid.EDT_OPENGL then  

    logo_fname = string.format("%s%s", ResMgr:getRelativeRootMediaDir(), "textures/logo/MyEngineLogoOGL.tga");

elseif Driver:getDriverType()==vid.EDT_DIRECTX9 then
  
    logo_fname = string.format("%s%s", ResMgr:getRelativeRootMediaDir(), "textures/logo/MyEngineLogoD3D9.psd");

end

Console:setLogoImage(logo_fname)
Console:setLogoSize(298,106)
Console:setLogoMargins(0)
Console:setCmdHeight(18)
Console:setCmdMargins(5)
Console:setConsColor    (img.SColor(150,5,  5,  5  ));
Console:setFontLogColor (img.SColor(200,200,150,150));
Console:setFontCmdColor (img.SColor(255,0,  0,  0  ));
Console:setFontInfoColor(img.SColor(200,200,200,200));
    
----------------------------------------------------------
-- adding material renderers
----------------------------------------------------------

if Driver:getDriverType()==vid.EDT_OPENGL then  

elseif Driver:getDriverType()==vid.EDT_DIRECTX9 then

    Driver:addMaterialRenderer(
        vid.EMRT_HIGH_LEVEL_SHADER_RENDERER, "BumpMapRenderer_Standard", 
        "hardware/d3d9.hlsl.2tcoords.normalmap.vsh", "hardware/d3d9.hlsl.2tcoords.normalmap.psh",
        vid.ESC_NONE, vid.ESC_NONE
        );

    Driver:addMaterialRenderer(
        vid.EMRT_HIGH_LEVEL_SHADER_RENDERER, "BumpMapRenderer_StandardColoured", 
        "hardware/d3d9.hlsl.2tcoords.normalmap.vsh", "hardware/d3d9.hlsl.2tcoords.normalmap.psh",
        vid.ESC_NONE, vid.ESC_NONE
        );

    Driver:addMaterialRenderer(
        vid.EMRT_HIGH_LEVEL_SHADER_RENDERER, "BumpMapRenderer_2TCoords", 
        "hardware/d3d9.hlsl.2tcoords.normalmap.vsh", 
        "hardware/d3d9.hlsl.2tcoords.normalmap.psh",        
        vid.ESC_MODEL_VIEW_PROJ_MATRIX + 
            vid.ESC_EYE_POSITION +
            vid.ESC_LIGHT0_POSITION + 
            vid.ESC_LIGHT1_POSITION,
        vid.ESC_LIGHT0_COLOR +
            vid.ESC_LIGHT1_COLOR +
            vid.ESC_K_LIGHTMAP +
            vid.ESC_AMBIENT_COLOR +
            vid.ESC_DIFFUSE_COLOR +
            vid.ESC_SPECULAR_COLOR
        );
    
    Driver:addMaterialRenderer(
        vid.EMRT_HIGH_LEVEL_SHADER_RENDERER, "BumpMapRenderer_2TCoordsColoured", 
        "hardware/d3d9.hlsl.2tcoords.normalmap.vsh", "hardware/d3d9.hlsl.2tcoords.normalmap.psh",
        vid.ESC_NONE, vid.ESC_NONE
        );
end

-- loading plugings
if dev.IDevice:isDebug() then
    PluginMgr:registerPlugin("cescened",     "MyCEGUIScenEd_debug.dll")
    PluginMgr:registerPlugin("robotroopers", "RoboGame_debug.dll"     )
else
    PluginMgr:registerPlugin("cescened",     "MyCEGUIScenEd.dll")
    PluginMgr:registerPlugin("robotroopers", "RoboGame.dll"     )
end

-- start main game plugin
PluginMgr:startPlugin("robotroopers")

-- setting default logging level
Logger:setLogLevel(tableOPTIONS.LogLevel)

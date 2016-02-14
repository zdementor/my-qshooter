rem call upx.exe --force CEGUIBase.dll
rem call upx.exe --force CEGUILua.dll
rem call upx.exe --force CEGUIFalagardWRBase.dll
rem call upx.exe --force CEGUITinyXMLParser.dll
rem call upx.exe --force MyCEGUIRenderer.dll
rem call upx.exe --force cal3d.dll
rem call upx.exe --force MySetup.dll
rem call upx.exe --force MyDevice.dll
rem call upx.exe --force MyCore.dll
rem call upx.exe --force MyOpSys.dll
rem call upx.exe --force MyInOut.dll
rem call upx.exe --force MyImgLib.dll
rem call upx.exe --force MyGUI.dll
rem call upx.exe --force MyGUIScenEd.dll
rem call upx.exe --force MyCEGUI.dll
rem call upx.exe --force MyCEGUIScenEd.dll
rem call upx.exe --force MyVideo.dll
rem call upx.exe --force MyScript.dll
rem call upx.exe --force MyDynamic.dll
rem call upx.exe --force MyMultimed.dll
rem call upx.exe --force MyGame.dll
rem call upx.exe --force MyScene.dll
rem call upx.exe --force MyWrapper.dll
rem call upx.exe --force MyGUIScenEd.dll
rem call upx.exe --force robogame.dll
rem call upx.exe --force robotroopers.exe
rem 
rem call upx.exe --force ogg.dll
rem call upx.exe --force vorbis.dll
rem call upx.exe --force vorbisfile.dll
rem call upx.exe --force ftype.dll
rem call upx.exe --force ode.dll
rem call upx.exe --force zlib.dll
rem call upx.exe --force msvcp71.dll
rem call upx.exe --force msvcr71.dll
rem call upx.exe --force openal32.dll
rem call upx.exe --force wrap_oal.dll

cd ..

mkdir "robo.distr"

cd bin
                                
xcopy "..\robo.media"				"..\robo.distr\media\" /S
xcopy "..\common.media"				"..\robo.distr\common.media\" /S

copy CEGUIBase-{v.*}.dll			"..\robo.distr"
copy CEGUILuaScriptModule-{v.*}.dll	"..\robo.distr"
copy CEGUIFalagardWRBase-{v.*}.dll	"..\robo.distr"
copy CEGUITinyXMLParser-{v.*}.dll	"..\robo.distr"
copy CEGUITGAImageCodec-{v.*}.dll	"..\robo.distr"

copy Lua-{v.*}.dll	"..\robo.distr"
copy ToLua*-{v.*}.dll	"..\robo.distr"


copy Cal3D-{v.*}.dll       "..\robo.distr"
copy FreeType-{v.*}.dll    "..\robo.distr"
copy msvcp71.dll           "..\robo.distr"
copy msvcr71.dll           "..\robo.distr"
copy openal32.dll          "..\robo.distr"
copy wrap_oal.dll          "..\robo.distr"

copy MyCEGUI.dll           "..\robo.distr"
copy MyCore.dll            "..\robo.distr"
copy MyEngine.dll          "..\robo.distr"
copy MyVideoDX9.dll        "..\robo.distr"
copy MyVideoGL11.dll       "..\robo.distr"
copy MyVideoGL12.dll       "..\robo.distr"
copy MyVideoGL21.dll       "..\robo.distr"
copy MyCoreScript.dll      "..\robo.distr"
copy robogame.dll          "..\robo.distr"
copy robotroopers.exe      "..\robo.distr"

copy robotroopers.cfg      "..\robo.distr"
copy robooptions.cfg       "..\robo.distr"
copy robocegui.ini         "..\robo.distr"

copy robotroopers.lua      "..\robo.distr"

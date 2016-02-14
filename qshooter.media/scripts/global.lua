
-- global options table

tableOPTIONS =
{
	GameOptionsFileName		= "QShooterOptions.cfg",
	CEGUIOptionsFileName	= "QShooterCEGUI.ini",
	RootMediaDirectory		= "../qshooter.media/",
	LogLevel				= io.ELL_INFORMATION
}

-- singleton objects referenses

OSOp    = os.IOSOperator:getSingleton()
Device  = dev.IDevice:getSingleton()
ScrMgr  = scr.IScriptManager:getSingleton()
ScnMgr  = scn.ISceneManager:getSingleton()
GameMgr = game.IGameManager:getSingleton()
Logger  = io.ILogger:getSingleton()
Driver  = vid.IVideoDriver:getSingleton()
MatMgr  = scn.IMaterialsManager:getSingleton()
InpDisp = io.IInputDispatcher:getSingleton()
GuiEnv  = gui.IGUIEnvironment:getSingleton()
Console = gui.IGUIEngineConsole:getSingleton()
Cursor  = io.ICursorControl:getSingleton()
Logger  = io.ILogger:getSingleton()
ResMgr  = res.IResourceManager:getSingleton()
FileSys = io.IFileSystem:getSingleton()
MatMgr  = scn.IMaterialsManager:getSingleton()
PluginMgr = dev.IPluginManager:getSingleton()
SoundDrv = mm.ISoundDriver:getSingleton()

-- check, if we are in debug, then override some options

if Device:isDebug() then
	tableOPTIONS.RootMediaDirectory =
		"../../" + tableOPTIONS.RootMediaDirectory;
end

-- global variables

CameraStyle = 0
CameraAutoZoom = false







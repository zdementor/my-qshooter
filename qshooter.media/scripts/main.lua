
require "Helper"
require "Items"
require "Intros"

-----------------------------------------
-- create Crazy Eddie's GUI
-----------------------------------------

CEGUI.MyCEGUISystem.create(tableOPTIONS.CEGUIOptionsFileName)

-----------------------------------------
-- getting CEGUI ref objects
-----------------------------------------

local CEGUISystem    = CEGUI.System:getSingleton()
local CEGUISchemeMgr = CEGUI.SchemeManager:getSingleton()
local CEGUIImgsetMgr = CEGUI.ImagesetManager:getSingleton()
local CEGUIWinMgr    = CEGUI.WindowManager:getSingleton()
local CEGUICursor    = CEGUI.MouseCursor:getSingleton()

local gui_state=0

-----------------------------------------
-- Setup CEGUI System
-----------------------------------------

-- load schemes

CEGUISchemeMgr:loadScheme("QShooterLook.scheme")

-- set up defaults 

CEGUISystem:setDefaultMouseCursor("QShooterLook", "MouseArrow")
CEGUISystem:setDefaultFont("Tahoma-12")

CEGUICursor:show()

-- tooltip 

CEGUISystem:setDefaultTooltip("QShooterLook/Tooltip")

-- loading custom image sets

CEGUIImgsetMgr:createImageset("RoboIngameGUI.imageset")
CEGUIImgsetMgr:createImageset("RoboItems0.imageset")
CEGUIImgsetMgr:createImageset("MyEngineZDimitorLogo.imageset")

-----------------------------------------
-- Creating CEGUI controls
-----------------------------------------

-- creating root window

local RootWnd = CEGUIWinMgr:createWindow("DefaultWindow", "RootWnd")
CEGUISystem:setGUISheet(RootWnd)

-- loading layouts, creating controls

local MainMenu     = CEGUIWinMgr:loadWindowLayout("myengine_mainmenu.layout")
local AboutDlg     = CEGUIWinMgr:loadWindowLayout("myengine_about.layout")
local IngameGUI    = CEGUIWinMgr:loadWindowLayout("myrobo_main.layout")
local InventoryGUI = CEGUIWinMgr:loadWindowLayout("myrobo_inventory.layout")
local CreditsDlg   = CEGUIWinMgr:loadWindowLayout("myengine_credits.layout")
local OptionsDlg   = CEGUIWinMgr:loadWindowLayout("myengine_options.layout")
local WaitDlg      = CEGUIWinMgr:loadWindowLayout("myengine_waitdialog.layout")

-- setting up windows parent structure

MainMenu:setVisible(true)
RootWnd:addChildWindow(MainMenu)

AboutDlg:setVisible(false)
RootWnd:addChildWindow(AboutDlg)

IngameGUI:setVisible(false)
RootWnd:addChildWindow(IngameGUI)

InventoryGUI:setVisible(false)
RootWnd:addChildWindow(InventoryGUI)

CreditsDlg:setVisible(false)
RootWnd:addChildWindow(CreditsDlg)

OptionsDlg:setVisible(false)
RootWnd:addChildWindow(OptionsDlg)

WaitDlg:setVisible(false)
RootWnd:addChildWindow(WaitDlg)

-- getting reference pointers

local InventoryFrame =CEGUIWinMgr:getWindow("InventoryFrame")
local ListBoxStartLevel = 
    tolua.cast(CEGUIWinMgr:getWindow("ListBoxStartLevel"),"CEGUI::Listbox")

local ScenesNum = 2
local SceneFileNames = {}
SceneFileNames[0]="robo_hangar_part1.xml"
SceneFileNames[1]="robo_hangar_part2.xml"
SceneFileNames[2]="robo_hangar_part3.xml"
local item_col = CEGUI.colour:new_local(0.6, 0.6, 0.6, 1)
for s=0, ScenesNum-1 do
    local newItem=CEGUI.createListboxTextItem(SceneFileNames[s], 0, nil, false, true)   
    newItem:setSelectionBrushImage("QShooterLook", "MultiListSelectionBrush")
    newItem:setTextColours(item_col)
    ListBoxStartLevel:addItem(newItem)
    if s==0 then
        ListBoxStartLevel:setItemSelectState(newItem, true)
    end
end

local AboutLogo = CEGUIWinMgr:getWindow("MyEngineLogo")
local AboutInfo = CEGUIWinMgr:getWindow("AboutInfo")

local BackGroundImg   = CEGUIWinMgr:getWindow("BackGroundImg")

local LifeImg   = CEGUIWinMgr:getWindow("LifeImg")
local LifeBar   = tolua.cast(CEGUIWinMgr:getWindow("LifeBar"),"CEGUI::ProgressBar")
local LifeValue = CEGUIWinMgr:getWindow("LifeValue")

local AmmoImg   = CEGUIWinMgr:getWindow("AmmoImg")
local AmmoBar   = tolua.cast(CEGUIWinMgr:getWindow("AmmoBar"),"CEGUI::ProgressBar")
local AmmoValue = CEGUIWinMgr:getWindow("AmmoValue")

local ImgWeapon={}
ImgWeapon[0]=CEGUIWinMgr:getWindow("ImgWeapon0")
ImgWeapon[1]=CEGUIWinMgr:getWindow("ImgWeapon1")
ImgWeapon[2]=CEGUIWinMgr:getWindow("ImgWeapon2")

local CaptWeapon={}
CaptWeapon[0]=CEGUIWinMgr:getWindow("CaptWeapon0")
CaptWeapon[1]=CEGUIWinMgr:getWindow("CaptWeapon1")
CaptWeapon[2]=CEGUIWinMgr:getWindow("CaptWeapon2")

local ProgressAmmoWeapon={}
ProgressAmmoWeapon[0]=tolua.cast(CEGUIWinMgr:getWindow("ProgressAmmoWeapon0"),"CEGUI::ProgressBar")
ProgressAmmoWeapon[1]=tolua.cast(CEGUIWinMgr:getWindow("ProgressAmmoWeapon1"),"CEGUI::ProgressBar")
ProgressAmmoWeapon[2]=tolua.cast(CEGUIWinMgr:getWindow("ProgressAmmoWeapon2"),"CEGUI::ProgressBar")

local KeymapList = 
    tolua.cast(CEGUIWinMgr:getWindow("ActionMapList"),"CEGUI::MultiColumnList")
local LoadGameButton   = CEGUIWinMgr:getWindow("LoadGameButton" )
local ExitButton       = CEGUIWinMgr:getWindow("ExitButton"     )
local AboutButton      = CEGUIWinMgr:getWindow("AboutButton"    )
local AboutMainFrame   = CEGUIWinMgr:getWindow("AboutMainFrame" )
local AboutOKButton    = CEGUIWinMgr:getWindow("AboutOKButton"  )
local CreditsButton    = CEGUIWinMgr:getWindow("CreditsButton"  )
local CreditsMainFrame = CEGUIWinMgr:getWindow("CreditsMainFrame")
local CreditsOKButton  = CEGUIWinMgr:getWindow("CreditsOKButton")
local OptionsButton    = CEGUIWinMgr:getWindow("OptionsButton"  )
local OptionsMainFrame = CEGUIWinMgr:getWindow("OptionsMainFrame")
local OptionsOKButton  = CEGUIWinMgr:getWindow("OptionsOKButton")
local WaitCapt         = CEGUIWinMgr:getWindow("WaitMainFrame"  )
local WaitMsg          = CEGUIWinMgr:getWindow("MessageText"    )
local BrightScroll       = tolua.cast(CEGUIWinMgr:getWindow("BrightScroll"),"CEGUI::Scrollbar")
local BrightSpinner      = tolua.cast(CEGUIWinMgr:getWindow("BrightSpinner"),"CEGUI::Spinner")
local MusicVolumeSlider  = tolua.cast(CEGUIWinMgr:getWindow("MusicVolumeSlider"),"CEGUI::Slider")
local EffectsVolumeSlider= tolua.cast(CEGUIWinMgr:getWindow("EffectsVolumeSlider"),"CEGUI::Slider")

local MusicVolCapt   = CEGUIWinMgr:getWindow("MusicVolCapt")
local EffectsVolCapt = CEGUIWinMgr:getWindow("EffectsVolCapt")

local SGStyleRadio      = tolua.cast(CEGUIWinMgr:getWindow("SGStyleRadio"),"CEGUI::RadioButton")
local ASStyleRadio      = tolua.cast(CEGUIWinMgr:getWindow("ASStyleRadio"),"CEGUI::RadioButton")
local CrimsonStyleRadio = tolua.cast(CEGUIWinMgr:getWindow("CrimsonStyleRadio"),"CEGUI::RadioButton")

local AutoZoomCheck= tolua.cast(CEGUIWinMgr:getWindow("AutoZoomCheck"),"CEGUI::Checkbox")

local SenseScroll   = 
    tolua.cast(CEGUIWinMgr:getWindow("SenseScroll"),"CEGUI::Scrollbar")
local SenseSpinner  = 
    tolua.cast(CEGUIWinMgr:getWindow("SenseSpinner"),"CEGUI::Spinner")

local InventoryItemsList=
    tolua.cast(CEGUIWinMgr:getWindow("InventoryItemsList"),"CEGUI::Listbox")
local InventoryItemName       = CEGUIWinMgr:getWindow("InventoryItemName")
local InventoryItemShortDescr = CEGUIWinMgr:getWindow("InventoryItemShortDescr")
local InventoryItemDescr      = CEGUIWinMgr:getWindow("InventoryItemDescr")
local InventoryItemImage      = CEGUIWinMgr:getWindow("InventoryItemImage")
local InventoryCloseButton    = CEGUIWinMgr:getWindow("InventoryCloseButton")

-- creating custom controls

local MappingCapt = CEGUIWinMgr:createWindow("QShooterLook/StaticText", "EditControls")
MappingCapt:setVisible(false)
KeymapList:addChildWindow(MappingCapt)

local OptionsLockerWnd = 
    CEGUIWinMgr:createWindow("DefaultWindow", "OptionsLocker")
OptionsLockerWnd:setVisible(false)
OptionsDlg:addChildWindow(OptionsLockerWnd)

-- initializing GUI

LifeBar:setProgress(100)

AboutLogo:setProperty("Image", "set:MyEngineZDimitorLogo image:MyEngineZDimitorLogoImage")

AboutInfo:setText(Device:getDescriptionString())

BackGroundImg:setProperty("Image", "set:RoboIngameGUI image:BackGroundImage")   

LifeImg:setProperty("Image", "set:RoboIngameGUI image:HeartImage")   
AmmoImg:setProperty("Image", "set:RoboIngameGUI image:AmmoImage")   

KeymapList:addColumn("Action",       0, CEGUI.UDim(0.45, 0))
KeymapList:addColumn("Key/Mouse",    1, CEGUI.UDim(0.45, 0))
KeymapList:setSelectionMode(RowSingle)

-- setting column headers font
for i=0, KeymapList:getColumnCount()-1 do
	local lhs = KeymapList:getHeaderSegmentForColumn(i)
	--same as default multicolumn list font
	lhs:setFont(KeymapList:getFont())
end

MappingCapt:setProperty("UnifiedMaxSize", "{{1,0},{1,0}}")
MappingCapt:setProperty("HorzFormatting", "HorzCentred")

function GetActionControlString(action)     
    local kcode = InpDisp:getActionKey(action)
    local mcode = InpDisp:getActionMouse(action)
    local str = ""
    if kcode<io.E_KEY_CODE_COUNT then
        str = io.GetKeyCodeName(kcode)
        if mcode<io.E_MOUSE_CODE_COUNT then
            str = string.format("%s or %s", str, io.GetMouseCodeName(mcode))
        end
    elseif mcode<io.E_MOUSE_CODE_COUNT then
        str = io.GetMouseCodeName(mcode)
    end  
    return str    
end

function RefreshActionsMappingList() 
    local vscrollbar = KeymapList:getVertScrollbar()
    local scrollpos  = vscrollbar:getScrollPosition()
    KeymapList:resetList()
    for i=0, game.E_GAME_ACTION_COUNT-1 do
        KeymapList:addRow()
        local item0 = CEGUI.createListboxTextItem(game.GetGameActionName(i))
        local item1 = CEGUI.createListboxTextItem(GetActionControlString(i))
		
        item0:setSelectionBrushImage("QShooterLook", "MultiListSelectionBrush")
        item1:setSelectionBrushImage("QShooterLook", "MultiListSelectionBrush")  
		
		item0:setTextColours(CEGUI.colour(255,180,255,180))
		item1:setTextColours(CEGUI.colour(255,180,255,180))
		
        KeymapList:setItem(item0,0,i)
        KeymapList:setItem(item1,1,i)
    end
    vscrollbar:setScrollPosition(scrollpos)
end

RefreshActionsMappingList()

local scroll_pos = (OSOp:getMonitorBrightness()-0.5)/2.5
BrightScroll:setScrollPosition(scroll_pos)
local spinner_val = math.floor((270*scroll_pos+2.5)/5)*5
BrightSpinner:setCurrentValue(spinner_val)

OptionsLockerWnd:setProperty("UnifiedMaxSize", "{{1,0},{1,0}}")
OptionsLockerWnd:setProperty("UnifiedAreaRect", "{{0,0},{0,0},{1,0},{1,0}}")
OptionsLockerWnd:setProperty("AlwaysOnTop","True")

MusicVolumeSlider:setCurrentValue  (GameMgr:getSoundTracksVolume ())
EffectsVolumeSlider:setCurrentValue(GameMgr:getSoundEffectsVolume())

MusicVolCapt:setProperty  ("Text", string.format("%d%%", GameMgr:getSoundTracksVolume ()*100))
EffectsVolCapt:setProperty("Text", string.format("%d%%", GameMgr:getSoundEffectsVolume()*100))

if CameraStyle==0 then
    SGStyleRadio:setSelected(true)
elseif CameraStyle==1 then
    ASStyleRadio:setSelected(true)
elseif CameraStyle==2 then
    CrimsonStyleRadio:setSelected(true)
end

AutoZoomCheck:setSelected(CameraAutoZoom)

local sense_pos = (Cursor:getSensitivity()-0.1)/0.9
SenseScroll:setScrollPosition(sense_pos)
local sense_val = math.floor((270*sense_pos+2.5)/5)*5
SenseSpinner:setCurrentValue(sense_val)

-- setting control handlers
    
LoadGameButton:subscribeEvent ("Clicked", "LoadGameButtonHandler" )
ExitButton:subscribeEvent     ("Clicked", "ExitButtonHandler"     )
AboutButton:subscribeEvent    ("Clicked", "AboutButtonHandler"    )
AboutOKButton:subscribeEvent  ("Clicked", "AboutOKButtonHandler"  )
AboutMainFrame:subscribeEvent ("CloseClicked", "AboutOKButtonHandler")
CreditsButton:subscribeEvent  ("Clicked", "CreditsButtonHandler"  )
CreditsOKButton:subscribeEvent ("Clicked", "CreditsOKButtonHandler")
CreditsMainFrame:subscribeEvent("CloseClicked", "CreditsOKButtonHandler")
OptionsButton:subscribeEvent   ("Clicked", "OptionsButtonHandler"  )
OptionsMainFrame:subscribeEvent("CloseClicked", "OptionsOKButtonHandler")
OptionsOKButton:subscribeEvent ("Clicked",      "OptionsOKButtonHandler")
KeymapList:subscribeEvent("SelectionChanged", "ActionMapSelectionChanged")
OptionsLockerWnd:subscribeEvent("KeyDown",    "KeyDownMappingHandler"   )
OptionsLockerWnd:subscribeEvent("KeyUp",      "KeyUpMappingHandler"     )
OptionsLockerWnd:subscribeEvent("MouseClick", "MouseClickMappingHandler")
OptionsLockerWnd:subscribeEvent("MouseWheel", "MouseWheelMappingHandler")

BrightSpinner:subscribeEvent("ValueChanged",     "BrightSpinnerHandler")
BrightScroll:subscribeEvent ("ScrollPosChanged", "BrightScrollHandler" )

MusicVolumeSlider:subscribeEvent  ("ValueChanged", "MusicVolumeSliderHandler"  )
EffectsVolumeSlider:subscribeEvent("ValueChanged", "EffectsVolumeSliderHandler")

SGStyleRadio:subscribeEvent ("SelectStateChanged", "SGStyleRadioHandler")
ASStyleRadio:subscribeEvent ("SelectStateChanged", "ASStyleRadioHandler")
CrimsonStyleRadio:subscribeEvent ("SelectStateChanged", "CrimsonStyleRadioHandler")
AutoZoomCheck:subscribeEvent("CheckStateChanged",  "AutoZoomCheckHandler")

SenseSpinner:subscribeEvent("ValueChanged",     "SenseSpinnerHandler")
SenseScroll:subscribeEvent ("ScrollPosChanged", "SenseScrollHandler" )

InventoryFrame:subscribeEvent      ("CloseClicked",        "InventoryCloseButtonHandler" )
InventoryItemsList:subscribeEvent  ("ItemSelectionChanged","InventoryItemsListHandler"   )
InventoryCloseButton:subscribeEvent("Clicked",             "InventoryCloseButtonHandler" )

GameMgr:setScriptCallbackOnShowMessage  ("OnShowMessage")
GameMgr:setScriptCallbackBeforeLoadScene("BeforeLoadScene")
GameMgr:setScriptCallbackAfterLoadScene ("AfterLoadScene")
GameMgr:setScriptCallbackOnDeleteNode   ("OnDeleteNode")
GameMgr:setScriptCallbackOnCreateNode   ("OnCreateNode")
GameMgr:setScriptCallbackOnDieNode      ("OnDieNode"   )
GameMgr:setScriptCallbackOnGameAI       ("OnGameAI")
GameMgr:setScriptCallbackOnCollectItem  ("OnCollectItem")
GameMgr:setScriptCallbackOnThrowItem  ("OnThrowItem")
GameMgr:setScriptCallbackOnUseItem  ("OnUseItem")

-----------------------------------------

function CloseAll()
    local child_cnt = RootWnd:getChildCount()
    for ch=0, child_cnt-1 do
        RootWnd:getChildAtIdx(ch):setVisible(false)
    end
    MustRefreshGUI=true
end

-----------------------------------------

function SetCameraStyle()

    local style = CameraStyle

    local cnt = GameMgr:getGameNodesCount(game.EGNT_MAIN_PLAYER)

    for i=0, cnt-1 do

        local player  = tolua.cast(GameMgr:getGameNode(i), "game::IGameNodeMainPlayer")

        if style==0 then
            player:setCameraStyle("ShadowGround")
        elseif style==1 then
            player:setCameraStyle("AlienShooter3D")
        elseif style==2 then
            player:setCameraStyle("CrimsonLand")
        end  

        player:setCameraAutoZoom(CameraAutoZoom)
        if CameraAutoZoom==false then           
            player:setCameraZoom(0.5)
        end

    end

end

-----------------------------------------

function OnShowMessage(show, capt_msg)

    if show==true then          

        local pos = string.find(capt_msg, ";");
        local len = string.len(capt_msg);

        if pos~=nil and len>pos then       

            local capt = string.sub(capt_msg, 0,     pos-1)
            local msg  = string.sub(capt_msg, pos+1, len  )

            WaitCapt:setProperty("Text", capt)
            WaitMsg:setProperty("Text", msg )
        end

        CloseAll()        
        WaitDlg:setVisible(true)

        if Driver:isRendering3D() then          
            Driver:endRendering3D()
        end
        if Driver:isRendering2D() then          
            Driver:endRendering2D()
        end
        if Driver:isRendering() then          
            Driver:endRendering()
        end

        if Driver:beginRendering() then          
            if Driver:beginRendering2D() then
                CEGUISystem:renderGUI()             
            end
            Driver:endRendering2D()            
        end    
        Driver:endRendering()                    
        
    else        
        WaitDlg:setVisible(false)
    end

end

-----------------------------------------

function OnDeleteNode(arg)
    local node = tolua.cast(arg, "game::IGameNode") 
end

-----------------------------------------

function OnCreateNode(arg)
    local node = tolua.cast(arg, "game::IGameNode") 
end

-----------------------------------------

function OnDieNode(arg)
    local node = tolua.cast(arg, "game::IGameNode") 
end

-----------------------------------------

function OnGameAI(args)
end

-----------------------------------------

function ActionMapSelectionChanged(args)

    MappingCapt:setProperty("UnifiedAreaRect", "{{0.25,0},{0.325,0},{0.75,0},{0.675,0}}")
    MappingCapt:setVisible(true)
    MappingCapt:setText("Press key/mouse")

    OptionsLockerWnd:setVisible(true)
    OptionsLockerWnd:moveToFront()
    
end

-----------------------------------------

function KeyDownMappingHandler(args)

    local item = KeymapList:getFirstSelectedItem()

    if item==nil then
        return 0
    end

    local row  = KeymapList:getItemRowIndex(item)     

    local key_event = tolua.cast(args,"const CEGUI::KeyEventArgs")
    local kcode =key_event.scancode 

    MappingCapt:setProperty("UnifiedAreaRect", "{{0.25,0},{0.325,0},{0.75,0},{0.675,0}}")
    MappingCapt:setText(string.format("%s",io.GetKeyCodeName(kcode)))

    if kcode~=io.EKC_ESCAPE then
        InpDisp:mapKey(kcode, row)
    else
        InpDisp:mapKey  (io.E_KEY_CODE_COUNT, row)  
        InpDisp:mapMouse(io.E_MOUSE_CODE_COUNT, row)
    end

end

-----------------------------------------

function KeyUpMappingHandler(args)

    MappingCapt:setVisible(false)
    OptionsLockerWnd:setVisible(false) 
    OptionsLockerWnd:moveToBack()

    RefreshActionsMappingList()   

end

-----------------------------------------

function MouseClickMappingHandler(args)

    local mouse_event = tolua.cast(args,"const CEGUI::MouseEventArgs")
    local mcode = mouse_event.button

    MappingCapt:setProperty("UnifiedAreaRect", "{{0.25,0},{0.325,0},{0.75,0},{0.675,0}}")
    MappingCapt:setText(string.format("%s",io.GetMouseCodeName(mcode)))

    local item = KeymapList:getFirstSelectedItem()
    local row  = KeymapList:getItemRowIndex(item)  

    InpDisp:mapMouse(mcode, row)     

    MappingCapt:setVisible(false)
    OptionsLockerWnd:setVisible(false) 
    OptionsLockerWnd:moveToBack()  

    RefreshActionsMappingList() 

end

-----------------------------------------

function MouseWheelMappingHandler(args)

    local mouse_event = tolua.cast(args,"const CEGUI::MouseEventArgs")
    local wheel = mouse_event.wheelChange

    local item = KeymapList:getFirstSelectedItem()
    local row  = KeymapList:getItemRowIndex(item)

    MappingCapt:setProperty("UnifiedAreaRect", "{{0.35,0},{0.425,0},{0.65,0},{0.575,0}}")

    if wheel>0 then
        MappingCapt:setText(string.format("%s",io.GetMouseCodeName(io.EMC_MWHEEL_UP)))
        InpDisp:mapMouse(io.EMC_MWHEEL_UP, row)
    elseif wheel<0 then
        MappingCapt:setText(string.format("%s",io.GetMouseCodeName(io.EMC_MWHEEL_DOWN)))
        InpDisp:mapMouse(io.EMC_MWHEEL_DOWN, row)
    end
    
    MappingCapt:setVisible(false)
    OptionsLockerWnd:setVisible(false)
    OptionsLockerWnd:moveToBack()

    RefreshActionsMappingList()

end 

-----------------------------------------

function LoadGameButtonHandler(args)
    local sel_item = ListBoxStartLevel:getFirstSelectedItem()
    if sel_item==nil then
        return
    end
    -- loading scene
    GameMgr:loadGameScene(sel_item:getText())    
end

-----------------------------------------

function AboutButtonHandler(args)
    CloseAll()
    AboutDlg:setVisible(true)
end

-----------------------------------------

function AboutOKButtonHandler(args)
    CloseAll()
    MainMenu:setVisible(true)
end

-----------------------------------------

function CreditsButtonHandler(args)
    CloseAll()
    CreditsDlg:setVisible(true)
end

-----------------------------------------

function CreditsOKButtonHandler(args)
    CloseAll()
    MainMenu:setVisible(true)
end

-----------------------------------------

function OptionsButtonHandler(args)
    CloseAll()
    OptionsDlg:setVisible(true)
end

-----------------------------------------

function OptionsOKButtonHandler(args)
    SaveGameOptions(tableOPTIONS.GameOptionsFileName)
    CloseAll()
    MainMenu:setVisible(true)
end

-----------------------------------------

function ExitButtonHandler(args)
    Device:close()
end

-----------------------------------------

function BrightSpinnerHandler(args)
    local val = BrightSpinner:getCurrentValue()
    local pos = val/270;
    BrightScroll:setScrollPosition(val/270)
    OSOp:setMonitorBrightness(0.5+2.5*pos)
end

-----------------------------------------

function BrightScrollHandler(args)
    local pos = 270*BrightScroll:getScrollPosition()
    local val = math.floor((pos+2.5)/5)*5
    BrightSpinner:setCurrentValue(val)
end

-----------------------------------------

function MusicVolumeSliderHandler(args)
    local val = MusicVolumeSlider:getCurrentValue()
    GameMgr:setSoundTracksVolume(val)
    MusicVolCapt:setProperty  ("Text", string.format("%d%%", val*100))
end

-----------------------------------------

function EffectsVolumeSliderHandler(args)
    local val = EffectsVolumeSlider:getCurrentValue()
    GameMgr:setSoundEffectsVolume(val)
    EffectsVolCapt:setProperty  ("Text", string.format("%d%%", val*100))
end

-----------------------------------------

function SGStyleRadioHandler(args)
    if SGStyleRadio:isSelected() then
        CameraStyle = 0
        SetCameraStyle()
    end
end

-----------------------------------------

function ASStyleRadioHandler(args)
    if ASStyleRadio:isSelected() then       
        CameraStyle=1
        SetCameraStyle()
    end     
end

-----------------------------------------

function CrimsonStyleRadioHandler(args)
    if CrimsonStyleRadio:isSelected() then       
        CameraStyle=2
        SetCameraStyle()
    end     
end

-----------------------------------------

function AutoZoomCheckHandler(args)
    CameraAutoZoom = AutoZoomCheck:isSelected()
    SetCameraStyle()    
end

-----------------------------------------

function SenseSpinnerHandler(args)
    local val = SenseSpinner:getCurrentValue()
    local pos = val/270;
    SenseScroll:setScrollPosition(val/270)
    Cursor:setSensitivity(0.1+pos)
end

-----------------------------------------

function SenseScrollHandler(args)
    local pos = 270*SenseScroll:getScrollPosition()
    local val = math.floor((pos+2.5)/5)*5
    SenseSpinner:setCurrentValue(val)
end

-----------------------------------------

function InventoryCloseButtonHandler(args) 
    InpDisp:captureKeyUp(io.EKC_TAB);
end

----------------------------------------------------------

local tex_dir = ResMgr:getFullRootSceneMediaDir( res.ESMT_TEXTURES )
local cam_style = -1
local sel_weapon= -1

----------------------------------------------------------

function InventoryItemSelect(item_ptr) 

    local item = tolua.cast(item_ptr, "game::IGameNodeItem") 

    if item==nil then
        InventoryItemImage:setProperty     ("Image","") 
        InventoryItemName:setProperty      ("Text", "")
        InventoryItemShortDescr:setProperty("Text", "")
        InventoryItemDescr:setProperty     ("Text", "")
        return  
    end

    InventoryItemImage:setProperty     ("Image", item:getItemImageName() ) 
    InventoryItemName:setProperty      ("Text",  item:getItemName()      )
    InventoryItemShortDescr:setProperty("Text",  item:getItemShortDescr())
    InventoryItemDescr:setProperty     ("Text",  item:getItemDescr()     )

end

----------------------------------------------------------

function InventoryItemsListHandler(args)        

    local list_item = InventoryItemsList:getFirstSelectedItem()
    if list_item==nil then
        return
    end

    local item_idx = list_item:getID()
    local item_ptr = list_item:getUserData()

    InventoryItemSelect(item_ptr) 

end

----------------------------------------------------------

function UpdateIngameGUI()

    local player = GameMgr:getMainPlayerGameNode()
    if player~=nil then

        local life     = player:getLife()
        local max_life = player:getMaxLife()
        local life_pers = (life/max_life)

        if LifeBar:getProgress()~=life_pers then
            LifeValue:setText(string.format("%.f%%", life_pers*100))
            LifeBar:setProgress(life_pers)
        end 

        local inventory=player:getInventory()
        local weapon_count = inventory:getWeaponsCount()
        
        local _sel_weapon = player:getSelectedWeaponNumber()
        if sel_weapon~=_sel_weapon or cam_style~=CameraStyle or MustRefreshGUI then 
            sel_weapon=_sel_weapon
            cam_style = CameraStyle                     
            for w=0,2 do
                if w<weapon_count then
                    local weapon = inventory:getWeapon(w,0)
                    if weapon:isWeaponEnabled() then
                        if w==sel_weapon then
                            ImgWeapon[w]:setProperty("Image", weapon:getWeaponSelectedImageName())
                            CaptWeapon[w]:setProperty("TextColours", "tl:FF40FF40 tr:FF40FF40 bl:FF40FF40 br:FF40FF40")
                        else
                            ImgWeapon[w]:setProperty("Image", weapon:getWeaponImageName())
                            CaptWeapon[w]:setProperty("TextColours", "tl:FFFFFFFF tr:FFFFFFFF bl:FFFFFFFF br:FFFFFFFF")
                        end 
                    else
                        ImgWeapon[w]:setProperty("Image", "")
                        CaptWeapon[w]:setProperty("TextColours", "tl:FFFFFFFF tr:FFFFFFFF bl:FFFFFFFF br:FF60FFFF")             
                    end
                end
            end
    
            if cam_style==0 then
                local tex_fnam = ""                 
                local size   = core.dimension2df:new_local(0.0375,0.05)
                local offset = core.vector2df:new_local(0,0)
                local centered = true
                if sel_weapon==0 then 
                    tex_fname = string.format("%s%s",tex_dir,"sprites/aim_blaster.bmp")
                elseif sel_weapon==1 then 
                    tex_fname = string.format("%s%s",tex_dir,"sprites/aim_chainmachine.bmp")
                elseif sel_weapon==2 then 
                    tex_fname = string.format("%s%s",tex_dir,"sprites/aim_rocketlauncher.bmp")
                end                 
                local mips_flag = Driver:getTextureCreationFlag(vid.ETCF_CREATE_MIP_MAPS)
                Driver:setTextureCreationFlag(vid.ETCF_CREATE_MIP_MAPS, false)
                local tex = Driver:getTexture(tex_fname)                
                Cursor:setGraphicCursor(tex, size, offset, centered)
                Driver:setTextureCreationFlag(vid.ETCF_CREATE_MIP_MAPS, mips_flag)
            else
                local cur_fname = ""
                if sel_weapon==0 then 
                    cur_fname = string.format("%s%s",tex_dir,"cursors/aim_blaster.cur")
                elseif sel_weapon==1 then 
                    cur_fname = string.format("%s%s",tex_dir,"cursors/aim_chainmachine.cur")
                elseif sel_weapon==2 then 
                    cur_fname = string.format("%s%s",tex_dir,"cursors/aim_rocketlauncher.cur")
                end                 
                Cursor:resetGraphicCursor()
                Cursor:setCursor(cur_fname)         
            end
        end
        
        for w=0,2 do
            if w<weapon_count then
                local ammo_count=0  
                local max_ammo_count=0
                local ammo_progess=0
                local weapon_sub_count = inventory:getWeaponsSubCount(w)
                for wi=0,weapon_sub_count-1 do
                    local weapon = inventory:getWeapon(w,wi)
                    local bullet_idx = weapon:getChoosedBulletIndex()
                    ammo_count    = ammo_count     + weapon:getBulletAmmoCount(bullet_idx)
                    max_ammo_count= max_ammo_count + weapon:getBulletMaxAmmoCount(bullet_idx)
                end 
                if max_ammo_count>0 then
                    ammo_progess = ammo_count/max_ammo_count
                end
                if w==sel_weapon then
                    AmmoValue:setText(string.format("%d", ammo_count))
                    AmmoBar:setProgress(ammo_progess)
                end             
                ProgressAmmoWeapon[w]:setProgress(ammo_progess)     
            end
        end


        if MustRefreshGUI==true then
            if gui_state==2 then                    
                InventoryItemsList:resetList()
                InventoryItemSelect(0) 
                local item_col = CEGUI.colour:new_local(0.6, 0.6, 0.6, 1)
                local inventory=player:getInventory()
                local item_cnt = inventory:getItemsCount()
                for i=0, item_cnt-1 do  
                    local item = inventory:getItem(i)   
                    local item_params=item:getGameCommonParams()
                    local item_name = item_params.Scene.Parameters.name:c_str()
                    local list_item=CEGUI.createListboxTextItem(item_name, i , item, false, true)   
                    list_item:setSelectionBrushImage("QShooterLook", "MultiListSelectionBrush")
                    list_item:setTextColours(item_col)
                    InventoryItemsList:addItem(list_item)
                    if i==0 then
                        InventoryItemsList:setItemSelectState(list_item, true)
                        InventoryItemSelect(item) 
                    end
                end
            end
        end

    end

    if MustRefreshGUI==true then
        if Console:isVisible()==false or Console:getAction()==gui.ECA_DISAPPEARING then
            MustRefreshGUI=false    
            if gui_state==0 or gui_state==2 then
                GameMgr:stopGame()
                Cursor:setVisible(false)
                CEGUICursor:show()              
            elseif gui_state==1 then
                GameMgr:startGame()
                Cursor:setVisible(true)
                CEGUICursor:hide()
            end
        end     
    end

end

-----------------------------------------

function ChangeInventoryState()
    if gui_state==1 or gui_state==2 then
        if InventoryGUI:isVisible()==false then
            InventoryGUI:setVisible(true)
            InventoryGUI:moveToFront()
            gui_state = 2
        else    
            InventoryGUI:setVisible(false)
            gui_state = 1
        end
        MustRefreshGUI=true
    end     
end

-----------------------------------------

function OnEvent(args)

    local event = tolua.cast(args,"const io::SEvent")   
   
    if event.EventType == io.EET_KEY_INPUT_EVENT then       

        if event.KeyInput.Event == io.EKIE_KEY_PRESSED_UP then

            if event.KeyInput.Key == io.EKC_GRAVE then  

                if Console:isVisible()==false then
                    GameMgr:stopGame()                  
                end
                Console:changeState()
                MustRefreshGUI=true             

            elseif event.KeyInput.Key == io.EKC_ESCAPE then

                if InventoryGUI:isVisible() or MainMenu:isVisible() then  
                    gui_state = 0           
                else
                    gui_state = -1          
                end
        
                CloseAll()

                gui_state = gui_state + 1               

                if gui_state==1 then 
                    IngameGUI:setVisible(true)             
                elseif gui_state==0 then
                    MainMenu:setVisible(true)             
                end

            elseif event.KeyInput.Key == InpDisp:getActionKey(game.EGA_ENTER_INVENTORY) then                
                ChangeInventoryState()  
            end      
            
        end  

	elseif event.EventType == io.EET_MOUSE_INPUT_EVENT then  

        local mcode = InpDisp:getActionMouse(game.EGA_ENTER_INVENTORY)

        if mcode<io.E_MOUSE_CODE_COUNT then
            if mcode==io.EMC_LMOUSE and event.MouseInput.Event==io.EMIE_LMOUSE_LEFT_UP then
                ChangeInventoryState() 
            elseif mcode==io.EMC_RMOUSE and event.MouseInput.Event==io.EMIE_RMOUSE_LEFT_UP then 
                ChangeInventoryState()
            elseif mcode==io.EMC_MMOUSE and event.MouseInput.Event==io.EMIE_MMOUSE_LEFT_UP then 
                ChangeInventoryState()
            elseif mcode==io.EMC_MWHEEL_UP and event.MouseInput.Event==io.EMIE_MOUSE_WHEEL and event.MouseInput.Wheel>0 then 
                ChangeInventoryState()
            elseif mcode==io.EMC_MWHEEL_DOWN and event.MouseInput.Event==io.EMIE_MOUSE_WHEEL and event.MouseInput.Wheel<0 then 
                ChangeInventoryState()      
            end
        end

    end 

	if (event.EventType ~= io.EET_LOG_TEXT_EVENT) then	
		CEGUI.MyCEGUISystem.injectEvent(event) 
	end
        
end

-----------------------------------------

function BeforeLoadScene(args)    
    Cursor:setRelativePosition(0.5, 0.5)
    GameMgr:stopGame()
    CloseAll()
    CEGUICursor:hide()
end

-----------------------------------------

function AfterLoadScene(args)

    Cursor:setRelativePosition(0.5, 0.5)

    SetCameraStyle()
    GameMgr:startGame()
    CEGUICursor:hide()
    IngameGUI:setVisible(true)    

    gui_state=1

    -- feel rechargable weapons ammo

    local player = GameMgr:getMainPlayerGameNode()
    if player~=nil then    
        local inventory=player:getInventory()
        local weapon_count = inventory:getWeaponsCount()
        for w=0,weapon_count-1 do           
            local weapon_sub_count = inventory:getWeaponsSubCount(w)                
            for wi=0,weapon_sub_count-1 do
                local weapon = inventory:getWeapon(w,wi)
                local bullet_count = weapon:getBulletsCount()
                for bi=0,bullet_count-1 do
                    local wb_params = weapon:getWeaponBulletParameters(bi)
                    if wb_params.AutoFeelBulletsPerSecond>0 then
                        weapon:feelBulletAmmo(bi,weapon:getBulletMaxAmmoCount(bi))                  
                    end
                end
            end
        end
    end    
    
end                

----------------------------------------------------------
-- loading media here to let them logging
----------------------------------------------------------

-- adding pakage files

-- loading materials
MatMgr:loadMaterialsFromDir("software/", true)

----------------------------------------------------------
-- setup engine
----------------------------------------------------------

-- setting frame background color
local col = img.SColor(0,0,0,0)
Driver:setBackgroundColor(col)

-- hiding system cursor
--Cursor:setVisible(false)
Cursor:setRelativePosition(0.5, 0.5)

MainMenu:setVisible(true)

----------------------------------------------------------
-- main render cycle
----------------------------------------------------------

local sound_offset_ms=1000
local frame_time_ms = 33.33

tableFRAMES_INTRO = {
	{ TEX_NAME="intro/qsh_logo0000.tga", TIME_MS=6*frame_time_ms+sound_offset_ms },
	{ TEX_NAME="intro/qsh_logo0006.tga", TIME_MS=frame_time_ms },
	{ TEX_NAME="intro/qsh_logo0007.tga", TIME_MS=8*frame_time_ms },
	{ TEX_NAME="intro/qsh_logo0015.tga", TIME_MS=frame_time_ms },
	{ TEX_NAME="intro/qsh_logo0016.tga", TIME_MS=14*frame_time_ms },
	{ TEX_NAME="intro/qsh_logo0030.tga", TIME_MS=frame_time_ms },
	{ TEX_NAME="intro/qsh_logo0031.tga", TIME_MS=20*frame_time_ms },
	{ TEX_NAME="intro/qsh_logo0051.tga", TIME_MS=19*frame_time_ms },
	{ TEX_NAME="intro/qsh_logo0070.tga", TIME_MS=50*frame_time_ms },
}

PlayMovie(tableFRAMES_INTRO, "intro.wav", sound_offset_ms, 1000)

local bgrnd_tex = GetTexture("intro/qsh_logo0070.tga")

local bgrnd_material = vid.SMaterial()
bgrnd_material:getPass(0).Layers[0]:setTexture(bgrnd_tex)

local pass_cnt = bgrnd_material:getPassesCount()
for p=0, pass_cnt-1 do
    local pass = bgrnd_material:getPass(p)
    pass.ZBuffer   = false  
    pass.Lighting  = false
    pass.FogEnable = false
    pass.MipMapOff = true
end

local scr_vp = Driver:getViewPort() 
local cur_sys_time_ms = Device:getDeviceSystemTime()
local cur_sys_time_sec = cur_sys_time_ms / 1000
local last_sys_time_sec = cur_sys_time_sec

Device:setScriptCallbackOnEvent("OnEvent")

while Device:run() do

    -- getting current time (ms)

    cur_sys_time_ms = Device:getDeviceSystemTime()
    cur_sys_time_sec = cur_sys_time_ms / 1000

    local time_elapsed_sec = cur_sys_time_sec - last_sys_time_sec

    last_sys_time_sec = cur_sys_time_sec    
                
    -- prepare for rendering

    GameMgr:preRenderFrame()

    if Driver:beginRendering() then                          
      
        -- begin rendering 3D stuff
        if Driver:beginRendering3D() then

            if gui_state>0 then
                -- pre render stuff
                ScnMgr:preRenderScene()
                -- render scene
                ScnMgr:renderScene()
                Driver:render()
                -- game contens, physics, scripting, sound, ai  
                GameMgr:doGame()
                -- Post Render Stuff
                ScnMgr:postRenderScene()
            end         

        end

        -- end rendering 3D
        Driver:endRendering3D()

        -- begin rendering 2d, GUI
        if Driver:beginRendering2D() then           

            UpdateIngameGUI()
        
            if not Console:isVisible() then                         

                if gui_state<=0 then            
                    -- custom 2D draw   
					bgrnd_material:update(cur_sys_time_ms)        
                    local pass_cnt = bgrnd_material:getPassesCount()  
                    for p=0, pass_cnt-1 do      
                        Driver:draw2DImage(bgrnd_material:getPass(p), scr_vp)
                    end             
                   
                else                                    
                    -- render standard GUI      
                    GuiEnv:renderGUI()          
                end

                -- render Crazy Eddie's GUI                         
                CEGUISystem:injectTimePulse(time_elapsed_sec)                   
                CEGUISystem:renderGUI()                                     
            
            else
                -- render standard GUI      
                GuiEnv:renderGUI()          
            end             
        end

        -- end rendering 2D
        Driver:endRendering2D()        

    end

    -- end rendering
    Driver:endRendering()

    GameMgr:postRenderFrame()
    
end

-----------------------------------------
-- destroy Crazy Eddie's GUI
-----------------------------------------

CEGUI.MyCEGUISystem.destroy()
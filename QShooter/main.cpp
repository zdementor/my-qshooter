//|-------------------------------------------------------------------------
//| File:        main.cpp
//|
//| Descr:       This file is a part of the 'MyEngine'
//| Author:      Zhuk 'zdementor' Dmitry (aka ZDimitor)
//| Email:       zdimitor@pochta.ru, sibergames@nm.ru
//|
//|     Copyright (c) 2004-2009 by Zhuk Dmitry, Krasnoyarsk - Moscow
//|                      All Rights Reserved.
//|-------------------------------------------------------------------------

#ifdef _DEBUG
#	pragma comment (lib, "MyCEGUIRenderer_debug.lib")
#	pragma comment (lib, "MyScript_debug.lib")
#	pragma comment (lib, "MyDevice_debug.lib")
#	pragma comment (lib, "MyCore_debug.lib")
#else
#	pragma comment (lib, "MyCEGUIRenderer.lib")
#	pragma comment (lib, "MyScript.lib")
#	pragma comment (lib, "MyDevice.lib")
#	pragma comment (lib, "MyCore.lib")
#endif 

#include "../../inc/my.h"
#include "../../inc/my_cegui.h"
#include "../../inc/my_setup.h" 

extern "C" {
	#include "../../inc/my_robo.h" 
	#include "../../inc/my_wrap.h"
}

#include <stdio.h>  

#include "resource.h"  

#if _DEBUG
#	include <stdlib.h>
#	include <crtdbg.h>
#endif

using namespace my;

//-------------------------------------------------------------------------

class MyEventReceiver : public io::IEventReceiver
{
public:
    virtual bool OnEvent(io::SEvent event)
    {
		return false;
    }
}
receiver;

//-------------------------------------------------------------------------
#ifdef _CONSOLE_
int main(int argc, char* argv[]) 
#else
int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPTSTR    lpCmdLine,
                     int       nCmdShow)
#endif
{
#if _DEBUG

	#ifndef VLD_DEBUG 

	//_CrtSetDbgFlag(_CRTDBG_LEAK_CHECK_DF);

	int tmpDbgFlag; 

	HANDLE hLogFile=CreateFile(
		"VS_log.txt",GENERIC_WRITE,FILE_SHARE_WRITE, 
		NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL
		); 
	_CrtSetReportMode(_CRT_ASSERT,_CRTDBG_MODE_FILE | _CRTDBG_MODE_WNDW | _CRTDBG_MODE_DEBUG); 
	_CrtSetReportMode(_CRT_WARN,_CRTDBG_MODE_FILE | _CRTDBG_MODE_DEBUG); 
	_CrtSetReportMode(_CRT_ERROR,_CRTDBG_MODE_FILE | _CRTDBG_MODE_WNDW | _CRTDBG_MODE_DEBUG); 

	_CrtSetReportFile(_CRT_ASSERT,hLogFile); 
	_CrtSetReportFile(_CRT_WARN,hLogFile); 
	_CrtSetReportFile(_CRT_ERROR,hLogFile); 

	tmpDbgFlag=_CrtSetDbgFlag(_CRTDBG_REPORT_FLAG); 
	tmpDbgFlag|=_CRTDBG_ALLOC_MEM_DF; 
	tmpDbgFlag|=_CRTDBG_DELAY_FREE_MEM_DF; 
	tmpDbgFlag|=_CRTDBG_LEAK_CHECK_DF; 
	
	_CrtSetDbgFlag(tmpDbgFlag);

	//_CrtSetBreakAlloc(811031); 

	#endif
#endif 

	//-------------------------------------------------------------------------
	// show MyEngine Setup
	//-------------------------------------------------------------------------

    int  StartupResult = setup::srQuit;
	int  VideoDriver = vid::EDT_OPENGL; 
    int  ResolutionX = 800;
	int  ResolutionY = 600;
    int  ColorBit = setup::cb32;
	u32  Flags = 0;
	int  TextureFilter = vid::ETF_BILINEAR;

#ifdef _DEBUG
		HINSTANCE my3d_setup_dll = LoadLibrary("MySetup_debug.dll");
#else
		HINSTANCE my3d_setup_dll = LoadLibrary("MySetup.dll");
#endif
	if (my3d_setup_dll)
	{
		LPRunMyEngineSetup RunMyEngineSetup = 
			(LPRunMyEngineSetup)GetProcAddress(my3d_setup_dll, "RunMyEngineSetup" );

	    if (RunMyEngineSetup) 
		{
			StartupResult = 
				RunMyEngineSetup( VideoDriver, ResolutionX, ResolutionY, ColorBit, TextureFilter, Flags	);
		}
	} 
	else
	{
#ifdef _DEBUG
		MessageBox(NULL, "Cant Load MySetup_debug.dll", "Warning!", MB_OK);
#else
		MessageBox(NULL, "Cant Load MySetup.dll", "Warning!", MB_OK);
#endif
	}

	if (StartupResult == setup::srQuit || ResolutionX==0 || ResolutionY==0) 
	{
		return 0;
	}

	HANDLE hProcess = GetCurrentProcess();;
	DWORD dwPriorityClass = HIGH_PRIORITY_CLASS;

	//SetPriorityClass(hProcess, dwPriorityClass);
  
	vid::E_DRIVER_TYPE driverType;

	if      (VideoDriver == setup::vdOGL ) driverType = vid::EDT_OPENGL;
	else if (VideoDriver == setup::vdD3D9) driverType = vid::EDT_DIRECTX9;
	else                                   driverType = vid::EDT_OPENGL;

	core::dimension2d<s32> resolution(ResolutionX, ResolutionY);

	s32 colorBit;

	if (ColorBit == setup::cb16)
		colorBit = 16;
	else if (ColorBit == setup::cb32)
		colorBit = 32;
	else
		colorBit = 32;

	vid::E_TEXTURE_FILTER TexFilter;

	if (TextureFilter==setup::tfNone)
		TexFilter = vid::ETF_NONE;
	else if (TextureFilter==setup::tfBilinear)
		TexFilter = vid::ETF_BILINEAR;
	else if (TextureFilter==setup::tfTrilinear)
		TexFilter = vid::ETF_TRILINEAR;
	else if (TextureFilter==setup::tfAnisotropic)
		TexFilter = vid::ETF_ANISOTROPIC;
	else
		TexFilter = vid::ETF_BILINEAR;

	Flags |= dev::EDCF_SOUND_ON;

	dev::SDeviceCreationParameters creation_params; 

	creation_params.DriverType    = driverType;
	creation_params.WindowSize    = resolution;
	creation_params.Bits          = colorBit;
	creation_params.TextureFilter = TexFilter;
	creation_params.Flags         = Flags;
	creation_params.EventReceiver = &receiver;
	creation_params.WindowId      = 0;

	//----------------------------------------------------
	// create MyEngine device and exit if creation failed
	//----------------------------------------------------

	dev::createDevice( creation_params ); 	
	
	if (!dev::IDevice::getSingletonPtr()) 
	{
		printf("Error! Can not create MyEngine device.");
		return 0;	
	}  

	//-------------------------------------------------------------------------
	// executing engine startup script
	//-------------------------------------------------------------------------

	scr::IScriptManager::getSingleton().runScript("QuakeShooter.lua");
	
	//------------------------------------------------------------------------
    // free memory
    //------------------------------------------------------------------------	
	
#if MY_DEBUG_MODE 
	// Memory audit	
	core::stringc fname = dev::IDevice::getSingleton().getStartupDir();
	core::stringc fnameBefore = fname;
    fnameBefore.append("/AllocatedPtrsBeforeDrop.txt");
	printAllocNamesList((char *)fnameBefore.c_str()); 
#endif	

	dev::IDevice::getSingleton().drop();	
    
#if MY_DEBUG_MODE 
	// Memory audit
	core::stringc fnameAfter = fname;
    fnameAfter.append("/AllocatedPtrsAfterDrop.txt");
	printAllocNamesList((char *)fnameAfter.c_str());
#endif

	return 0;    
}



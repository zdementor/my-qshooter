
----------------------------------------------------------
-- setting media paths
----------------------------------------------------------

ResMgr:setRelativeRootMediaDir(tableOPTIONS.RootMediaDirectory)

ResMgr:setRelativeRootSceneMediaDir( res.ESMT_TEXTURES     , "textures/" );
ResMgr:setRelativeRootSceneMediaDir( res.ESMT_MESHES       , "models/"   );
ResMgr:setRelativeRootGameMediaDir ( res.EGMT_XML_SCRIPTS  , "xml/"      );
ResMgr:setRelativeRootSoundMediaDir( res.ESMT_SOUND_TRACKS , "sounds/"   );
ResMgr:setRelativeRootSoundMediaDir( res.ESMT_SOUND_EFFECTS, "sounds/"   );
ResMgr:setRelativeRootGUIMediaDir  ( res.EGMT_FONTS        , "gui/"      );

ResMgr:setRelativeSceneMediaDir( scn.ESNT_SCENE_MANAGER_ROOT_SCENE_NODE , res.ESMT_TEXTURES, ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_SCENE_MANAGER_ROOT_SCENE_NODE , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_DUMMY_TANSFORMATION_SCENE_NODE, res.ESMT_TEXTURES, ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_DUMMY_TANSFORMATION_SCENE_NODE, res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_ANIMATED_MESH_SCENE_NODE      , res.ESMT_TEXTURES, "meshes/"    );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_ANIMATED_MESH_SCENE_NODE      , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_BILLBOARD_SCENE_NODE          , res.ESMT_TEXTURES, "sprites/"   );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_BILLBOARD_SCENE_NODE          , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_CAMERA_SCENE_NODE             , res.ESMT_TEXTURES, ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_CAMERA_SCENE_NODE             , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_LENS_FLARE_SCENE_NODE         , res.ESMT_TEXTURES, ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_LENS_FLARE_SCENE_NODE         , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_LIGHT_SCENE_NODE              , res.ESMT_TEXTURES, "lights/"    );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_LIGHT_SCENE_NODE              , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_KTREE_SCENE_NODE              , res.ESMT_TEXTURES, "meshes/"    );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_KTREE_SCENE_NODE              , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_PARTICLE_SYSTEM_SCENE_NODE    , res.ESMT_TEXTURES, ""           ); 
ResMgr:setRelativeSceneMediaDir( scn.ESNT_PARTICLE_SYSTEM_SCENE_NODE    , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_SHADOW_SCENE_NODE             , res.ESMT_TEXTURES, ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_SHADOW_SCENE_NODE             , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_SKY_BOX_SCENE_NODE            , res.ESMT_TEXTURES, ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_SKY_BOX_SCENE_NODE            , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_TEST_SCENE_NODE               , res.ESMT_TEXTURES, "meshes/"    );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_TEST_SCENE_NODE               , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_TERRAIN_SCENE_NODE            , res.ESMT_TEXTURES, ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_TERRAIN_SCENE_NODE            , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_PATH_FINDER_SCENE_NODE        , res.ESMT_TEXTURES, ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_PATH_FINDER_SCENE_NODE        , res.ESMT_MESHES  , ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_UNKNOWN_SCENE_NODE            , res.ESMT_TEXTURES, ""           );
ResMgr:setRelativeSceneMediaDir( scn.ESNT_UNKNOWN_SCENE_NODE            , res.ESMT_MESHES  , ""           );

ResMgr:setRelativeGameMediaDir( game.EGNT_MAIN_PLAYER, res.EGMT_XML_SCRIPTS, "players/"     );            
ResMgr:setRelativeGameMediaDir( game.EGNT_PERSON,      res.EGMT_XML_SCRIPTS, "persons/"     );            
ResMgr:setRelativeGameMediaDir( game.EGNT_DECORATION,  res.EGMT_XML_SCRIPTS, "decorations/" );            
ResMgr:setRelativeGameMediaDir( game.EGNT_LEVEL_MAP,   res.EGMT_XML_SCRIPTS, "levelmaps/"   );            
ResMgr:setRelativeGameMediaDir( game.EGNT_TERRAIN,     res.EGMT_XML_SCRIPTS, "terrains/"    ); 
ResMgr:setRelativeGameMediaDir( game.EGNT_SKY_DOME,    res.EGMT_XML_SCRIPTS, "skydomes/"    );
ResMgr:setRelativeGameMediaDir( game.EGNT_ITEM,        res.EGMT_XML_SCRIPTS, "items/"       );
ResMgr:setRelativeGameMediaDir( game.EGNT_LIGHT,       res.EGMT_XML_SCRIPTS, "lights/"      );
ResMgr:setRelativeGameMediaDir( game.EGNT_TRIGGER,     res.EGMT_XML_SCRIPTS, "triggers/"    );
ResMgr:setRelativeGameMediaDir( game.EGNT_WEAPON,      res.EGMT_XML_SCRIPTS, "weapons/"     );
ResMgr:setRelativeGameMediaDir( game.EGNT_UNKNOWN,     res.EGMT_XML_SCRIPTS, ""             );

ResMgr:setRelativeSoundMediaDir( res.ESMT_SOUND_TRACKS,  "tracks/"  );
ResMgr:setRelativeSoundMediaDir( res.ESMT_SOUND_EFFECTS, "effects/" );

ResMgr:setRelativeGUIMediaDir( res.EGMT_FONTS, "fonts/" );

ResMgr:setRelativeGameScenesDir ( "scenes/"  );

ResMgr:setRelativeTempDir ( "temp/" );

ResMgr:setRelativeMaterialsDir ( "materials/" );

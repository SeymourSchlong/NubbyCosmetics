#macro scr_SaveData				asset_get_index("scr_SaveData")
#macro scr_GetNubbyCosmoSpr		asset_get_index("scr_GetNubbyCosmoSpr")
#macro obj_WarehouseMGMT		asset_get_index("obj_WarehouseMGMT")
#macro obj_Game					asset_get_index("obj_Game")

// This houses all of the loaded custom skins.
global.CustomSkins = [];

// Load custom skins here.
// Used in `gml_Object_obj_GAME_Create_0`
function custom_skins_initialize() {
	// find the skins folder: should be in the game directory with g3man.
	/* FILE STRUCTURE:
	
	Skins
	  ┗━ custom_skin
			  ┗━┳━	info.json
				┣━	launcher.png
				┗━	nubby.png
	
	INFO.JSON STRUCTURE:
	
	{
	    "id": "unique_identifier:name",
	    "name": "Nubby",
	    "desc": "This nubby is normal",
	    "credit": "Nubby skin made by: MogDogBlog"
	}
	
	*/
	
	var _base_dir = working_directory + "/Skins";
	
	// if the skin folder exists...
	if (directory_exists(_base_dir)) {
		
		// find subfolders
		var _directories = [];
		var _file_name = file_find_first(_base_dir + "/*", fa_directory);

		while (_file_name != "")
		{
		    array_push(_directories, _file_name);

		    _file_name = file_find_next();
		}

		file_find_close();
		
		// iterate through each subfolder.
		for (var _i = 0; _i < array_length(_directories); _i++) {
			var _folder = _base_dir + "/" + _directories[_i] + "/";
			
			// if info.json and nubby.png and launcher.png exist...
			if (!file_exists(_folder + "info.json") && !file_exists(_folder + "nubby.png") && !file_exists(_folder + "launcher.png")) continue;
			
			// read the json file
			var _info_fileid = file_text_open_read(_folder + "info.json");
			var _info_text = file_text_read_string(_info_fileid);
			while (!file_text_eof(_info_fileid)) {
				_info_text += file_text_readln(_info_fileid);
			}
			file_text_close(_info_fileid);
			var _json_data = json_parse(_info_text);
			
			// load sprite
			var _nubby_sprite = sprite_add(_folder + "nubby.png", 36, false, false, 0, 0);
			
			// re-set the origin point
			var _nubby_xoff = sprite_get_width(_nubby_sprite) / 2;
			var _nubby_yoff = sprite_get_width(_nubby_sprite) / 2;
			sprite_set_offset(_nubby_sprite, _nubby_xoff, _nubby_yoff);
			
			// load sprite
			var _launcher_sprite = sprite_add(_folder + "launcher.png", 20, false, false, 0, 0);
			
			// re-set the origin point
			var _launcher_xoff = sprite_get_width(_launcher_sprite) / 2;
			var _launcher_yoff = sprite_get_width(_launcher_sprite) / 2;
			sprite_set_offset(_launcher_sprite, _launcher_xoff, _launcher_yoff);
			
			struct_set(_json_data, "nubby", _nubby_sprite);
			struct_set(_json_data, "launcher", _launcher_sprite);
			
			array_push(obj_Game.U_Cosmo_NubbySkin, 1);
			
			array_push(global.CustomSkins, _json_data);
		}
	}
}

// Verifies that the current skin loaded from the save is either a valid vanilla skin or a valid custom skin.
// Used in `gml_Object_obj_Loader_Alarm_0`
function custom_skins_verifier() {
	// return early if the skin is a vanilla skin.
	if (scr_GetNubbyCosmoSpr(global.NubbyCosmetic, 0) != -1) {
		return;
	}
	
	var _found_index = array_find_index(global.CustomSkins, function(skin, index) {
		return skin.id == global.NubbyCosmetic;
	});
	
	if (_found_index == -1) {
		// if the currently used skin in `SaveSelectedNubbySkin` DOES NOT EXIST...
		// set it to "default". then save "Progression3".
		global.NubbyCosmetic = "default";
		scr_SaveData("Progression3");
	}
}


// Used in `gml_Object_obj_WarehouseMGMT_Create_0`
function custom_skins_handle_addition() {
	with (obj_WarehouseMGMT) {
		for (var i = 0; i < array_length(global.CustomSkins); i++) {
			var current_skin = global.CustomSkins[i];
			array_push(NubbySkinId,					current_skin.id);
			array_push(NubbySkinName,				current_skin.name);
			array_push(NubbySkinDesc,				current_skin.desc);
			array_push(NubbySkinEntitySpr,			current_skin.nubby);
			array_push(NubbySkinLauncherSpr,		current_skin.launcher);
			array_push(NubbySkinCredit,				current_skin.credit);
			array_push(NubbySkinStarsUnlockable,	true);
			array_push(NubbySkinUnlockCost,			0);
			array_push(NubbySkinUnlockInstructions,	"");
		}
	}
}


// Used in `gml_GlobalScript_scr_GetNubbyCosmoSpr`
function custom_skins_handle_sprites(skin_id, is_launcher) {
	var skin_index = -1;
	for (var _i = 0; _i < array_length(global.CustomSkins); _i++) {
		if (global.CustomSkins[_i].id == skin_id) {
			skin_index = _i;
			break;
		}
	}
	
	if (skin_index != -1) {
		if (is_launcher) {
			return global.CustomSkins[skin_index].launcher;
		} else {
			return global.CustomSkins[skin_index].nubby;
		}
	}
	
	return -1;
}
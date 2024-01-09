extends Node

class_name NavigationService

func navigate_to_game(this):
	this.get_tree().change_scene_to_file(Globals.game_scene)

func navigate_to_options(this):
	this.get_tree().change_scene_to_file(Globals.options_scene)

func navigate_to_menu(this):
	this.get_tree().change_scene_to_file(Globals.menu_scene)


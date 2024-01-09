extends Node

const NavigationService = preload("res://src/services/navigation_service.gd")

func _on_exit_pressed():
	get_tree().quit()


func _on_options_pressed():
	var navigation_service = NavigationService.new();
	navigation_service.navigate_to_options(self)


func _on_start_pressed():
	var navigation_service = NavigationService.new();
	navigation_service.navigate_to_game(self)

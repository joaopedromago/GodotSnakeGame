extends Node

const NavigationService = preload("res://src/services/navigation_service.gd")

func _ready():
	pass


func _process(delta):
	pass


func _on_return_pressed():
	var navigation_service = NavigationService.new();
	navigation_service.navigate_to_menu(self)

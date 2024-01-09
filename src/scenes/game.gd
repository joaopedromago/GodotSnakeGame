extends Node

const NavigationService = preload("res://src/services/navigation_service.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_pressed():
	var navigation_service = NavigationService.new();
	navigation_service.navigate_to_menu(self)

extends Node

const NavigationService = preload("res://src/services/navigation_service.gd")
const ChangeBodyService = preload("res://src/services/change_body_service.gd")
const FoodService = preload("res://src/services/food_service.gd")

var navigation_service: NavigationService
var change_body_service: ChangeBodyService
var food_service: FoodService

func _ready():
	navigation_service = NavigationService.new()
	change_body_service = ChangeBodyService.new(self)
	food_service = FoodService.new(self)
	food_service.generate_food()

func _on_return_pressed():
	navigation_service.navigate_to_menu(self)


func _on_food_area_entered(area):
	if area.name == "SnakeArea":
		food_gathered()


func food_gathered():
	food_service.generate_food()
	change_body_service.increase_body_size()

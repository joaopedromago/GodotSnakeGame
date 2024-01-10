extends Node

const NavigationService = preload("res://src/services/navigation_service.gd")
const ChangeBodyService = preload("res://src/services/change_body_service.gd")
const FoodService = preload("res://src/services/food_service.gd")
const ScoreService = preload("res://src/services/score_service.gd")

var navigation_service: NavigationService
var change_body_service: ChangeBodyService
var food_service: FoodService
var score_service: ScoreService
var score_label: Label
var best_score_label: Label

func _ready():
	navigation_service = NavigationService.new()
	change_body_service = ChangeBodyService.new(self)
	food_service = FoodService.new(self)
	score_service = ScoreService.new()
	
	food_service.generate_food()
	
	score_label = get_node("CanvasLayer/Panel/Score")
	best_score_label = get_node("CanvasLayer/Panel/BestScore")
	
	score_service.reset_score()
	update_score()


func _on_return_pressed():
	navigation_service.navigate_to_menu(self)


func _on_food_area_entered(area):
	if area.name == "SnakeArea":
		food_gathered()


func food_gathered():
	food_service.generate_food()
	change_body_service.increase_body_size()
	score_service.increase_score_value()
	update_score()


func _on_snake_area_entered(area):
	if area.has_meta("death_event") and area.get_meta("death_event"):
		navigation_service.navigate_to_death(self)

func update_score():
	score_label.text = score_service.get_score_text()
	best_score_label.text = score_service.get_best_score_text()

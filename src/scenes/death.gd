extends Node

const NavigationService = preload("res://src/services/navigation_service.gd")
const ScoreService = preload("res://src/services/score_service.gd")

var navigation_service: NavigationService
var score_service: ScoreService
var score_label: Label

func _ready():
	score_label = get_node("Score")
	navigation_service = NavigationService.new()
	score_service = ScoreService.new()
	update_score()
	
func _on_return_pressed():
	navigation_service.navigate_to_menu(self)

func update_score():
	score_label.text = score_service.get_score_text() + "\n" + score_service.get_best_score_text()

extends Node

const NavigationService = preload("res://src/services/navigation_service.gd")

var snake_speed_slider: Slider
var die_on_wall_hit_check: CheckBox
var speed_label: Label
var navigation_service: NavigationService

func _ready():
	navigation_service = NavigationService.new();
	
	snake_speed_slider = get_node("Menu/Panel/SnakeSpeedSlider")
	die_on_wall_hit_check = get_node("Menu/Panel/DieOnWallHitCheck")
	speed_label = get_node("Menu/Panel/SpeedInfo")

	snake_speed_slider.value = Globals.speed
	die_on_wall_hit_check.button_pressed = Globals.die_on_wall_hit
	update_speed_label()


func _on_snake_speed_slider_value_changed(value):
	Globals.speed = value
	update_speed_label()


func _on_die_on_wall_hit_check_toggled(toggled_on):
	Globals.die_on_wall_hit = toggled_on

func update_speed_label():
	speed_label.text = str(Globals.speed)


func _on_return_pressed():
	navigation_service.navigate_to_menu(self)

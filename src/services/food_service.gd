extends Node

class_name FoodService

var food: Area2D
var grid: TileMap
var rng = RandomNumberGenerator.new()

func _init(this):
	food = this.get_node("Field/Food")
	grid = this.get_node("Field/Grid")
	pass

func get_random_available_grid_location():
	var grid_size = grid.get_used_rect().size
	
	var randomX = rng.randf_range(0, grid_size.x -1)
	var randomY = rng.randf_range(1, grid_size.y)
	
	# TODO: verify if there's anything inside the food (talvez isso fique na logica de física do game)
	
	return Vector2(randomX, randomY)

func generate_food():
	var tile = get_random_available_grid_location()
	
	food.global_position = grid.map_to_local(tile)
	

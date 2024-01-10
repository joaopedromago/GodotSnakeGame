extends CharacterBody2D

const MoveBodyService = preload("res://src/services/move_body_service.gd")
var move_body = MoveBodyService.new(self)

const SPEED: int = 10
var direction: Vector2 = Vector2.UP
var tile_when_moving: Vector2

var timer: int = 0

@onready var grid: TileMap = $"../Grid"

func _ready():
	# define body
	pass

func _process(delta: float):
	if Input.is_action_just_pressed("ui_left") and is_moving_vertical() and can_move():
		move_left()
	elif Input.is_action_just_pressed("ui_right") and is_moving_vertical() and can_move():
		move_right()
	elif Input.is_action_just_pressed("ui_up") and is_moving_horizontal() and can_move():
		move_up()
	elif Input.is_action_just_pressed("ui_down") and is_moving_horizontal() and can_move():
		move_down()

	timer += 1

	if fmod(timer, SPEED) == 0:
		perform_movement()


func perform_movement():
	var current_tile: Vector2i = grid.local_to_map(global_position)
	var target_tile: Vector2 = Vector2(
		current_tile.x + direction.x,
		current_tile.y + direction.y,
	)

	# TODO: validate snake hit

	var tile_data: TileData = grid.get_cell_tile_data(0, target_tile)
	if not tile_data:
		wall_collision(target_tile)
	else:
		move_to_tile(current_tile, target_tile)


func move_to_tile(current_tile: Vector2, target_tile: Vector2):
	move_body.perform_movement(grid, current_tile, target_tile)

func move_left():
	direction = Vector2.LEFT
	move_made()


func move_right():
	direction = Vector2.RIGHT
	move_made()


func move_up():
	direction = Vector2.UP
	move_made()


func move_down():
	direction = Vector2.DOWN
	move_made()


func move_made():
	move_body.rotate_head_to_direction(direction)
	tile_when_moving = grid.local_to_map(global_position)


func can_move():
	var current_tile = grid.local_to_map(global_position)
	return current_tile.x != tile_when_moving.x or current_tile.y != tile_when_moving.y


func wall_collision(target: Vector2):
	var grid_size = grid.get_used_rect().size
	var current_tile: Vector2i = grid.local_to_map(global_position)

	# TODO: validate death
	
	var inverse_tile_x: int = target.x
	var inverse_tile_y: int = target.y

	if target.x < 0:
		inverse_tile_x = grid_size.x - 1
	elif target.x >= grid_size.x:
		inverse_tile_x = 0
	elif target.y < 1:
		inverse_tile_y = grid_size.y
	elif target.y > grid_size.y:
		inverse_tile_y = 1

	var inverse_tile = Vector2(inverse_tile_x, inverse_tile_y)
	
	move_to_tile(current_tile, inverse_tile)


func is_moving_vertical():
	return direction == Vector2.UP or direction == Vector2.DOWN


func is_moving_horizontal():
	return direction == Vector2.LEFT or direction == Vector2.RIGHT

extends CharacterBody2D

const SPEED = 10
var direction = Vector2.UP

var timer = 0

@onready var grid = $"../Grid"
@onready var sprite = $"./Collision/SnakeSprite"


func _process(delta):
	if Input.is_action_just_pressed("ui_left") and is_moving_vertical():
		move_left()
	elif Input.is_action_just_pressed("ui_right") and is_moving_vertical():
		move_right()
	elif Input.is_action_just_pressed("ui_up") and is_moving_horizontal():
		move_up()
	elif Input.is_action_just_pressed("ui_down") and is_moving_horizontal():
		move_down()

	timer += 1

	if fmod(timer, SPEED) == 0:
		perform_movement()


func perform_movement():
	var current_tile = grid.local_to_map(global_position)
	var target_tile = Vector2(
		current_tile.x + direction.x,
		current_tile.y + direction.y,
	)

	# TODO: validate hit wall

	global_position = grid.map_to_local(target_tile)


func move_left():
	direction = Vector2.LEFT
	rotate_to_direction()


func move_right():
	direction = Vector2.RIGHT
	rotate_to_direction()


func move_up():
	direction = Vector2.UP
	rotate_to_direction()


func move_down():
	direction = Vector2.DOWN
	rotate_to_direction()


func rotate_to_direction():
	var angle

	if direction == Vector2.LEFT:
		angle = deg_to_rad(270)
	if direction == Vector2.RIGHT:
		angle = deg_to_rad(90)
	if direction == Vector2.UP:
		angle = deg_to_rad(0)
	if direction == Vector2.DOWN:
		angle = deg_to_rad(180)
	sprite.rotation = 0
	sprite.rotation_degrees = 0
	sprite.rotate(angle)


func is_moving_vertical():
	return direction == Vector2.UP or direction == Vector2.DOWN


func is_moving_horizontal():
	return direction == Vector2.LEFT or direction == Vector2.RIGHT

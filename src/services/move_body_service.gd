extends Node

class_name MoveBodyService

var snake: CharacterBody2D

func _init(reference: CharacterBody2D):
	snake = reference

func _get_head_sprite():
	var head: CollisionShape2D = snake.get_child(0)
	return head.get_child(0)
	
func rotate_head_to_direction(direction: Vector2):
	var head_sprite = _get_head_sprite()
	rotate_to_direction(direction, head_sprite)

func rotate_tail_to_direction(direction: Vector2, tail: Area2D):
	var tail_sprite = tail.get_child(0).get_child(0)
	rotate_to_direction(direction, tail_sprite)
	
func rotate_to_direction(direction: Vector2, sprite: Sprite2D):
	var angle: float

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
	
func perform_movement(grid: TileMap, current_tile: Vector2, target_tile: Vector2):
	var move_to = current_tile
	
	var limbs = snake.get_parent().get_child(1).get_children()
	
	for limb in limbs:
		var is_new = limb.get_meta("is_new", false)
		if is_new:
			limb.set_meta("is_new", false)
			continue
			
		if limb.has_meta("wait") and limb.get_meta("wait") == true:
			limb.set_meta("wait", false)
			continue
		var previous_tile = grid.local_to_map(limb.global_position)
		
		limb.global_position = grid.map_to_local(move_to)
		if limb.name == "Tail":
			var direction = Vector2(move_to.x - previous_tile.x, move_to.y - previous_tile.y)
			rotate_tail_to_direction(direction, limb)
		move_to = previous_tile
	snake.global_position = grid.map_to_local(target_tile)

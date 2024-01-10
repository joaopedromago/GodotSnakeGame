extends Node

class_name ChangeBodyService

var snake: CharacterBody2D
var snakeLimbs: Node2D

func _init(this):
	snake = this.get_node("Field/Snake")
	snakeLimbs = this.get_node("Field/SnakeLimbs")
	
func _generate_limb(number: int):
	var area: Area2D = Area2D.new();
	area.name = "Body %s" % number
	area.set_meta("is_new", true)
	
	var collision: CollisionShape2D = CollisionShape2D.new()
	collision.name = "Shape"
	var shape: RectangleShape2D = RectangleShape2D.new()
	shape.size = Vector2(64,64)
	collision.shape = shape
	
	var sprite: Sprite2D = Sprite2D.new()
	sprite.texture = load("res://assets/snake_body.png")
	sprite.scale = Vector2(0.125, 0.125)
	
	collision.add_child(sprite)
	area.add_child(collision)
	
	return area

func increase_body_size():
	var limbs: Array[Node] = snakeLimbs.get_children()
	var snakeLength: int = limbs.size()
	var last_limb: Area2D = limbs[snakeLength - 2]
	var tail = limbs[snakeLength - 1]
	
	var new_limb: Area2D = _generate_limb(snakeLength)	
	new_limb.global_position = last_limb.global_position
	
	tail.set_meta("wait", true)
	
	snakeLimbs.add_child(new_limb)
	snakeLimbs.move_child(tail, snakeLength)


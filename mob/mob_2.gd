extends RigidBody2D

class_name Mob2

@export var speed = 2
var velocity = Vector2.ZERO

var deltaX:float = 0
var deltaY:float = 0

func _ready():
	$Area2D.name = "mob_area"

func _process(delta):
	#print($"../Player2".position)

	deltaX = ($"../Player2".global_position.x - global_position.x)/100
	deltaY = ($"../Player2".global_position.y - global_position.y)/100
	velocity = Vector2(deltaX,deltaY)
	position += velocity.normalized() * speed
	#move_and_slide()
	
	#$"RigidBody2D".position = position
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()	
	pass # Replace with function body.


func _on_body_entered(body):
	#print(body)	
	pass # Replace with function body.

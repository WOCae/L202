extends CharacterBody2D

@export var speed = 5
func _ready():
	position = Vector2(280,400)

	
func _process(delta):
	var velocity = Vector2.ZERO
	#upFlag = false
	#downFlag = false
	#leftFlag = false
	#rightFlag = false
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1*delta # moveup
		#rotation1 = 0
		rotation = 0*3.14/180
		#upFlag = true
		#downFlag = false
		#leftFlag = false
		#rightFlag = false
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1*delta # movedown
		#rotation1 = 180
		rotation = 180*3.14/180
		#downFlag = true
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1*delta # moveleft
		#rotation1 = 270
		rotation = 270*3.14/180
		#leftFlag = true
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1*delta # moveright
		#rotation1 = 90
		rotation = 90*3.14/180
		#rightFlag = true

	position += velocity.normalized() * speed
	move_and_slide()

	#print("test1")



func _on_plyer_area_2d_area_entered(area):
	#print(area.name)
	if area is Mob2: # or area is Boss
		print(area.name)
		#area.hit(1) # 敵に1ダメージ
		pass
	pass # Replace with function body.





func _on_player_rigid_body_2d_body_entered(body):
	print(body)	
	pass # Replace with function body.

extends Node2D

var hp:float = 100
var maxhp:float = 100 # 最大HP 

func _ready():

	$"HPBar".max_value =maxhp
	$"HPBar/Label".text = "Hp:" + str(hp)
	
	$Camera2D.position = $Player2.position
	$Line2D2.position = $Camera2D.position
	$MobPath.position = $Camera2D.position
	
	$StartTimer.start()
	
func _process(delta):
	#時間経過でhpを減らす
	if hp >= 0:
		hp -= delta
	
	# HPバー更新
	var hpbar:TextureProgressBar = $"HPBar"
	var hpratio = _hpratio()
	hpbar.value = maxhp * hpratio
	
	# HPバーの色を更新 LIGHT_GREEN
	hpbar.tint_progress = lerp(Color.YELLOW, Color.YELLOW, hpratio)
	hpbar.tint_under = lerp(Color.RED, Color.RED, hpratio)
	#hpbar.tint_over = lerp(Color.WHITE, Color.WHITE, hpratio)
	$"HPBar/Label".text = "Hp:" +"%4.0f" %  hp
	if hp <= 0:
		$"HPBar/Label".text = "Hp:0"
	
	#print($Player2.position)
	#$"HPBar".global_position = $Player2.global_position
	

	$Camera2D.position = $Player2.position
	$Line2D2.position.x = $Camera2D.position.x + 10
	$Line2D2.position.y = $Camera2D.position.y	+10
	
	$MobPath.position.x = $Camera2D.position.x + 10
	$MobPath.position.y = $Camera2D.position.y	+10
		
	$"HPBar".global_position.x = $Camera2D.position.x -150
	$"HPBar".global_position.y = $Camera2D.position.y + 300
	
func _hpratio():
	# 残りHPの割合を取得
	return 1.0 * hp / maxhp;



@export var mob_scene: PackedScene

func _on_start_timer_timeout():
	$MobTimer.start()
		
	pass # Replace with function body.

var mobcnt:int = 0
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	#mob_spawn_location.position =  $MobPath.position
	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	mob.position.x = mob.position.x + $Player2.position.x
	mob.position.y = mob.position.y + $Player2.position.y
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	#mob.linear_velocity = velocity.rotated(direction)
	mob.velocity = velocity.rotated(direction)
	
	mobcnt += 1
	mob.name = "mob"
	#$"mob/Area2D".name = "mob" + str(mobcnt)
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

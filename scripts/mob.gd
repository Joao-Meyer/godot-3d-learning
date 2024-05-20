extends CharacterBody3D

@export var min_speed = 10
@export var max_speed = 18

signal squashed

func _physics_process(delta):
	move_and_slide()

func initialize(start_positon, player_position):
	look_at_from_position(start_positon, Vector3(player_position.x, 0, player_position.z), Vector3.UP)
	
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

	$AnimationPlayer.speed_scale = random_speed / min_speed

func die():
	queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited():
	die()
				
func squash():
	squashed.emit()
	die()

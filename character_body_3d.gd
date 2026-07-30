extends CharacterBody3D
var gravity_strength = 20.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity_strength * delta
		move_and_slide()

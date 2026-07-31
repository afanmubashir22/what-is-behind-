extends CharacterBody3D
@export var Walk_speed = 3.0
var gravity_strength = 20.0
@onready var nav_agent = $NavigationAgent3D
func _ready():
	velocity = Vector3.ZERO
	await get_tree().create_timer(0.2).timeout
	nav_agent.target_position =Vector3(global_position.x + 5.0, global_position.y, global_position.z + 5.0)
	print("target set to: ", nav_agent.target_position)
	print("Is  navigation finished? ", nav_agent.is_navigation_finished())
func _physics_process(delta):
		if not is_on_floor():
			velocity.y -= gravity_strength * delta
			if nav_agent.is_navigation_finished():
				velocity.x = 0
				velocity.z = 0
			else:
					var next_path_pos: Vector3 = nav_agent.get_next_path_position()
					var direction = (next_path_pos - global_transform.origin) .normalized()
					velocity.x = direction.x * Walk_speed
					velocity.z =direction.z * Walk_speed
					move_and_slide()
					
					

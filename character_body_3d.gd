extends CharacterBody3D

@export var Walk_speed = 3.0
var gravity_strength = 20.0

@onready var nav_agent = $NavigationAgent3D

var player = null

func _ready():
	velocity = Vector3.ZERO
	await get_tree().create_timer(0.2).timeout
	player = get_tree().get_first_node_in_group("player")
								   
func _physics_process(delta):
		if not is_on_floor():
			velocity.y -= gravity_strength * delta
		if player:
			nav_agent.target_position = player.global_position
		if nav_agent.is_navigation_finished():
				velocity.x = 0
				velocity.z = 0
		else:
				var next_path_pos: Vector3 = nav_agent.get_next_path_position()
				var direction = (next_path_pos - global_position).normalized()
				velocity.x = direction.x * Walk_speed
				velocity.z =direction.z * Walk_speed
					
		move_and_slide()
					
					

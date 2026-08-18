extends CharacterBody3D

@export var Walk_speed = 3.0
@export var rotation_speed = 10.0
var gravity_strength = 20.0

@onready var nav_agent = $NavigationAgent3D

var player = null

func _ready():
	velocity = Vector3.ZERO
	nav_agent.velocity_computed.connect(Callable(self, "_on_velocity_computed"))
	await get_tree().create_timer(0.2).timeout
	player = get_tree().get_first_node_in_group("player")
								   
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity_strength * delta
	if player:
		nav_agent.target_position = player.global_position
	var intended_velocity = Vector3.ZERO
	
	if not nav_agent.is_navigation_finished():
		var next_path_pos:Vector3=nav_agent.get_next_path_position()
		var direction=global_position.direction_to(next_path_pos)
		
		var flat_dir=Vector3(direction.x,0,direction.z).normalized()
		if flat_dir.length()>0.1:
			var target_look=global_position+flat_dir
			var target_transform=global_transform.looking_at(target_look,Vector3.UP)
			global_transform=global_transform.interpolate_with(target_transform,rotation_speed*delta)
		intended_velocity=direction*Walk_speed
	if nav_agent.avoidance_enabled:
		nav_agent.set_velocity(intended_velocity)
	else:
		_on_velocity_computed(intended_velocity)
	
func _on_velocity_computed(safe_velocity:Vector3):
	velocity.x=safe_velocity.x
	velocity.z=safe_velocity.z
	move_and_slide()


func _on_kill_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if body.has_method("die"):
			body.die()

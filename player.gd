extends CharacterBody3D

@export var walk_speed: float = 5.0
@export var jump_velocity:float=4.5
@export var mouse_sensitivity:float=0.002
@export var acceleration:float=10.0
@export var decleration:float=12.0

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var raycast: RayCast3D = $Head/RayCast3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(80))
		
func  _physics_process(delta: float)  -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y=jump_velocity
		
	var input:=Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	var direction :=(transform.basis*Vector3(input.x,0,input.y)).normalized()
	if direction != Vector3.ZERO:
		velocity.x = move_toward(velocity.x,direction.x*walk_speed,acceleration*delta)
		velocity.z = move_toward(velocity.z,direction.z*walk_speed,acceleration*delta)
	else:
		velocity.x = move_toward(velocity.x, 0,decleration*delta)
		velocity.z = move_toward(velocity.z, 0, decleration*delta)
	move_and_slide()

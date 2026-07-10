extends CharacterBody3D

@export var SPEED: float = 4.0
@export var MOUSE_SENSITIVITY: float = 0.002

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var raycast: RayCast3D = $Head/RayCast3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
	
func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		head.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(80))
	
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)   
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				
func  _physics_process(delta: float)  -> void:
					if not is_on_floor():
						velocity.y -= gravity * delta
						
						var input_dir :=Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
						var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
						
						if direction:
							velocity.x = move_toward(velocity.x, 0, SPEED)
							velocity.z = move_toward(velocity.z, 0,SPEED)
							
							move_and_slide()
						
						
						
					
					
					
					
					
	
				
			

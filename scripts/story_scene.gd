extends Control
@export_file("*.tscn") var main_game_scene: String = "res://scenes/house.scn"
@onready var continue_button = $ContinueButton
@onready var creepy_music = $CreepyMusic

func _ready():
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if creepy_music and not creepy_music.playing:
			creepy_music.play()
		if not continue_button.pressed.is_connected(_on_continue_pressed):
			continue_button.pressed.connect(_on_continue_pressed)
func _on_continue_pressed():
	if creepy_music:
		creepy_music.stop()
		
		get_tree().change_scene_to_file("res://scenes/house.scn")
func _on_continue_button_pressed():
		_on_continue_pressed()
		

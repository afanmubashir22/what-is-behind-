extends Control
@export_file("*.tscn") var main_game_scene: String = "res://scenes/story_scene.tscn"
@onready var play_button = $VBoxContainer/PlayButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var background_music = $BackgroundMusic

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
func _on_play_pressed():
	if background_music:
			background_music.stop()
	get_tree().change_scene_to_file("res://scenes/story_scene.tscn")	
func _on_quit_pressed():
		get_tree().quit()

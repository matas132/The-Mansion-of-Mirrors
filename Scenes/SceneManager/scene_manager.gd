extends Node

@onready var start_game: Button = $TitleScreen/MarginContainer/VBoxContainer/StartGame
@onready var settings: Button = $TitleScreen/MarginContainer/VBoxContainer/Settings
@onready var quit: Button = $TitleScreen/MarginContainer/VBoxContainer/Quit
@onready var exit_settings : Button = $AudioSettings/MarginContainer/TextureRect/VBoxContainer/ExitSettings
@onready var about: Button = $TitleScreen/MarginContainer/VBoxContainer/About
@onready var place_holder_song: AudioStreamPlayer = $PlaceHolderSong

#Pause menu is also handled in the scene manager
@onready var pause_audio_settings: Button = $PauseMenu/MarginContainer/TextureRect/VBoxContainer/AudioSettings
@onready var pause_exit: Button = $PauseMenu/MarginContainer/TextureRect/VBoxContainer/ExitPausedMenu
@onready var pause_to_title: Button = $PauseMenu/MarginContainer/TextureRect/VBoxContainer/ToTitle

@onready var audio_settings: Control = $AudioSettings
@onready var pause_menu: Control = $PauseMenu

@onready var title_screen: Control = $TitleScreen

@onready var game_scenes: Node = $GameScenes


const TEST_ROOM_1 = preload("res://Scenes/Areas/TestRoom1/test_room_3.tscn")
const TEST_ROOM_2 = preload("res://Scenes/Areas/TestRoom1/test_room_2.tscn")

const PLAYER = preload("res://Scenes/Characters/Player/player.tscn")
var player = PLAYER.instantiate() as Player

# AEHAHEAHEH
var player_in_pause_menu := false

func _ready():
	place_holder_song.play()
	_load_main_menu()
	
	EventHandler.switch_rooms.connect(switch_room)
	


func _load_main_menu():
	start_game.pressed.connect(_on_start_game_pressed)
	settings.pressed.connect(_on_settings_pressed)
	exit_settings.pressed.connect(_on_exit_settings_pressed)
	quit.pressed.connect(_on_quit_pressed)
	# the about menu, its scene is not made
	about.pressed.connect(_on_about_pressed)
	
	#Pause menu
	pause_audio_settings.pressed.connect(_on_pause_audio_settings_pressed) # sets it so pause menu's audio settings button opens audio settings
	pause_exit.pressed.connect(_on_pause_exit_pressed)
	pause_to_title.pressed.connect(_on_pause_to_title_pressed)



# Title screen functions
func _on_start_game_pressed():
	place_holder_song.stop()
	title_screen.visible = false
	
	# this will have to be edited a bit to handle the logic of switching between the 3 rooms and the visual novel scenes maybe
	var test_room_1 = TEST_ROOM_1.instantiate()
	var test_room_2 = TEST_ROOM_2.instantiate()
	
	
	
	game_scenes.add_child(test_room_1)
	game_scenes.add_child(test_room_2)
	switch_room()
	
	#player.global_position should be different
	


func _on_settings_pressed():
	get_tree().paused = true
	audio_settings.visible = true

func _on_quit_pressed():
	get_tree().quit()

func _on_about_pressed():
	print("about pressed")



# Audio settings menu functions
func _on_exit_settings_pressed():
	#print("exiting settings")
	get_tree().paused = false
	audio_settings.visible = false
	if player_in_pause_menu:
		_on_pause_press()
		




# Pause menu settings
func _on_pause_press() -> void: # function should be called in game
	get_tree().paused = true
	pause_menu.visible = true
	player_in_pause_menu = true

func _on_pause_exit_pressed() -> void:
	get_tree().paused = false
	pause_menu.visible = false
	player_in_pause_menu = false

func _on_pause_to_title_pressed() -> void:
	title_screen.visible = true
	_on_pause_exit_pressed()

func _on_pause_audio_settings_pressed()-> void:
	pause_menu.visible = false
	_on_settings_pressed()


#Switching room
func switch_room() ->void:
	var room_a = game_scenes.get_child(-1) as Node2D
	var room_b = game_scenes.get_child(0) as Node2D
	if room_a.has_node("Player"):
		room_a.remove_child(player)
	
	room_a.visible = false
	room_b.visible = true
	
	room_a.process_mode = Node.PROCESS_MODE_DISABLED
	room_b.process_mode = Node.PROCESS_MODE_INHERIT
	
	room_b.add_child(player) # "teleports" the player to the other mirror, by going through all the nodes and finding the mirror portal node, this is just because we might want to make mutiple portals
	
	var child = room_b.get_node("Mirror")
	player.global_position = child.global_position + Vector2(0,-30)
	
	game_scenes.move_child(room_b,-1)
	

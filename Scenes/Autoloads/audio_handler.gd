extends Node
@onready var choose: AudioStreamPlayer = $Choose
@onready var select: AudioStreamPlayer = $Select

func _ready() -> void:
	EventHandler.button_select.connect(_on_button_select)
	EventHandler.button_choose.connect(_on_button_choose)

func _on_button_select() ->void:
	select.play()

func _on_button_choose() ->void:
	choose.play()

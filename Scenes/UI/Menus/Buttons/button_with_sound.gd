class_name SoundButton
extends Button

func _ready() ->void:
	mouse_entered.connect(_on_mouse_entered)
	pressed.connect(_on_pressed)

func _on_mouse_entered() ->void: 
	EventHandler.button_choose.emit()

func _on_pressed() -> void:
	EventHandler.button_select.emit()

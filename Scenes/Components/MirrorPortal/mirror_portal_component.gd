class_name MirrorPortal
extends Node

func _ready() -> void:
	var interactive_area = get_parent() as InteractiveArea
	interactive_area.interacted.connect(_teleport)

func _teleport() -> void: # The room teleportation will be just handled by the scene manager, on the account of there always only being 2 rooms and us switching between them
	EventHandler.switch_rooms.emit()
	

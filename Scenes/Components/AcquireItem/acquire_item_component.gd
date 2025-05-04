extends Node

@export var given_item : Item

func _ready() -> void:
	var interactive_area = get_parent() as InteractiveArea
	interactive_area.interacted.connect(_give_item)


func _give_item() -> void: # needed code for the inventory
	if given_item == null:
		return
	
	print("give the player the item - " + given_item.name)
	

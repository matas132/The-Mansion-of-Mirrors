class_name InteractiveArea
extends Area2D

@export var check_item : bool = false
@export var item : Item

@export var interactable_once : bool = false
var interacted_once := false

signal interacted(player :Player)
#var just_interacted := false

# the player calls this function when selected
func interact(player : Player) -> void: # TODO remake this as seperate methods when we know more of the direction for the game
	if check_item == false:
		if interactable_once == true:
			if interacted_once == false:
				interacted.emit()
				interacted_once = true
				return
			else:
				return

		interacted.emit()
		return
	
	if check_item == true:
		if interactable_once == true:
			if interacted_once == false:
				interacted.emit()
				interacted_once = true
				return
			else:
				return
		interacted.emit()
		return
		

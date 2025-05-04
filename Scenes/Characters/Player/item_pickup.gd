extends Node

@onready var inventory = $"../Inventory"

func _on_item_picked(item):
	inventory.add_item(item)
	print(item)

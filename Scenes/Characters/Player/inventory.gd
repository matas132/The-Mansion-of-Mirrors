extends Node

@export var max_items: int = 20
var items: Array = []

# Signal emitted when an item is picked up or used
signal item_added(item_name: String)
signal item_used(item_name: String)
signal item_dropped(item_name: String)

# Add item to the inventory
func add_item(item):
	print("Item Added")
	if items.size() < max_items:
		items.append(item)
		emit_signal("item_added", item.name)
	else :
		print("Inventory is full")

# Use an item from the inventory
func use_item(item_name: String):
	for item in items:
		if item.name == item_name:
			emit_signal("item_used", item_name)
			items.erase(item)
			return
	print("Item not found in inventory")

# Drop an item from the inventory
func drop_item(item_name: String):
	for item in items:
		if item.name == item_name:
			emit_signal("item_dropped", item_name)
			items.erase(item)
			return
	print("Item not found in inventory")

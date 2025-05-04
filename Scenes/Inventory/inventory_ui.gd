class_name Inventory
extends Control

@onready var item_list = $HUD/MarginContainer/VBoxContainer/ItemList as ItemList
@onready var description_label = $HUD/MarginContainer/VBoxContainer/Details/Description as Label
@onready var use_button = $HUD/MarginContainer/VBoxContainer/Details/Use as Button
@onready var drop_button = $HUD/MarginContainer/VBoxContainer/Details/Drop as Button
@onready var popup = $HUD/Popup as Popup
@onready var notification_timer = $NotificationTimer

var inventory

# Set the inventory to use in this UI
func set_inventory(inv):
	inventory = inv
	inventory.item_added.connect(_on_item_added)
	inventory.item_used.connect(_on_item_used)
	inventory.item_dropped.connect(_on_item_dropped)
	_refresh_item_list()

# Refreshes the list based on current items in the inventory
func _refresh_item_list():
	item_list.clear()
	for item in inventory.items:
		item_list.add_item(item.name)

# Handle adding an item to the UI
func _on_item_added(item_name: String):
	item_list.add_item(item_name)
	_show_notification("Picked up: " + item_name)

# Handle using an item
func _on_item_used(item_name: String):
	_refresh_item_list()

# Handle dropping an item
func _on_item_dropped(item_name: String):
	_refresh_item_list()

# Show notification pop-up
func _show_notification(message: String):
	popup.get_child(0).text = message
	popup.popup()
	notification_timer.start() # Start the timer to hide the pop-up after a delay

# Timer callback to hide the pop-up
func _on_NotificationTimer_timeout():
	popup.hide()

# Button callback to use selected item
func _on_use_button_pressed():
	var selected = item_list.get_selected_items()
	if selected.size() > 0:
		var item_name = item_list.get_item_text(selected[0])
		inventory.use_item(item_name)

# Button callback to drop selected item
func _on_drop_button_pressed():
	var selected = item_list.get_selected_items()
	if selected.size() > 0:
		var item_name = item_list.get_item_text(selected[0])
		inventory.drop_item(item_name)

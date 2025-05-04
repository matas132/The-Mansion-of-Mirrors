extends Node2D

@onready var player = $Test_Player
@onready var inventory_ui = $UI/InventoryUI

func _ready():
	var player_inventory = player.get_node("Additional/Inventory")
	inventory_ui.set_inventory(player_inventory)

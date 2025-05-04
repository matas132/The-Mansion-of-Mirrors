class_name Test_Player
extends CharacterBody2D

@export var speed: float = 5000.0
@onready var sprite = $Sprite2D
@onready var item_pickup = $Additional/Item_Pickup
@onready var inventory_ui = $"../UI/InventoryUI"

#Movement Inputs
func movement(delta):
	var x_mov = 0
	var y_mov = 0
	if Input.get_action_strength("right") or Input.get_action_strength("left"):
		x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	elif Input.get_action_strength("down") or Input.get_action_strength("up"):
		y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	if x_mov > 0:
		sprite.flip_h = true
	if x_mov < 0:
		sprite.flip_h = false
	
	velocity = mov.normalized() * speed * delta
	move_and_slide()

func _physics_process(delta):
	movement(delta)

func _input(event):
	if event.is_action_pressed("pick_item"):
		_simulate_item_pickup()
	if event.is_action_pressed("inventory"):
		if inventory_ui.visible:
			inventory_ui.visible = false
		else :
			inventory_ui.visible = true

func _simulate_item_pickup():
	var item = Item.new()
	item.name = "Test Item"  # For testing; change as needed
	item_pickup._on_item_picked(item)

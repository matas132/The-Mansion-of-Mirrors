class_name  Player
extends CharacterBody2D

@export var speed: float = 500.0


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("down"):
		velocity.y += 1
		rotation_degrees = 0
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		rotation_degrees = 180
	if Input.is_action_pressed("right"):
		velocity.x += 1
		rotation_degrees = 270
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		rotation_degrees = 90
		
#	if velocity.length() > 0: 
		#velocity = velocity.normalized() * speed 
		#move_and_slide()
	
	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
		#$AnimatedSprite2D.play()
	else:
		#$AnimatedSprite2D.stop()
		pass
	
	position += velocity * delta


@onready var player: Player = $"."
# putting my things here cuz we're using your movement
var interactive_area : InteractiveArea
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if interactive_area != null:
			interactive_area.interact(player)

func _on_area_2d_area_entered(area: Area2D) -> void: # the interactable Area
	if area is InteractiveArea:
		interactive_area = area

func _on_area_2d_area_exited(area: Area2D) -> void: # exiting the interactable Area
	if area is InteractiveArea:
		interactive_area = null

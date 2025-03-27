extends Node2D

@onready var player: Player = $Player
@onready var cow: CharacterBody2D = $Cow

func _ready() -> void:
	call_deferred("character_setup")
	
func character_setup() -> void:
	await get_tree().physics_frame
	
	Input.action_press("walk_right")
	await get_tree().create_timer(3.0).timeout
	Input.action_release("walk_right")
	

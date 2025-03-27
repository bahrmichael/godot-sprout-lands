extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scene = preload("res://scenes/objects/trees/log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	(material as ShaderMaterial).set_shader_parameter("shake_intensity", 0.5)
	await get_tree().create_timer(1.0).timeout
	(material as ShaderMaterial).set_shader_parameter("shake_intensity", 0.0)

func on_max_damage_reached() -> void:
	call_deferred("add_log_scene")
	queue_free()
	
func add_log_scene() -> void:
	var log_instance_1 = log_scene.instantiate() as Node2D
	log_instance_1.global_position = global_position
	get_parent().add_child(log_instance_1)
	
	var log_instance_2 = log_scene.instantiate() as Node2D
	log_instance_2.global_position = Vector2(global_position.x + 5, global_position.y + 3)
	get_parent().add_child(log_instance_2)

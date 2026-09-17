extends CharacterBody2D

@export var speed: float = 120.0
@export var min_x: float = 55.0
@export var max_x: float = 585.0

# Não tipar como Sprite2D: o nó usa player_visual.gd e expõe métodos próprios.
@onready var visual = $Visual

var facing: int = 1
var action_locked: bool = false
var blocking: bool = false

func _physics_process(_delta: float) -> void:
    var axis: float = 0.0
    if not action_locked and not blocking:
        axis = Input.get_axis("move_left", "move_right")

    if absf(axis) > 0.01:
        facing = 1 if axis > 0.0 else -1
        visual.set_facing(facing)

    velocity = Vector2(axis * speed, 0.0)
    move_and_slide()
    global_position.x = clampf(global_position.x, min_x, max_x)
    visual.set_locomotion(absf(axis) > 0.01)

func set_action_locked(value: bool) -> void:
    action_locked = value
    if value:
        velocity.x = 0.0

func set_blocking(value: bool) -> void:
    blocking = value
    if value:
        velocity.x = 0.0

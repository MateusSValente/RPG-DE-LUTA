extends CharacterBody2D

@export var speed := 150.0
@export var min_x := 55.0
@export var max_x := 585.0

@onready var visual: Sprite2D = $Visual

var facing := 1
var action_locked := false
var blocking := false

func _physics_process(_delta: float) -> void:
    var axis := 0.0
    if not action_locked and not blocking:
        axis = Input.get_axis("move_left", "move_right")
    if abs(axis) > 0.01:
        facing = 1 if axis > 0.0 else -1
        visual.set_facing(facing)
    velocity = Vector2(axis * speed, 0.0)
    move_and_slide()
    global_position.x = clamp(global_position.x, min_x, max_x)
    visual.set_locomotion(abs(axis) > 0.01)

func set_action_locked(value: bool) -> void:
    action_locked = value
    if value:
        velocity.x = 0.0

func set_blocking(value: bool) -> void:
    blocking = value
    if value:
        velocity.x = 0.0

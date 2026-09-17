extends Node

@onready var player = get_parent()
@onready var visual = get_parent().get_node("Visual")

var active := false
var timer := 0.0
var hit_at := 0.0
var hit_done := false
var damage := 0
var reach := 0.0

func _process(delta: float) -> void:
    if active:
        timer -= delta
        if not hit_done and timer <= hit_at:
            hit_done = true
            _apply_hit()
        if timer <= 0.0:
            active = false
            player.set_action_locked(false)
        return

    var wants_block := Input.is_action_pressed("block")
    player.set_blocking(wants_block)
    visual.set_blocking(wants_block)
    if wants_block:
        return

    if Input.is_action_just_pressed("light_attack"):
        _start_attack("light", 0.30, 0.18, 18, 105.0)
    elif Input.is_action_just_pressed("heavy_attack"):
        _start_attack("heavy", 0.55, 0.33, 36, 122.0)

func _start_attack(name: String, duration: float, hit_remaining: float, amount: int, attack_reach: float) -> void:
    active = true
    timer = duration
    hit_at = hit_remaining
    hit_done = false
    damage = amount
    reach = attack_reach
    player.set_action_locked(true)
    visual.play_action(name)

func _apply_hit() -> void:
    for target in get_tree().get_nodes_in_group("damageable"):
        if not target.has_method("take_hit"):
            continue
        var dx: float = target.global_position.x - player.global_position.x
        if sign(dx) != player.facing and abs(dx) > 18.0:
            continue
        if abs(dx) <= reach:
            target.take_hit(damage, player.facing)

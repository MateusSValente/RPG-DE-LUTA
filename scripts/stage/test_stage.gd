extends Node2D

func _ready() -> void:
    _ensure_key_action("move_left", KEY_A)
    _ensure_key_action("move_right", KEY_D)
    _ensure_key_action("light_attack", KEY_J)
    _ensure_key_action("heavy_attack", KEY_K)
    _ensure_key_action("block", KEY_L)
    _ensure_key_action("reset_dummy", KEY_R)

func _ensure_key_action(action: StringName, physical_key: Key) -> void:
    if not InputMap.has_action(action):
        InputMap.add_action(action)
    for existing in InputMap.action_get_events(action):
        if existing is InputEventKey and existing.physical_keycode == physical_key:
            return
    var event := InputEventKey.new()
    event.physical_keycode = physical_key
    InputMap.action_add_event(action, event)

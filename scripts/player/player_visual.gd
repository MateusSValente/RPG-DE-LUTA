extends Sprite2D

signal action_finished(action_name: String)

const BASELINE_OFFSET := Vector2(0, -52)
const SIM_TICK_SECONDS := 1.0 / 60.0

const STRIP_PATHS := {
    "idle": "res://assets/characters/durotar/idle.png",
    "walk": "res://assets/characters/durotar/walk.png",
    "light": "res://assets/characters/durotar/light.png",
}

const SINGLE_PATHS := {
    "heavy": [
        "res://assets/characters/durotar/heavy_00.png",
        "res://assets/characters/durotar/heavy_01.png",
        "res://assets/characters/durotar/heavy_02.png",
        "res://assets/characters/durotar/heavy_03.png",
    ],
    "block": [
        "res://assets/characters/durotar/block_00.png",
        "res://assets/characters/durotar/block_01.png",
        "res://assets/characters/durotar/block_02.png",
    ],
}

const FRAME_COUNTS := {
    "idle": 4,
    "walk": 8,
    "light": 3,
    "heavy": 4,
    "block": 3,
}

# WALK_V2 usa timing autoral por frame definido no WALK_V2_SPEC.
# As demais animações continuam em fallback FPS até receberem seus próprios specs V2.
const FRAME_HOLDS_TICKS := {
    "walk": [4, 3, 4, 3, 4, 3, 4, 3],
}

const FALLBACK_FPS := {
    "idle": 4.0,
    "light": 12.0,
    "heavy": 8.0,
    "block": 10.0,
}

var strip_textures: Dictionary = {}
var single_textures: Dictionary = {}
var state: String = "idle"
var frame_cursor: int = 0
var frame_time: float = 0.0
var one_shot: bool = false
var blocking: bool = false
var facing: int = 1

func _ready() -> void:
    texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
    centered = true
    position = BASELINE_OFFSET
    scale = Vector2.ONE

    for key in STRIP_PATHS.keys():
        var loaded_strip := load(STRIP_PATHS[key]) as Texture2D
        if loaded_strip == null:
            push_error("Falha ao carregar sprite strip: " + STRIP_PATHS[key])
        strip_textures[key] = loaded_strip

    for key in SINGLE_PATHS.keys():
        var frames: Array[Texture2D] = []
        for path in SINGLE_PATHS[key]:
            var loaded_frame := load(path) as Texture2D
            if loaded_frame == null:
                push_error("Falha ao carregar sprite frame: " + path)
            frames.append(loaded_frame)
        single_textures[key] = frames

    _apply_frame()

func _process(delta: float) -> void:
    if blocking and state == "block":
        if frame_cursor == 0:
            frame_time += delta
            if frame_time >= 0.10:
                frame_cursor = 1
                frame_time = 0.0
                _apply_frame()
        return

    frame_time += delta
    var step := _current_frame_duration()
    if frame_time < step:
        return

    frame_time -= step
    frame_cursor += 1
    var count: int = int(FRAME_COUNTS[state])

    if frame_cursor >= count:
        if one_shot:
            var completed: String = state
            one_shot = false
            state = "idle"
            frame_cursor = 0
            action_finished.emit(completed)
        else:
            frame_cursor = 0

    _apply_frame()

func _current_frame_duration() -> float:
    if FRAME_HOLDS_TICKS.has(state):
        var holds: Array = FRAME_HOLDS_TICKS[state]
        var safe_index := clampi(frame_cursor, 0, holds.size() - 1)
        return float(holds[safe_index]) * SIM_TICK_SECONDS

    return 1.0 / float(FALLBACK_FPS.get(state, 8.0))

func set_facing(direction: int) -> void:
    facing = 1 if direction >= 0 else -1
    flip_h = facing < 0

func set_locomotion(is_moving: bool) -> void:
    if one_shot or blocking:
        return
    var wanted: String = "walk" if is_moving else "idle"
    if wanted == state:
        return
    state = wanted
    frame_cursor = 0
    frame_time = 0.0
    _apply_frame()

func play_action(action_name: String) -> void:
    if not FRAME_COUNTS.has(action_name):
        push_warning("Animação desconhecida: " + action_name)
        return
    blocking = false
    state = action_name
    frame_cursor = 0
    frame_time = 0.0
    one_shot = true
    _apply_frame()

func set_blocking(value: bool) -> void:
    if one_shot and state != "block":
        return
    if value == blocking and ((value and state == "block") or (not value and state != "block")):
        return

    blocking = value
    state = "block" if value else "idle"
    frame_cursor = 0
    frame_time = 0.0
    one_shot = false
    _apply_frame()

func _apply_frame() -> void:
    flip_h = facing < 0

    if STRIP_PATHS.has(state):
        var atlas: Texture2D = strip_textures.get(state) as Texture2D
        if atlas == null:
            return
        var frame := AtlasTexture.new()
        frame.atlas = atlas
        frame.region = Rect2(frame_cursor * 128, 0, 128, 128)
        texture = frame
        return

    if SINGLE_PATHS.has(state):
        var frames: Array = single_textures.get(state, [])
        if frame_cursor >= 0 and frame_cursor < frames.size():
            texture = frames[frame_cursor] as Texture2D

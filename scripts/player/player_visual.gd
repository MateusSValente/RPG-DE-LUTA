extends Sprite2D

signal action_finished(action_name: String)

const SHEET_PATH: String = "res://docs/art/reference/durotar/DUROTAR_MASTER_V1_REFERENCE.webp"
const DISPLAY_SCALE: float = 0.42

# region = crop na prancha canônica; anchor = ponto dos pés dentro do crop.
const FRAME_DATA: Array[Dictionary] = [
    {"region": Rect2(20,55,170,260), "anchor": Vector2(85,253)},
    {"region": Rect2(195,55,175,260), "anchor": Vector2(87,253)},
    {"region": Rect2(380,55,170,260), "anchor": Vector2(82,253)},
    {"region": Rect2(565,55,185,260), "anchor": Vector2(81,253)},
    {"region": Rect2(785,55,175,260), "anchor": Vector2(90,253)},
    {"region": Rect2(960,55,185,260), "anchor": Vector2(93,253)},
    {"region": Rect2(1140,55,188,260), "anchor": Vector2(97,253)},
    {"region": Rect2(1325,55,205,260), "anchor": Vector2(102,253)},
    {"region": Rect2(18,430,237,245), "anchor": Vector2(117,239)},
    {"region": Rect2(245,430,280,245), "anchor": Vector2(120,239)},
    {"region": Rect2(515,430,240,245), "anchor": Vector2(105,239)},
    {"region": Rect2(775,405,165,275), "anchor": Vector2(70,269)},
    {"region": Rect2(900,400,275,280), "anchor": Vector2(110,274)},
    {"region": Rect2(1120,420,225,260), "anchor": Vector2(90,254)},
    {"region": Rect2(1320,430,210,250), "anchor": Vector2(108,244)},
    {"region": Rect2(28,760,192,238), "anchor": Vector2(97,227)},
    {"region": Rect2(250,760,225,238), "anchor": Vector2(120,227)},
    {"region": Rect2(500,755,220,243), "anchor": Vector2(110,232)},
]

const FRAME_INDEX: Dictionary = {
    "idle": [0,1,2,3],
    "walk": [4,5,6,7],
    "light": [8,9,10],
    "heavy": [11,12,13,14],
    "block": [15,16,17],
}

const FPS: Dictionary = {
    "idle": 4.0,
    "walk": 8.0,
    "light": 12.0,
    "heavy": 8.0,
    "block": 10.0,
}

var sheet: Texture2D
var state: String = "idle"
var frame_cursor: int = 0
var frame_time: float = 0.0
var one_shot: bool = false
var blocking: bool = false
var facing: int = 1

func _ready() -> void:
    sheet = load(SHEET_PATH) as Texture2D
    if sheet == null:
        push_error("DUROTAR_MASTER_V1 não pôde ser carregado: " + SHEET_PATH)
        return
    centered = true
    texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
    scale = Vector2(DISPLAY_SCALE, DISPLAY_SCALE)
    _install_transparency_shader()
    _apply_frame()

func _process(delta: float) -> void:
    if sheet == null:
        return

    if blocking and state == "block":
        if frame_cursor == 0:
            frame_time += delta
            if frame_time >= 0.10:
                frame_cursor = 1
                frame_time = 0.0
                _apply_frame()
        return

    var frames: Array = FRAME_INDEX.get(state, [])
    if frames.is_empty():
        return

    frame_time += delta
    var fps_value: float = float(FPS.get(state, 1.0))
    var step: float = 1.0 / maxf(fps_value, 0.001)
    if frame_time < step:
        return

    frame_time -= step
    frame_cursor += 1
    if frame_cursor >= frames.size():
        if one_shot:
            var completed: String = state
            one_shot = false
            state = "idle"
            frame_cursor = 0
            action_finished.emit(completed)
        else:
            frame_cursor = 0
    _apply_frame()

func set_facing(direction: int) -> void:
    facing = 1 if direction >= 0 else -1
    _apply_frame()

func set_locomotion(is_moving: bool) -> void:
    if one_shot or blocking:
        return
    var wanted: String = "walk" if is_moving else "idle"
    if wanted != state:
        state = wanted
        frame_cursor = 0
        frame_time = 0.0
        _apply_frame()

func play_action(action_name: String) -> void:
    if not FRAME_INDEX.has(action_name):
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
    if blocking == value and ((value and state == "block") or (not value and state == "idle")):
        return
    blocking = value
    state = "block" if value else "idle"
    frame_cursor = 0
    frame_time = 0.0
    one_shot = false
    _apply_frame()

func _apply_frame() -> void:
    if sheet == null:
        return

    var frames: Array = FRAME_INDEX.get(state, [])
    if frames.is_empty():
        return

    var safe_cursor: int = clampi(frame_cursor, 0, frames.size() - 1)
    var idx: int = int(frames[safe_cursor])
    if idx < 0 or idx >= FRAME_DATA.size():
        push_error("Índice de frame inválido: %d" % idx)
        return

    var data: Dictionary = FRAME_DATA[idx]
    var region: Rect2 = data["region"]
    var anchor: Vector2 = data["anchor"]

    var tex: AtlasTexture = AtlasTexture.new()
    tex.atlas = sheet
    tex.region = region
    texture = tex
    flip_h = facing < 0

    var frame_size: Vector2 = region.size
    var local_anchor: Vector2 = anchor - frame_size * 0.5
    var correction: Vector2 = -local_anchor * DISPLAY_SCALE
    if flip_h:
        correction.x = -correction.x
    position = correction

func _install_transparency_shader() -> void:
    # A prancha aprovada possui fundo visual preto. No runtime apenas pixels do fundo
    # quase pretos são descartados; cabelo/barba/outline permanecem por estarem acima do limiar.
    var shader: Shader = Shader.new()
    shader.code = "shader_type canvas_item;\nvoid fragment(){ vec4 c=texture(TEXTURE,UV); float m=max(max(c.r,c.g),c.b); if(m < 0.022){ discard; } COLOR=c; }"
    var mat: ShaderMaterial = ShaderMaterial.new()
    mat.shader = shader
    material = mat

extends Node2D

@export var max_health := 100
var health := 100
var flash := 0.0
var knock := 0.0

func _ready() -> void:
    health = max_health
    add_to_group("damageable")
    queue_redraw()

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("reset_dummy"):
        health = max_health
        flash = 0.0
        knock = 0.0
        queue_redraw()
    if flash > 0.0:
        flash -= delta
        queue_redraw()
    knock = move_toward(knock, 0.0, delta * 80.0)
    queue_redraw()

func take_hit(amount: int, direction: int) -> void:
    health = max(0, health - amount)
    flash = 0.10
    knock = 8.0 * direction
    queue_redraw()

func _draw() -> void:
    var x := knock
    var wood := Color("8b5d34")
    var dark := Color("3a281d")
    var straw := Color("b99a63")
    var red := Color("a52d2d")
    var hit_color := Color("f3d39a") if flash > 0.0 else straw
    draw_rect(Rect2(x - 4, -72, 8, 72), wood)
    draw_rect(Rect2(x - 20, -74, 40, 48), hit_color)
    draw_rect(Rect2(x - 28, -60, 56, 7), wood)
    draw_circle(Vector2(x, -50), 12.0, red)
    draw_circle(Vector2(x, -50), 6.0, hit_color)
    draw_line(Vector2(x - 20, -74), Vector2(x - 20, -26), dark, 2.0)
    draw_line(Vector2(x + 20, -74), Vector2(x + 20, -26), dark, 2.0)
    draw_rect(Rect2(-22, -94, 44, 5), Color("181818"))
    var hp_w := 44.0 * float(health) / float(max_health)
    draw_rect(Rect2(-22, -94, hp_w, 5), Color("c83b32"))
    if health <= 0:
        draw_string(ThemeDB.fallback_font, Vector2(-28, -104), "KO - R reinicia", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, Color.WHITE)

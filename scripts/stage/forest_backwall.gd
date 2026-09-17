extends Node2D

func _ready() -> void:
    queue_redraw()

func _draw() -> void:
    # Backwall independente: céu, montanhas, floresta distante e castelo.
    draw_rect(Rect2(0,0,640,360), Color("101827"))
    draw_rect(Rect2(0,92,640,268), Color("18263a"))

    draw_circle(Vector2(500,66), 34, Color("8b2d28"))
    draw_circle(Vector2(492,60), 29, Color("a23b31"))

    draw_colored_polygon(PackedVector2Array([Vector2(0,188),Vector2(95,96),Vector2(175,177),Vector2(270,80),Vector2(380,184),Vector2(500,105),Vector2(640,185),Vector2(640,245),Vector2(0,245)]), Color("26364b"))
    draw_colored_polygon(PackedVector2Array([Vector2(0,215),Vector2(120,135),Vector2(230,211),Vector2(345,121),Vector2(470,216),Vector2(570,150),Vector2(640,202),Vector2(640,265),Vector2(0,265)]), Color("1e2d3c"))

    for x in range(0,641,18):
        var h := 24 + int((x * 17) % 31)
        var base_y := 268
        draw_colored_polygon(PackedVector2Array([Vector2(x,base_y),Vector2(x+8,base_y-h),Vector2(x+16,base_y)]), Color("142923"))

    draw_colored_polygon(PackedVector2Array([Vector2(420,218),Vector2(454,188),Vector2(548,183),Vector2(585,220),Vector2(585,273),Vector2(420,273)]), Color("283039"))
    _castle(Vector2(474,112))
    draw_rect(Rect2(0,258,640,22), Color(0.12,0.17,0.20,0.55))

func _castle(origin: Vector2) -> void:
    var stone := Color("343741")
    var dark := Color("20242d")
    var fire := Color("c96a31")
    draw_rect(Rect2(origin.x,origin.y+35,92,66), stone)
    draw_rect(Rect2(origin.x+18,origin.y+10,22,91), stone)
    draw_rect(Rect2(origin.x+55,origin.y,24,101), stone)
    draw_colored_polygon(PackedVector2Array([Vector2(origin.x+15,origin.y+10),Vector2(origin.x+29,origin.y-15),Vector2(origin.x+43,origin.y+10)]), dark)
    draw_colored_polygon(PackedVector2Array([Vector2(origin.x+52,origin.y),Vector2(origin.x+67,origin.y-28),Vector2(origin.x+82,origin.y)]), dark)
    for p in [Vector2(origin.x+27,origin.y+38),Vector2(origin.x+64,origin.y+31),Vector2(origin.x+12,origin.y+62),Vector2(origin.x+83,origin.y+63)]:
        draw_rect(Rect2(p.x,p.y,4,7), fire)

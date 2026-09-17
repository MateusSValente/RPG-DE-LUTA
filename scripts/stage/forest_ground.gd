extends Node2D

func _ready() -> void:
    queue_redraw()

func _draw() -> void:
    # Ground independente. A linha Y=300 é a baseline lógica do teste.
    draw_rect(Rect2(0,300,640,60), Color("302a25"))
    draw_rect(Rect2(0,294,640,8), Color("4e5b32"))
    draw_rect(Rect2(0,302,640,30), Color("655442"))

    var stone_a := Color("77634a")
    var stone_b := Color("584b3d")
    var seam := Color("302a26")
    for row in range(3):
        var y := 304 + row * 10
        var offset := -8 if row % 2 == 1 else 0
        for col in range(22):
            var x := offset + col * 31
            var w := 27
            draw_rect(Rect2(x,y,w,8), stone_a if (row+col)%3==0 else stone_b)
            draw_line(Vector2(x,y+8),Vector2(x+w,y+8),seam,1)
            draw_line(Vector2(x+w,y),Vector2(x+w,y+8),seam,1)

    draw_rect(Rect2(0,334,640,26), Color("211e1c"))
    for x in range(0,640,16):
        var h := 3 + (x * 13) % 7
        draw_rect(Rect2(x,334,10,h), Color("3a332c"))

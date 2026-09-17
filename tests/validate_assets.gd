extends SceneTree

func _init() -> void:
    var expected := {
        "res://assets/characters/durotar/idle.png": Vector2i(512, 128),
        "res://assets/characters/durotar/walk.png": Vector2i(1024, 128),
        "res://assets/characters/durotar/light.png": Vector2i(384, 128),
        "res://assets/characters/durotar/heavy_00.png": Vector2i(128, 128),
        "res://assets/characters/durotar/heavy_01.png": Vector2i(128, 128),
        "res://assets/characters/durotar/heavy_02.png": Vector2i(128, 128),
        "res://assets/characters/durotar/heavy_03.png": Vector2i(128, 128),
        "res://assets/characters/durotar/block_00.png": Vector2i(128, 128),
        "res://assets/characters/durotar/block_01.png": Vector2i(128, 128),
        "res://assets/characters/durotar/block_02.png": Vector2i(128, 128),
        "res://assets/stages/forest_test/backwall.webp": Vector2i(640, 300),
        "res://assets/stages/forest_test/ground.webp": Vector2i(640, 80),
    }

    var failed := false
    for path in expected.keys():
        var resource := ResourceLoader.load(path)
        if resource == null or not (resource is Texture2D):
            push_error("ASSET_LOAD_FAIL: " + path)
            failed = true
            continue
        var texture := resource as Texture2D
        var actual := Vector2i(texture.get_width(), texture.get_height())
        if actual != expected[path]:
            push_error("ASSET_SIZE_FAIL: %s expected=%s actual=%s" % [path, expected[path], actual])
            failed = true
        else:
            print("ASSET_OK: ", path, " size=", actual)

    var scene := load("res://scenes/demo/test_stage.tscn") as PackedScene
    if scene == null:
        push_error("SCENE_LOAD_FAIL")
        failed = true
    else:
        var instance := scene.instantiate()
        var backwall := instance.get_node_or_null("Backwall") as Sprite2D
        var ground := instance.get_node_or_null("Ground") as Sprite2D
        if backwall == null or backwall.texture == null:
            push_error("SCENE_BACKWALL_TEXTURE_FAIL")
            failed = true
        if ground == null or ground.texture == null:
            push_error("SCENE_GROUND_TEXTURE_FAIL")
            failed = true
        instance.free()

    quit(1 if failed else 0)

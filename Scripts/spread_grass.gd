@tool
extends Node3D

func _ready():
    if not Engine.is_editor_hint():
        return

    var grass = get_node("../SimpleGrassTextured")
    var landscape = get_node("../Landscape")
    if not grass or not landscape:
        printerr("spread_grass: Could not find SimpleGrassTextured or Landscape")
        queue_free()
        return

    var static_body = landscape.get_node("StaticBody3D")
    if not static_body:
        printerr("spread_grass: No StaticBody3D found")
        queue_free()
        return
    var collision = static_body.get_node("CollisionShape3D")
    if not collision or not collision.shape:
        printerr("spread_grass: No CollisionShape3D found")
        queue_free()
        return

    var shape = collision.shape as ConcavePolygonShape3D
    if not shape:
        printerr("spread_grass: Shape is not ConcavePolygonShape3D")
        queue_free()
        return

    var sgt_scale_val = grass.get("sgt_scale", 1.0)
    var sgt_rotation = grass.get("sgt_rotation", 0.0)
    var sgt_rotation_rand = grass.get("sgt_rotation_rand", 1.0)
    var sgt_follow_normal = grass.get("sgt_follow_normal", false)
    var sgt_slope = grass.get("sgt_slope", Vector2(0, 45))
    var sgt_dist_min = grass.get("sgt_dist_min", 0.25)

    var land_trans = landscape.global_transform
    var faces = shape.get_faces()

    grass.clear_all()

    var spacing = 8.0
    var count = 0
    var total_tri = faces.size() / 3

    print("spread_grass: total triangles = " + str(total_tri))

    for i in range(total_tri):
        var idx = i * 3
        var v0 = land_trans * faces[idx]
        var v1 = land_trans * faces[idx + 1]
        var v2 = land_trans * faces[idx + 2]

        var e1 = v1 - v0
        var e2 = v2 - v0
        var n = e1.cross(e2).normalized()

        var slope_deg = rad_to_deg(n.angle_to(Vector3.UP))
        if slope_deg < sgt_slope.x or slope_deg > sgt_slope.y:
            continue

        var area = e1.cross(e2).length() * 0.5
        var num = maxi(1, int(area / (spacing * spacing)))

        for j in range(num):
            var r1 = randf()
            var r2 = randf()
            if r1 + r2 > 1.0:
                r1 = 1.0 - r1
                r2 = 1.0 - r2

            var pos = v0 + r1 * e1 + r2 * e2
            var local_pos = grass.to_local(pos)
            var gn = n if sgt_follow_normal else Vector3.UP

            grass.add_grass(
                local_pos,
                gn,
                Vector3(sgt_scale_val, sgt_scale_val, sgt_scale_val),
                deg_to_rad(sgt_rotation) + (PI * (sgt_rotation_rand - (randf() * sgt_rotation_rand * 2.0)))
            )
            count += 1

        if i % 100 == 0:
            await get_tree().process_frame

    print("spread_grass: added " + str(count) + " instances")

    await get_tree().process_frame
    await get_tree().process_frame

    var final_count = grass.multimesh.instance_count if grass.multimesh else 0
    print("spread_grass: final multimesh count = " + str(final_count))
    queue_free()

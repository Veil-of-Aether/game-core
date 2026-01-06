extends ActionLeaf

var walkSpeed := 3.0
var arriveRadius := 0.6

func tick(actor, blackboard):
    var target = blackboard.get("wander_target", null)
    if target == null:
        return FAILURE

    # If avoid steering exists, prefer that for a frame
    var avoid = null
    if blackboard.has("avoid_direction"):
        avoid = blackboard.get("avoid_direction")
        # apply a quick fade so it doesn't persist indefinitely
        blackboard.set("avoid_direction", null)

    var dir = (target - actor.global_transform.origin)
    dir.y = 0
    if dir.length() < arriveRadius:
        return SUCCESS

    dir = dir.normalized()
    if avoid != null:
        # combine wander dir and avoidance (weighted)
        dir = (dir * 0.6 + avoid * 1.4).normalized()

    var velocity = actor.velocity
    velocity.x = dir.x * walkSpeed
    velocity.z = dir.z * walkSpeed
    actor.velocity = velocity
    actor.move_and_slide()
    return RUNNING

@icon("../../icons/action.svg")

extends ActionLeaf

var avoidSpeed := 5.0
var stopDistance := 4.0

func tick(actor, blackboard):
    var detector = actor.get_node("playerDetector")
    if detector == null:
        return FAILURE
    var bodies = detector.get_overlapping_bodies()
    var player = null
    for b in bodies:
        if b.is_in_group("player"):
            player = b
            break
    if player == null:
        return FAILURE

    # compute direction away from player
    var away = (actor.global_transform.origin - player.global_transform.origin)
    away.y = 0
    var dist = away.length()
    if dist < 0.001:
        away = Vector3(randf() - 0.5, 0, randf() - 0.5)

    away = away.normalized()

    # store steering info so WanderAction or MoveAction can use it if desired
    blackboard.set("avoid_direction", away)

    # apply simple movement (directly set velocity for short-term avoidance)
    var velocity = actor.velocity
    velocity.x = away.x * avoidSpeed
    velocity.z = away.z * avoidSpeed
    actor.velocity = velocity
    actor.move_and_slide()

    # keep running while player is close
    if dist < stopDistance:
        return RUNNING
    return SUCCESS

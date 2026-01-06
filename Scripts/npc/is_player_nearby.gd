@icon("../../icons/condition.svg")

extends ConditionLeaf

func tick(actor, _blackboard):
    var detector = actor.get_node("CharacterDetector")
    if detector == null:
        return FAILURE
    var bodies = detector.get_overlapping_bodies()
    for b in bodies:
        if b.is_in_group("player"):
            return SUCCESS
    return FAILURE

class_name Raycast2D

static func raycastPos(node, from, to, mask):
    var space = node.get_world_2d().direct_space_state
    var params = PhysicsRayQueryParameters2D.create(from, to, mask)
    var result = space.intersect_ray(params)
    if result:
        return result.position
    return to

static func raycast(node, from, to, mask):
    var space = node.get_world_2d().direct_space_state
    var params = PhysicsRayQueryParameters2D.create(from, to, mask)
    var result = space.intersect_ray(params)
    if result: return {
                "hit": true,
                "position": result.position
                }
    return {
                "hit": false,
                "position": to
            }

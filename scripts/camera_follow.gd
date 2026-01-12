extends Camera3D

@export var object_to_follow: PhysicsBody3D


func _process(delta: float) -> void:
	position = Vector3(object_to_follow.position.x, position.y, object_to_follow.position.z)

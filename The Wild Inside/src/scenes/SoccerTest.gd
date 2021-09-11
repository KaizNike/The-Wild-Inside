extends Spatial

onready var positions = [$Spawn/SpawnPlatform/Position3D]

func _physics_process(delta):
	for node in $Players.get_children():
		if node.translation.y < -200:
			print("NOW!")
			node.global_transform = positions[node.player].global_transform
		pass

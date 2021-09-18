extends Spatial

onready var positions = [$Spawn/SpawnPlatform/Position3D, $Spawn/SpawnPlatform2/Position3D, $Spawn/SpawnPlatform3/Position3D, $Spawn/SpawnPlatform4/Position3D, $Spawn/SpawnPlatform5/Position3D, $Spawn/SpawnPlatform6/Position3D, $Spawn/SpawnPlatform7/Position3D, $Spawn/SpawnPlatform8/Position3D]

func _ready():
	$Music/TOOINTENSEMP3.play()

func _physics_process(delta):
	for node in $Players.get_children():
		if node.translation.y < -200:
			print("NOW!")
			node.global_transform = positions[node.player].global_transform
	if $Arena/LightBall.translation.y < -200:
		print("ALL TEAMS LOSE!")
		$Arena/LightBall.global_transform = $Arena/Position3D/.global_transform

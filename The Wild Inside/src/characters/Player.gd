extends KinematicBody

var camLookChange = 0.10

onready var tree = $AnimationTree

var dir = Vector3.ZERO
var speed = 600
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input_event(camera, event, click_position, click_normal, shape_idx):
	
	
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:
		# Look Down
		if event.relative.y > 0:
			tree["parameters/camlookUPDOWN/blend_position"] -= camLookChange
#			print('down')
			pass
		# Look Up
		if event.relative.y < 0:
			tree["parameters/camlookUPDOWN/blend_position"] += camLookChange
#			print("up")
			pass
		# Turn Left
		if event.relative.x > 0:
			print(get_transform().basis.x)
			tree["parameters/turnLEFTRIGHT/blend_position"] += camLookChange
			
		# Turn Right
		if event.relative.x < 0:
			tree["parameters/turnLEFTRIGHT/blend_position"] -= camLookChange


func _physics_process(delta):
	dir = _get_direction()
	dir = dir.normalized()
	dir *= speed * delta
	move_and_slide(dir, Vector3.UP)

func _get_direction() -> Vector3:
	return Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	

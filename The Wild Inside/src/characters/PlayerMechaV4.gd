extends KinematicBody

export var speed : float = 20
export var accel : float = 15
export var air_accel : float = 5
export var gravity : float = 0.98
export var max_terminal_velocity : float = 54
export var jump_power : float = 108

export(float, 0.1, 1) var mouse_sens : float = 0.3
export(float, -90, 0) var min_pitch : float = -90
export(float, 0, 90) var max_pitch : float = 90

var velocity = Vector3()
var y_velocity : float
var falling = false

var player = 0
var team = 1

onready var cam_pivot = $CamPivot
onready var cam = $CamPivot/CamBoom/Camera
onready var state_machine = $AnimationTree.get("parameters/playback")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if not is_on_floor():
		falling = true
#	state_machine = $AnimationTree.get("parameters/playback")
	
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sens
		cam_pivot.rotation_degrees.x -= event.relative.y * mouse_sens
		cam_pivot.rotation_degrees.x = clamp(cam_pivot.rotation_degrees.x, min_pitch, max_pitch)

func _physics_process(delta):
	_handle_movement(delta)
#	print(translation.y)
	
func _handle_movement(delta):
	var dir = Vector3.ZERO
#	print("Started")
	if Input.is_action_pressed("move_forward"):
		dir -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		dir += transform.basis.z
	if Input.is_action_pressed("move_left"):
		dir -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		dir += transform.basis.x
		
	dir = dir.normalized()
#	print(dir)
	var Accel = accel if is_on_floor() else air_accel
	velocity = velocity.linear_interpolate(dir * speed, accel * delta)
#	print(velocity.x)
#		lerp(velocity, dir * speed, Accel * delta)
	if is_on_floor():
		y_velocity = -0.01
	else:
		y_velocity = clamp(y_velocity - gravity, -max_terminal_velocity, max_terminal_velocity)
#	print(y_velocity)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		y_velocity = jump_power
		
	velocity.y = y_velocity
#	print(velocity)
	_handle_animation(velocity)
	velocity = move_and_slide(velocity, Vector3.UP)
	y_velocity = velocity.y

func _handle_animation(vel):
	if vel.y > 0 and is_on_floor() and not falling:
		falling = true
		print("NoW JUMP!")
		state_machine.travel("Backward Jump")
		$SFX/Jump.play()
		return
	elif falling and is_on_floor():
		falling = false
		state_machine.travel("Landing")
		$SFX/Land.play()
#	if not is_equal_approx(vel.x, 0.0):
#		print(vel.x)
	elif (not is_equal_approx(vel.x,0.0) and is_on_floor()) or (not is_equal_approx(vel.z,0) and is_on_floor()):
#		print(vel)
#		print("Walk")
		state_machine.travel("Walking Forward")
	elif not is_on_floor() and falling:
		return
	else:
#		print("Idle")
		state_machine.travel("Idle")

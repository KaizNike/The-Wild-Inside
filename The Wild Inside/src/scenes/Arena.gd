extends Spatial



func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		print("OK!")
		$LightBall.gravity_scale = 1
		$LightBall.apply_impulse(Vector3(), Vector3(0,-1,0))

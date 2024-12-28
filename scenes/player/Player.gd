extends RigidBody3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Moving obj
	if Input.is_action_pressed("ui_accept"):
		apply_central_force(basis.y * delta * 1000)
		
	if Input.is_action_pressed("ui_left"):
		# moment obrotowty
		apply_torque(Vector3(0.0,0.0,100.0 * delta))
		
	if Input.is_action_pressed("ui_right"):
		apply_torque(Vector3(0.0,0.0,100.0 * (-delta)))

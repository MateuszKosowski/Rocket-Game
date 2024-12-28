extends RigidBody3D

# Export make variable avaiable in inspector, ## make dosc
## How much vertical force to applay when moving.
@export_range(100,2000) var thrust: int = 1000
@export var torque_thrust: float = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Moving obj
	if Input.is_action_pressed("Up"):
		apply_central_force(basis.y * delta * thrust)
		
	if Input.is_action_pressed("Left"):
		# moment obrotowty
		apply_torque(Vector3(0.0,0.0,torque_thrust * delta))
		
	if Input.is_action_pressed("Right"):
		apply_torque(Vector3(0.0,0.0,torque_thrust * (-delta)))


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Win"):
		complete_lvl()
		
	elif body.is_in_group("Lose"):
		rocket_crash()
		
		
func rocket_crash() -> void:
	print("BOOOM!")
	get_tree().reload_current_scene()
	
func complete_lvl() -> void:
	print("You win")
	get_tree().quit()
	
	

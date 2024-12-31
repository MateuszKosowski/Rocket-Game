extends RigidBody3D

# Export make variable avaiable in inspector, ## make dosc
## How much vertical force to applay when moving.
@export_range(100,2000) var thrust: int = 1000
@export var torque_thrust: float = 100.0

var is_transitioning: bool = false

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
	if is_transitioning == false:
		if body.is_in_group("Win"):
			complete_lvl(body.next_file_path)
			
		elif body.is_in_group("Lose"):
			rocket_crash()
		
func rocket_crash() -> void:
	print("BOOOM!")
	
	#Disables the fun _process
	set_process(false)
	is_transitioning = true
	
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_lvl(next_level: String) -> void:
	print("You win")
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level))
	

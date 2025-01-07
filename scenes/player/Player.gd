extends RigidBody3D

# Export make variable avaiable in inspector, ## make dosc
## How much vertical force to applay when moving.
@export_range(100,2000) var thrust: int = 1000
@export var torque_thrust: float = 100.0

var is_transitioning: bool = false

@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var win_audio: AudioStreamPlayer = $WinAudio
@onready var fly_audio: AudioStreamPlayer3D = $FlyAudio
@onready var engine_particles: GPUParticles3D = $MainBooster
@onready var right_engine_particles: GPUParticles3D = $RightBooster
@onready var left_engine_particles: GPUParticles3D = $LeftBooster

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Moving obj
	if Input.is_action_pressed("Up"):
		apply_central_force(basis.y * delta * thrust)
		if fly_audio.playing == false:
			fly_audio.play()
		engine_particles.emitting = true
	else:
		fly_audio.stop()
		engine_particles.emitting = false
		
	if Input.is_action_pressed("Left"):
		# moment obrotowty
		apply_torque(Vector3(0.0,0.0,torque_thrust * delta))
		right_engine_particles.emitting = true
	else:
		right_engine_particles.emitting = false
		
	if Input.is_action_pressed("Right"):
		apply_torque(Vector3(0.0,0.0,torque_thrust * (-delta)))
		left_engine_particles.emitting = true
	else:
		left_engine_particles.emitting = false

func turn_off_booster() -> void:
	engine_particles.emitting = false
	left_engine_particles.emitting = false
	right_engine_particles.emitting = false

func _on_body_entered(body: Node) -> void:
	if is_transitioning == false:
		if body.is_in_group("Win"):
			complete_lvl(body.next_file_path)
			
		elif body.is_in_group("Lose"):
			rocket_crash()
		
func rocket_crash() -> void:
	explosion_audio.play()
	if fly_audio.playing == true:
		fly_audio.stop()
		
	turn_off_booster()
	
	#Disables the fun _process
	set_process(false)
	is_transitioning = true
	
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_lvl(next_level: String) -> void:
	win_audio.play()
	if fly_audio.playing == true:
		fly_audio.stop()
		
	turn_off_booster()
	
	is_transitioning = true
	
	var tween = create_tween()
	tween.tween_interval(1.5)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level))
	

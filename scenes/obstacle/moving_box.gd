extends AnimatableBody3D

@export var move_direction: Vector3
@export var duration: float = 1.0

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	# global_position is set up once when the tween is creating
	tween.tween_property(self, "global_position", global_position + move_direction, duration)
	tween.tween_property(self, "global_position", global_position, duration)

func _process(delta: float) -> void:
	pass

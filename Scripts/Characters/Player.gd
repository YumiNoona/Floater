extends Node

@onready var _character = get_parent()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		_character.jump()
		if event.is_action_released("Jump"):
			_character.stop_jump()


func _process(delta: float) -> void:
	_character.run(Input.get_axis("Run_Left", "Run_Right"))

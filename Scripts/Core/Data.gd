class_name Data extends Resource

@export var coins : int
@export var lives : int
@export var has_key : bool


func _init() -> void:
	coins = 0
	lives = 3
	has_key = false

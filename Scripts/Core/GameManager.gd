extends Node2D

@onready var _player_character: Character = $Roger
@onready var _camera: Camera2D = $Camera2D
@onready var _level: Area2D = $Level
@onready var _coin_counter : Control = $GameUI/CoinCounter
@onready var _lives_counter : Control = $GameUI/LivesCounter


func _ready():
	_init_boundaries
	_init_ui
	
func  _init_boundaries():
	var minimum_boundary : Vector2 = _level.get_minimum
	var maximum_boundary : Vector2 = _level.get_maximum
	_camera.set_bounds(minimum_boundary, maximum_boundary)
	_player_character.set_bounds(minimum_boundary, maximum_boundary)


func _init_ui():
	_coin_counter.set_value(Unit.data.coins)
	_lives_counter.set_value(Unit.data.lives)


func collect_coin(value : int):
	Unit.data.coins += value
	if Unit.data.coins >= 100:
		Unit.data.coins -= 100
		Unit.data.lives += 1
		_lives_counter.set_value(Unit.data.lives)
	_coin_counter.set_value(Unit.data.coins)


func collect_skull():
	Unit.data.lives += 1
	_lives_counter.set_value(Unit.data.lives)

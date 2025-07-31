extends Node2D

@onready var _player_character: Character = $Roger
@onready var _player: Node = $Roger/Player
@onready var _camera: Camera2D = $Camera2D
@onready var _level: Area2D = $Level
@onready var _coin_counter : Control = $GameUI/CoinCounter
@onready var _lives_counter : Control = $GameUI/LivesCounter
@onready var _key_icon: TextureRect = $GameUI/KeyIcon
@onready var _fade: ColorRect = $GameUI/Fade
@onready var _victory: AudioStreamPlayer2D = $Victory



func _ready():
	_fade.visible = true
	_init_boundaries
	_init_ui
	await _fade.fade_to_clear()
	_player.set_enabled(true)
	
	
func  _init_boundaries():
	var minimum_boundary : Vector2 = _level.get_minimum
	var maximum_boundary : Vector2 = _level.get_maximum
	_camera.set_bounds(minimum_boundary, maximum_boundary)
	_player_character.set_bounds(minimum_boundary, maximum_boundary)


func _init_ui():
	_coin_counter.set_value(Unit.data.coins)
	_lives_counter.set_value(Unit.data.lives)


func collect_map():
	_player.set_enabled(false)
	_victory.play()
	await _victory.finished
	await _fade.fade_to_black()
	
	
	

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


func collect_key():
	Unit.data.has_key = true
	_key_icon.visible = true



func use_key():
	Unit.data.has_key = false
	_key_icon.visible = false

extends Camera2D

@export var _subject : Node2D
@export var _offset : Vector2


@export var _look_ahead_trans_type : Tween.TransitionType
@export var _look_ahead_ease_type : Tween.EaseType
@export var _look_ahead_duration : float = 1.0
@export var _floor_height_trans_type : Tween.TransitionType
@export var _floor_height_ease_type : Tween.EaseType
@export var _floor_height_duration : float = 1.0

@onready var _look_ahead_distance : float = _offset.x
@onready var _floor_height : float = _subject.position.y



var _look_ahead_tween : Tween
var _floor_height_tween : Tween


func _ready():
	_offset *= Global.pixelpertile


func _process(delta: float):
	position.x  = _subject.position.x + _look_ahead_distance
	position.y  = _floor_height + _offset.y
	


func _on_subject_changed_direction(is_facing_left: bool):
	if _look_ahead_tween && _look_ahead_tween.is_running():
		_look_ahead_tween.kill()
	_look_ahead_tween = create_tween().set_trans(_look_ahead_trans_type).set_ease(_look_ahead_ease_type)
	_look_ahead_tween.tween_property(self, "_look_ahead_distance",_offset.x * (-1 if is_facing_left else 1),_look_ahead_duration)

func _on_subject_landed(floor_height: float):	
	if _floor_height_tween && _look_ahead_tween.is_running():
		_floor_height_tween.kill()
	_floor_height_tween = create_tween().set_trans(_floor_height_trans_type).set_ease(_floor_height_ease_type)
	_floor_height_tween.tween_property(self, "_floor_height",floor_height,_floor_height_duration)

extends Node2D

# NODES ########################################################################
@onready var _anim_tree: AnimationTree = $animation_tree
@onready var _anim_player: AnimationPlayer = $animation_player

@onready var _name_field: LineEdit = $interface/menu/name
@onready var _warn_text: Label = $interface/menu/name/warn
@onready var _play: Button = $interface/menu/play

@onready var _fx_player: AnimationPlayer = $fx/fx_player

# STATES #######################################################################
var _anim_blend: AnimationNodeStateMachinePlayback
var _can_play: bool = true

# INIT #########################################################################
func _ready() -> void:
	_anim_tree.set_active(true)
	_anim_blend = _anim_tree.get("parameters/playback")
	
	# Setup.
	ProfanityFilter.setup()
	Data.clear()
	
	if Data.show_leaderboard:
		_anim_blend.travel("leaderboard")
		Data.show_leaderboard = false

# INPUT ########################################################################
func _on_name_text_changed(new_text: String) -> void:
	if new_text.strip_edges() != "":
		if ProfanityFilter.contains_bad_word(new_text):
			_warn_text.text = "Inappropriate name detected."
			_play.disabled = true
			_can_play = false
		else:
			_warn_text.text = ""
			_play.disabled = false
			_can_play = true
			Data.set_player_name(new_text)
	else:
		_warn_text.text = "Name cannot be empty."
		_play.disabled = true
		_can_play = false

func _on_play_pressed() -> void:
	_on_name_text_changed(_name_field.get_text())
	_fx_player.play("click")
	if _can_play:
		_anim_blend.travel("explanation")

func _on_sound_toggled(toggled_on: bool) -> void:
	_fx_player.play("click")
	if toggled_on:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Background"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Background"), false)

func _on_leaderboard_pressed() -> void:
	$interface/Leaderboard.fetch_scores()
	_fx_player.play("click")
	_anim_blend.travel("leaderboard")

func _on_back_pressed() -> void:
	_fx_player.play("click")
	_anim_blend.travel("to_intro")

func _on_skip_pressed() -> void:
	$interface/menu/skip.hide()
	$interface/menu/skip.set_disabled(true)
	
	_anim_tree.set_active(false)
	_anim_player.play("explanation")
	_anim_player.seek(83.6, true)

# HELPER #######################################################################
func go_to_gameplay() -> void:
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

# HOVERS #######################################################################
func _on_name_mouse_entered() -> void:
	_fx_player.play("hover")
func _on_name_focus_entered() -> void:
	_fx_player.play("click")

func _on_play_mouse_entered() -> void:
	_fx_player.play("hover")

func _on_sound_mouse_entered() -> void:
	_fx_player.play("hover")

func _on_leaderboard_mouse_entered() -> void:
	_fx_player.play("hover")

func _on_back_mouse_entered() -> void:
	_fx_player.play("hover")

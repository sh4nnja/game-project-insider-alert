# Stores data related to player. Plus handling google sheet integration for leaderboard.

extends Node

# DATA #########################################################################
var _current_score: int = 0
var _player_name: String = ""
var _player_rank: String = ""

# SETTER #######################################################################
func set_player_name(player: String) -> void:
	_player_name = player

func get_player_name() -> String:
	return _player_name

func add_score(score: int) -> void:
	_current_score += score

func get_score() -> int:
	return _current_score

func set_player_rank(rank: String) -> void:
	_player_rank = rank

func get_player_rank() -> String:
	return _player_rank

func clear() -> void:
	_player_name = ""
	_current_score = 0

# SILENTWOLF ###################################################################
func _ready() -> void:
	SilentWolf.configure({
		"api_key": "BRDTWHswNR9s44FOSRlQ11IgCLU8oTdA15Osh23c",
		"game_id": "insider_alert1",
		"log_level": 1
	})

# MISC #########################################################################
var show_leaderboard: bool = false

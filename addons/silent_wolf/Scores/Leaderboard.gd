@tool
extends Node2D

const ScoreItem = preload("ScoreItem.tscn")
const SWLogger = preload("res://addons/silent_wolf/utils/SWLogger.gd")

var list_index = 0
# Replace the leaderboard name if you're not using the default leaderboard
var ld_name = "main"
var max_scores = 10

func _ready():
	fetch_scores()

func fetch_scores() -> void:
	clear_leaderboard()
	add_loading_scores_message()
	await get_tree().create_timer(1).timeout
	var sw_result = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	var scores = sw_result.scores

	hide_message()
	render_board(scores, []) 

func render_board(scores: Array, local_scores: Array) -> void:
	var all_scores = scores
	if all_scores.is_empty():
		add_no_scores_message()
	else:
		add_loading_scores_message()
		for score in all_scores:
			add_item(score.player_name, str(int(score.score)))
		hide_message()


func is_default_leaderboard(ld_config: Dictionary) -> bool:
	var default_insert_opt = (ld_config.insert_opt == "keep")
	var not_time_based = !("time_based" in ld_config)
	return default_insert_opt and not_time_based


func add_item(player_name: String, score_value: String) -> void:
	var item = ScoreItem.instantiate()
	list_index += 1
	item.get_node("Index").text = "#" + str(list_index)
	item.get_node("PlayerName").text = player_name
	var performance_title = ""
	if score_value.to_int() == 12:
		performance_title = "Cybersecurity Vanguard"
	elif score_value.to_int() >= 9:
		performance_title = "Insider Threat Expert"
	elif score_value.to_int() >= 5:
		performance_title = " Experienced Defender"
	else:
		performance_title = " Novice Analyst"
	# Set the combined text
	item.get_node("Score").text = score_value + "/12"
	item.get_node("Rank").text = performance_title
	item.offset_top = list_index * 100
	$"Board/HighScores/ScoreItemContainer".add_child(item)


func add_no_scores_message() -> void:
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "No scores yet!"
	$"Board/MessageContainer".show()
	item.offset_top = 135


func add_loading_scores_message() -> void:
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "Loading scores..."
	$"Board/MessageContainer".show()
	item.offset_top = 135


func hide_message() -> void:
	$"Board/MessageContainer".hide()


func clear_leaderboard() -> void:
	var score_item_container = $"Board/HighScores/ScoreItemContainer"
	if score_item_container.get_child_count() > 0:
		var children = score_item_container.get_children()
		for c in children:
			score_item_container.remove_child(c)
			c.queue_free()
	list_index = 0

extends Node2D

@onready var _fx_player: AnimationPlayer = get_parent().get_node("fx/fx_player")
@onready var _voice: AudioStreamPlayer = get_parent().get_node("voice")

# NODES ########################################################################
@onready var _option_a: Button = $scenario_options/template/buttons/option_a
@onready var _option_b: Button = $scenario_options/template/buttons/option_b
@onready var _option_c: Button = $scenario_options/template/buttons/option_c
@onready var _option_d: Button = $scenario_options/template/buttons/option_d
@onready var _feedback_text: Label = $scenario_options/template/feedback
@onready var _buttons: Array[Button] = [_option_a, _option_b, _option_c, _option_d]

@onready var _next: Button = $scenario_options/next

func update_scenario() -> void:
	var _scenario: Node2D = get_node("scenario_" + str(get_parent().scenario_count))
	for i in range(_scenario.option.size()):
		_buttons[i].text = _scenario.option[i]
		_buttons[i].connect("pressed", Callable(self, "_on_option_selected").bind(i))
		_buttons[i].connect("mouse_entered", Callable(self, "_on_option_hovered"))
		_buttons[i].set_mouse_filter(Control.MOUSE_FILTER_STOP)
		_buttons[i].disabled = false
		_buttons[i].button_pressed = false
		_buttons[i].show()

func _on_option_selected(option_index: int) -> void:
	var _scenario: Node2D = get_node("scenario_" + str(get_parent().scenario_count))
	
	_fx_player.play("jingle")
	
	_feedback_text.text = "Great!\n\n" + _scenario.feedback[option_index] + "\n\n" + _scenario.lesson[option_index]
	_voice.set_stream(load(_scenario.voice[option_index]))
	_voice.play()
	
	Data.add_score(_scenario.scores[option_index])
	
	for i in range(_scenario.option.size()):
		_buttons[i].set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		_buttons[i].disconnect("pressed", Callable(self, "_on_option_selected"))
		_buttons[i].disconnect("mouse_entered", Callable(self, "_on_option_hovered"))
		if not _buttons[i].button_pressed:
			_buttons[i].disabled = true
	
	await _voice.finished
	_next.set_disabled(false)
	_next.show()

func _on_option_hovered() -> void:
	_fx_player.play("hover")

func _on_next_pressed() -> void:
	get_tree().call_group("game", "continue_animation")
	_next.hide()
	_next.set_disabled(false)
	_feedback_text.text = " "

# HELPER #######################################################################
func _enable_interaction(_enable: bool = false):
	for _i in _buttons:
		if _enable:
			_i.set_mouse_filter(Control.MOUSE_FILTER_STOP)
		else:
			_i.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)

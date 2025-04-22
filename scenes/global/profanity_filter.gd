# Handle profanity checks.

extends Node
class_name ProfanityFilter

static var _bad_words_file: String = "res://scenes/global/misc/banned_words.txt"
static var _bad_words: Array[String] = []

# Maps for basic leet replacements
static var LEET_MAP: Dictionary = {
	"1": "i",
	"@": "a",
	"$": "s",
	"5": "s",
	"0": "o",
	"3": "e",
	"4": "a",
	"!": "i",
}

# INIT #########################################################################
static func setup() -> void:
	_load_bad_words(_bad_words_file)

# ACCESSOR #####################################################################
# Function to check if the name contains any bad words
static func contains_bad_word(names: String) -> bool:
	var _normalized: String = _normalize_name(names)
	for _bad_word in _bad_words:
		if _bad_word in _normalized:
			return true
	return false

# HELPER #######################################################################
# Function to normalize names, converting leet characters
static func _normalize_name(names: String) -> String:
	var _lowered: String = names.to_lower()
	var _result: String = ""
	for _char in _lowered:
		if LEET_MAP.has(_char):
			_result += LEET_MAP[_char]
		elif _char >= "a" and _char <= "z":
			_result += _char
	return _result

# Function to load bad words from a file
static func _load_bad_words(path: String) -> void:
	var _file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if _file:
		while not _file.eof_reached():
			var _word: String = _file.get_line().strip_edges().to_lower()
			if _word != "":
				_bad_words.append(_word) 
		_file.close()
	else:
		print("Failed to load bad words file.")

extends Node

var difficulties = {
	"easy": {
		"wait_time": 2.5,
		"limit_wait_time": 1,
		"speed": 1.0,
		"speed_step": 0.05,
		"win_score": 30,
	},
	"medium": {
		"wait_time": 1.5,
		"limit_wait_time": 0.5,
		"speed": 1.5,
		"speed_step": 0.1,
		"win_score": 50,
	},
	"hard": {
		"wait_time": 0.8,
		"limit_wait_time": 0.25,
		"speed": 2.2,
		"speed_step": 0.15,
		"win_score": 30,
	}
}

var current_config = difficulties["easy"]

func set_difficulty(level: String):
	if difficulties.has(level):
		current_config = difficulties[level]
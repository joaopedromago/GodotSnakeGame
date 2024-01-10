extends Node

class_name ScoreService

func increase_score_value():
	Globals.score += 1
	if Globals.score > Globals.best_score:
		Globals.best_score = Globals.score

func reset_score():
	Globals.score = 0

func get_score_text():
	return Globals.score_text.replace("%score%", str(Globals.score))
func get_best_score_text():
	return Globals.best_score_text.replace("%score%", str(Globals.best_score))

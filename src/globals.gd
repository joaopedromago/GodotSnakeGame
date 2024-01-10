extends Node

const game_scene = "res://scenes/game.tscn"
const options_scene = "res://scenes/options.tscn"
const menu_scene = "res://scenes/menu.tscn"
const death_scene = "res://scenes/death.tscn"
const score_text = "Score: %score%"
const best_score_text = "Personal Best: %score%"

var speed: int = 10
var score: int = 0
var best_score: int = 0
var die_on_wall_hit: bool = false

extends Node

const SAVE_PATH = "user://savegame.sav"
const SECRET = "kogane"
var save_file = ConfigFile.new()
var score = 0
var k


var level = 1

signal score_changed

onready var HUD = get_node_or_null("/root/Game/UI/HUD") 
onready var Coins = get_node_or_null("/root/Game/Coins")
onready var Mines = get_node_or_null("/root/Game/Mines")
onready var Game = load("res://Game.tscn")
onready var Level2 = load("res://Level2/Level2.tscn")
onready var Coin = load("res://Coin/Coin.tscn")

var save_data = {
	"general": {
		"score":0
		,"health":100
		,"coins":[]
	}
}




func update_score(s):
	save_data["general"]["score"] += s
	if level == 1:
		HUD.find_node("Score").text = "Score: " + str(save_data["general"]["score"])
		if save_data["general"]["score"]  == 80:
			k = get_tree().change_scene("res://Level2/Level2.tscn")
			level = 2

func restart_level():
	HUD = get_node_or_null("/root/Game/UI/HUD")
	Coins = get_node_or_null("/root/Game/Coins")
	
	for c in Coins.get_children():
		c.queue_free()
	for c in save_data["general"]["coins"]:
		var coin = Coin.instance()
		coin.position = str2var(c)
		Coins.add_child(coin)
	update_score(0)
	get_tree().paused = false

# ----------------------------------------------------------
	
func save_game():
	save_data["general"]["coins"] = []
	for c in Coins.get_children():
		save_data["general"]["coins"].append(var2str(c.position))

	var save_game = File.new()
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)
	save_game.store_string(to_json(save_data))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return
	save_game.open_encrypted_with_pass(SAVE_PATH, File.READ, SECRET)
	var contents = save_game.get_as_text()
	var result_json = JSON.parse(contents)
	if result_json.error == OK:
		save_data = result_json.result
	else:
		print("Error: ", result_json.error)
	save_game.close()
	level = 1
	var _scene = get_tree().change_scene_to(Game)
	call_deferred("restart_level")

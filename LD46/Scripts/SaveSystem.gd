extends Node

const SAVE = "user://game.save"


func save_game():
	var save_game = File.new()
	save_game.open(SAVE, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Save")
	for node in save_nodes:
		if node.filename.empty():
			continue
		if !node.has_method("save"):
			continue
		var node_data = node.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()


func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE):
		return
	var save_nodes = get_tree().get_nodes_in_group("Group")
	for i in save_nodes:
		i.queue_free()
	save_game().open(SAVE, File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		var new_object = load(node_data["filename"]).instance()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos.x"], node_data["pos.y"])
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos.x" or i == "pos.y":
				continue
			new_object.set(i, node_data[i])
	save_game.close()

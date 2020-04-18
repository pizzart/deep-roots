extends Node


func get_setting(section, key, value):
	var config = ConfigFile.new()
	var err = config.load("./settings.cfg")
	if err == OK:
		var val = config.get_value(section, key, value)
		config.save("./settings.cfg")
		return val
	else:
		return "error opening file please hepl"


func set_setting(section, key, value):
	var config = ConfigFile.new()
	var err = config.load("./settings.cfg")
	if err == OK:
		config.set_value(section, key, value)
		config.save("./settings.cfg")

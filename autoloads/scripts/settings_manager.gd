extends Node

# should load in settings from a config.ini
func _ready() -> void:
	pass

# whenever settings menu is closed, if any of the details have changed, this 
# will update the config file with the new changes
# ready should connect this to a settings_changed signal
func on_save() -> void:
	pass

func connect_to_settings(settings_menu: CanvasLayer):
	settings_menu.save_settings.connect(on_save)

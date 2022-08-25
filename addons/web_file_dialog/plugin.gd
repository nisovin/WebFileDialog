tool
extends EditorPlugin

func _enter_tree() -> void:
	add_autoload_singleton("WebFileDialog", "res://addons/web_file_dialog/WebFileDialog.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("WebFileDialog")

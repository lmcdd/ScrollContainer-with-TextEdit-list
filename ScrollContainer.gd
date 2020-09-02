extends ScrollContainer

func _ready(): 
	for textedit in $"VBoxContainer".get_children():
		textedit.get_node("Button").connect("pressed", self, "_on_TextEditButton_pressed", [textedit])
		textedit.connect("focus_exited", self, "_on_TextEdit_focus_exited", [textedit])


func _on_TextEditButton_pressed(textedit):
	print("pressed ",textedit)
	textedit.get_node("Button").hide()
	textedit.mouse_filter = MOUSE_FILTER_STOP
	textedit.grab_focus()
	focus_mode = Control.FOCUS_CLICK
	mouse_filter = MOUSE_FILTER_IGNORE
	get_v_scrollbar().mouse_filter = MOUSE_FILTER_IGNORE
	get_h_scrollbar().mouse_filter = MOUSE_FILTER_IGNORE


func _on_TextEdit_focus_exited(textedit):
	print("focus_exited ",textedit)
	textedit.mouse_filter = MOUSE_FILTER_IGNORE
	mouse_filter = MOUSE_FILTER_STOP
	focus_mode = Control.FOCUS_ALL
	get_v_scrollbar().mouse_filter = MOUSE_FILTER_STOP
	get_h_scrollbar().mouse_filter = MOUSE_FILTER_STOP
	textedit.get_node("Button").show()


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			var focus_owner = get_focus_owner()
			if focus_owner:
				focus_owner.release_focus()

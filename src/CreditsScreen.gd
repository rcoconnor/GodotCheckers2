extends MarginContainer

#export (PackedScene)var Main_Menu 

func _input(_event): 
	if Input.is_action_just_pressed("ui_cancel"): 
		queue_free() 


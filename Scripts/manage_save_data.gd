extends Node

var save_path := "user://savegame.dat"

func _ready() -> void:
    print(get_node("/root"))

# get data that needs to be saved
func get_data() -> Dictionary:
    #var player = get_tree().get_node("Main/Player")
    return {}

func save(data: Dictionary) -> void:
    var file = FileAccess.open(save_path, FileAccess.WRITE)
    if file:
        file.store_var(data, true)
        file.close()
        print("Data saved.")
    else:
        push_error("Failed to open save file for writing.")

func load() -> Dictionary:
    if not FileAccess.file_exists(save_path):
        push_warning("Save file not found.")
        return {}
    var file = FileAccess.open(save_path, FileAccess.READ)
    if file:
        var data = file.get_var(true)
        file.close()
        return data
    else:
        push_error("Failed to open save file for reading.")
        return {}

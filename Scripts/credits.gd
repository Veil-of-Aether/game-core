extends Control

@onready var container = $CreditsContainer

func _ready():
    load_credits("res://Data/credits.json")

func load_credits(path):
    var file = FileAccess.open(path, FileAccess.READ)
    if file == null:
        push_error("Could not open credits file.")
        return

    var json_text = file.get_as_text()
    var result = JSON.parse_string(json_text)

    if result is Array:
        for entry in result:
            if entry.has("title") and entry.has("entries"):
                render_section(entry["title"], entry["entries"])
    else:
        push_error("Credits JSON root is not an array.")

func render_section(titleText, entriesList):
    add_section_header(titleText)
    for entry in entriesList:
        if typeof(entry) == TYPE_STRING:
            add_entry_line(entry)
        elif typeof(entry) == TYPE_DICTIONARY and entry.has("name"):
            add_entry_line(entry["name"], entry.get("note", null))
    add_spacer()

func add_entry_line(entry_name, note = null):
    var label = Label.new()
    label.text = entry_name
    label.add_theme_font_size_override("font_size", 18)
    label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    container.add_child(label)

    if note != null:
        var note_label = Label.new()
        note_label.text = "    " + note
        note_label.add_theme_font_size_override("font_size", 14)
        note_label.add_theme_color_override("font_color", Color.LIGHT_GRAY)
        note_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        container.add_child(note_label)

func add_section_header(text):
    var label = Label.new()
    label.text = text
    label.add_theme_font_size_override("font_size", 24)
    label.add_theme_color_override("font_color", Color.SKY_BLUE)
    label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    label.add_theme_constant_override("margin_bottom", 4)
    container.add_child(label)

func add_spacer():
    var spacer = Control.new()
    spacer.custom_minimum_size = Vector2(0, 20)
    container.add_child(spacer)

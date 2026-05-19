extends Node

@export var card_data : Card

@onready var title_labal = $Title
@onready var description_label = $Description
@onready var texture = $TextureRect

func _ready() -> void:
	update_card()

func update_card():
	if not card_data:
		push_warning("Card has no data")
	title_labal.text = card_data.title
	description_label.text = card_data.description
	texture = card_data.texture

func on_selected() -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")
	card_data.apply(player)

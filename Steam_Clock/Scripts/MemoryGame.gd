extends Node2D

export(int) var matches_need = 6

var matches_found : int
var memoryCards
var selectedCards = []

signal deselect_card()

func _ready():
	get_all_cards()
	
func get_all_cards():
	memoryCards = get_tree().get_nodes_in_group("MemoryCards")
	for card in memoryCards:
		connect("deselect_card", card, "_on_MemoryGame_card_deselected")
		card.connect("card_selected", self, "_on_MemoryCard_card_selected")
		
func _on_MemoryCard_card_selected(card):
	selectedCards.append(card)
	if selectedCards.size() >= 2:
		check_for_match()
		
func check_for_match():
	var first_card = selectedCards[0]
	var second_card = selectedCards[1]
	if first_card.label.text.match(second_card.label.text):
		matches_found += 1
		first_card.remove_from_group("MemoryCards")
		disconnect("deselect_card", first_card, "_on_MemoryGame_card_deselected")
		second_card.remove_from_group("MemoryCards")
		disconnect("deselect_card", second_card, "_on_MemoryGame_card_deselected")
	else:
		get_tree().call_group("MemoryCards", "set_process", false)
		var dialogue = Dialogic.start("/fail")
		add_child(dialogue)
		yield(dialogue, "tree_exited")
		get_tree().call_group("MemoryCards", "set_process", true)
		emit_signal("deselect_card")
	selectedCards = []
	
func _process(delta):
	if matches_found == matches_need:
		set_process(false)
		yield(get_tree().create_timer(2), "timeout")
		var dialogue = Dialogic.start("/Labor 2")
		add_child(dialogue)
		

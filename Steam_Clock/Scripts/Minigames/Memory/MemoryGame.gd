extends Node2D

const henry := "Henry"
const win := "Win"
const fail := "Fail"
const weird := "Weird"
const rich := "Rich"
const sexual := "Sexual"

export(int) var matches_need = 3
export(String) var dialogueRoot

var matches_found : int
var memoryCards := []
var selectedCards := []
var henryFound := false

signal deselect_card()

func _ready():
	get_all_cards()
	
func get_all_cards():
	memoryCards = get_tree().get_nodes_in_group("MemoryCards")
	for card in memoryCards:
		connect("deselect_card", card, "_on_MemoryGame_card_deselected")
		card.connect("card_selected", self, "_on_MemoryCard_card_selected")
		var value = Dialogic.get_saved_state_general_key(card.get_path())
		if value:
			card.label.self_modulate.a = 60

		
func _on_MemoryCard_card_selected(card: MemoryCard):
	Dialogic.set_saved_state_general_key(card.get_path(), true)
	selectedCards.append(card)
	if card.pairTag == henry:
		henry_selected()
	elif selectedCards.size() >= 2:
		check_for_match()

func henry_selected():
		get_tree().call_group("MemoryCards", "set_process", false)
		var dialogue = Dialogic.start(dialogueRoot + henry)
		add_child(dialogue)
		yield(dialogue, "timeline_end")
		get_tree().call_group("MemoryCards", "set_process", true)

func hide_henry():
	selectedCards.pop_back().hide()
	henryFound = true

func check_for_match():
	var first_card: MemoryCard = selectedCards[0]
	var second_card: MemoryCard = selectedCards[1]
	if first_card.pairTag.match(second_card.pairTag):
		matches_found += 1
		first_card.remove_from_group("MemoryCards")
		disconnect("deselect_card", first_card, "_on_MemoryGame_card_deselected")
		second_card.remove_from_group("MemoryCards")
		disconnect("deselect_card", second_card, "_on_MemoryGame_card_deselected")
		#play dialogue
		get_tree().call_group("MemoryCards", "set_process", false)
		var dialogue = Dialogic.start(dialogueRoot + first_card.pairTag)
		add_child(dialogue)
		yield(dialogue, "timeline_end")
		get_tree().call_group("MemoryCards", "set_process", true)
	else:
		get_tree().call_group("MemoryCards", "set_process", false)
		var dialogue = Dialogic.start(dialogueRoot + fail)
		add_child(dialogue)
	selectedCards = []
	
func _process(delta):
	if matches_found == matches_need and henryFound:
		set_process(false)
		get_tree().call_group("MemoryCards", "set_process", false)
		yield(get_tree().create_timer(2), "timeout")
		var dialogue = Dialogic.start(dialogueRoot + win)
		add_child(dialogue)
		

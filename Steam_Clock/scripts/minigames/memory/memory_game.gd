extends Node2D

onready var aniManager = $AnimationLayer/AnimationManager
onready var canvasMod = $CanvasModulate

const henry := "Henry"
const win := "Win"
const fail := "Fail"
const weird := "Weird"
const rich := "Rich"
const sexual := "Sexual"
const start := "Start"

export(int) var matches_need = 3
export(String) var dialogueRoot

var matches_found : int
var memoryCards := []
var selectedCards := []
var henryFound := false
var resolve := false

signal deselect_card()

func _ready():
	get_all_cards()
	var dia = Dialogic.start(dialogueRoot + start)
	
func get_all_cards():
	memoryCards = get_tree().get_nodes_in_group("MemoryCards")
	for card in memoryCards:
		connect("deselect_card", card, "_on_MemoryGame_card_deselected")
		card.connect("card_selected", self, "_on_MemoryCard_card_selected")
		var value = Dialogic.get_saved_state_general_key(card.get_path())
		if value:
			card.label.self_modulate.a = 0.3

func _on_MemoryCard_card_selected(card: MemoryCard):
	resolve = true
	Dialogic.set_saved_state_general_key(card.get_path(), true)
	selectedCards.append(card)
	if card.pairTag == henry:
		henry_selected()
	elif selectedCards.size() >= 2:
		check_for_match()
	resolve = false

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
	var firstCard: MemoryCard = selectedCards[0]
	var secondCard: MemoryCard = selectedCards[1]
	if firstCard.pairTag.match(secondCard.pairTag):
		resolve_match_found(firstCard, secondCard)
	else:
		get_tree().call_group("MemoryCards", "set_process", false)
		var dialogue = Dialogic.start(dialogueRoot + fail)
		add_child(dialogue)
	selectedCards = []
	
func _process(delta):
	if matches_found == matches_need and henryFound and !resolve:
		henryFound = false
		set_process(false)
		get_tree().call_group("MemoryCards", "set_process", false)
		yield(get_tree().create_timer(2), "timeout")
		var dialogue = Dialogic.start(dialogueRoot + win)
		add_child(dialogue)
		
func resolve_match_found(firstCard: MemoryCard, secondCard: MemoryCard):

		firstCard.remove_from_group("MemoryCards")
		disconnect("deselect_card", firstCard, "_on_MemoryGame_card_deselected")
		secondCard.remove_from_group("MemoryCards")
		disconnect("deselect_card", secondCard, "_on_MemoryGame_card_deselected")
		#play dialogue
		get_tree().call_group("MemoryCards", "set_process", false)
		#aniManager.show()
		if firstCard.left:
			aniManager.start_animation(firstCard.label.texture, secondCard.label.texture)
		else:
			aniManager.start_animation(secondCard.label.texture, firstCard.label.texture)
		yield($AnimationLayer/AnimationManager/AnimationPlayer, "animation_finished")
		var dialogue = Dialogic.start(dialogueRoot + firstCard.pairTag)
		add_child(dialogue)
		yield(dialogue, "timeline_end")
		aniManager.hide()
		$AnimationLayer/AnimationManager/Tween.interpolate_property(canvasMod, "color",
		canvasMod.color, Color(1, 1, 1, 1), 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$AnimationLayer/AnimationManager/Tween.start()
		yield($AnimationLayer/AnimationManager/Tween, "tween_all_completed")
		get_tree().call_group("MemoryCards", "set_process", true)
		matches_found += 1
		

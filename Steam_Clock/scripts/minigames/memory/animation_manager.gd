extends Node2D

onready var aniPlayer = $AnimationPlayer
onready var leftRect: TextureRect = $Left
onready var rightRect: TextureRect = $Right
onready var fullRect: TextureRect = $Full

const henry := "Henry"
const weird := "Weird"
const rich := "Rich"
const sexual := "Sexual"

export(Resource) var weirdFull
export(Resource) var sexualFull
export(Resource) var richFull
export(Resource) var henryFull

var tagToText := {henry : henryFull,
				weird: weirdFull,
				rich: richFull,
				sexual: sexualFull} 

func start_animation(leftText: Texture, rightText: Texture):
	leftRect.texture = leftText
	rightRect.texture = rightText
	#fullRect.texture = tagToText[tag].load()
	show()
	aniPlayer.play("CombineCards")

func start_default():
	aniPlayer.play("CombineCards")







class_name TreasureChest extends StaticBody2D

@export var money_base: int = 100
@export var money_random_max: int = 100
@export var contents: Array[String] = []

var total_money: int
var opened := false:
	set(val):
		if val == true:
			opened = true
			$Sprite2D.frame = 1
		else:
			opened = false
			$Sprite2D.frame = 0


func _ready() -> void:
	total_money = money_base + randi_range(0, money_random_max)

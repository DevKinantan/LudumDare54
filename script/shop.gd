extends Control

@onready var backBtn = get_node("BackBtn")
@onready var turretBtn = get_node("Turret/TurretUpgBtn")
@onready var turretMaxBtn = get_node("Turret/TurretUpgMaxBtn")
@onready var slotBtn = get_node("Slot/SlotUpgBtn")
@onready var trashBtn = get_node("Trash/TrashUpgBtn")

@onready var turretIcon = get_node("Turret/TurretIcon")
@onready var slotIcon = get_node("Slot/SlotIcon")
@onready var trashIcon = get_node("Trash/TrashIcon")

@onready var parentTree = get_parent().get_node("TestGameplay")

@onready var turret = parentTree.get_node("Player").get_node("Turret")

var turretLvl1 = preload("res://image/Store/circuit_lvl1.png")
var turretLvl2 = preload("res://image/Store/circuit_lvl2.png")
var turretLvl3 = preload("res://image/Store/circuit_lvl3.png")

var maxUpgradedBtn = preload("res://image/Store/button_maxed_upgrade.png")

func _ready():
	updateTurretIcon()

func updateTurretIcon():
	if turret.currentTurretLevel == 1:
		turretIcon.texture = turretLvl1
	elif turret.currentTurretLevel == 2:
		turretIcon.texture = turretLvl2
	elif turret.currentTurretLevel == 3:
		turretIcon.texture = turretLvl3
		turretBtn.visible = false
		turretMaxBtn.visible = true

func _on_back_btn_mouse_entered():
	backBtn.self_modulate = Color.GRAY


func _on_back_btn_mouse_exited():
	backBtn.self_modulate = Color.WHITE


func _on_back_btn_pressed():
	queue_free()


func _on_turret_upg_btn_mouse_entered():
	turretBtn.self_modulate = Color.GRAY


func _on_turret_upg_btn_mouse_exited():
	turretBtn.self_modulate = Color.WHITE


func _on_turret_upg_btn_pressed():
	turret.upgradeTurret(turret.currentTurretLevel + 1)
	updateTurretIcon()


func _on_slot_upg_btn_mouse_entered():
	slotBtn.self_modulate = Color.GRAY


func _on_slot_upg_btn_mouse_exited():
	slotBtn.self_modulate = Color.WHITE


func _on_slot_upg_btn_pressed():
	print("slot upgraded")

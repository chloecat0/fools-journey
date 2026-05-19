class_name Card
extends Resource

@export var title: String
@export_multiline var description: String
enum PlayerStat {SPEED_MULT, JUMP_MULT, HEALTH, DAMAGE, ATTACK_SPEED}
@export var stat : PlayerStat
@export var stat_change : float
@export var texture : Texture2D

func _init(p_title = "Title", p_desc = "Description", p_stat : PlayerStat = PlayerStat.SPEED_MULT, p_change = 0.0, p_texture = null):
	title = p_title
	description = p_desc
	stat = p_stat
	stat_change = p_change
	texture = p_texture
	
func apply(player: Player):
	match stat:
		PlayerStat.SPEED_MULT:
			player.speed_multiplier += stat_change
		PlayerStat.JUMP_MULT:
			player.jump_multiplier += stat_change
		PlayerStat.HEALTH:
			player.max_health += stat_change
		PlayerStat.DAMAGE:
			player.damage += stat_change
		PlayerStat.ATTACK_SPEED:
			player.attack_speed += stat_change
		_:
			push_error("Invalid player stat in card")
		
	

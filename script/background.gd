extends ParallaxBackground


var scrolling_speed = 100
var isTruckStop = false

func _process(delta):
	if !isTruckStop:
		scroll_offset.x -= scrolling_speed * delta

func changeTruckCondition(isStop):
	isTruckStop = isStop

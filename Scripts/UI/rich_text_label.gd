extends RichTextLabel

@onready var hand_parent = get_parent().get_parent()

func _process(delta):
	self.text = str(hand_parent.get_score())

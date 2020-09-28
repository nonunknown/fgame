extends Control


func _ready():
	var nn = NN_FeedForward.new(1,3,1)
	nn.feed_forward([1,2])
	

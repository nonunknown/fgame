class_name NN_FeedForward

var input:int
var hidden:int
var output:int

var bias_ih:Matrix
var bias_ho:Matrix
var weight_ih:Matrix
var weight_ho:Matrix

func _init(input:int,hidden:int,output:int):
	self.input = input
	self.hidden = hidden
	self.output = output
	
	bias_ih = Matrix.new(hidden,1)
	bias_ih.randomize_me()
	bias_ho = Matrix.new(output,1)
	bias_ho.randomize_me()
	
	Matrix.p_print(bias_ih)
	Matrix.p_print(bias_ho)
	
	weight_ih = Matrix.new(hidden,input)
	weight_ih.randomize_me()
	
	Matrix.p_print(weight_ih,"W - Input to Hidden")
	
	weight_ho = Matrix.new(output,hidden)
	
	Matrix.p_print(weight_ho)

func feed_forward(input:Array) -> void:
	var _in = Matrix.new(1,input.size())
	#convert the input array to One line matrix
	_in.set_data([input])
	Matrix.p_print(_in,"Inputs")
	
	# multiply weigths with input
	var _hidden = Matrix.new()
	_hidden.set_data( Matrix.multiply(weight_ih,_in) )
	Matrix.p_print(_hidden,"Hidden")
	pass

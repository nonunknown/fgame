class_name Matrix

var rows:int
var cols:int
var data:Array = []

func _init(rows:int=0,cols:int=0):
	self.rows = rows
	self.cols = cols
	for i in rows:
		var arr = []
		for j in cols:
			arr.append(randi() % 20)
		data.append(arr)
#	p_print(self)

func set_data(arr:Array) -> void:
	data = arr
	rows = data.size()
	cols = data[0].size()
#	print(data)
#	print(rows)
#	print(cols)

func get_cols() -> Array:
	var result = []
	for i in range(cols):
		var arr = []
		for value in data:
			arr.append(value[i])
		result.append(arr)
	return result

func get_rows() -> Array: 
	return data

func randomize_me() -> void:
	for i in range(data.size()):
		for j in range(data[i].size()):
			data[i][j] = randi() % 100

func activate_me() -> void:
	for i in range(data.size()):
		for j in range(data[i].size()):
			data[i][j] = 1 / ( 1 + exp(-data[i][j]) )

static func sum(a,b) -> Array:
	var arr = []
	#Check matrix size
	if (a.rows != b.rows and a.cols != b.cols):
		printerr("Matrices are from different size in SUM")
		return []
#	#Do sum if ok
	for i in range(a.rows):
		for j in range(a.cols):
#			print("sum: %d + %d" % [a.data[i][j], b.data[i][j]] )
			arr.append(a.data[i][j] + b.data[i][j])
	return arr

static func multiply(a,b):
	var result = []
	if (a.rows != b.cols):
		printerr("The A Cols must match B Rows in MULTIPLY")
		return result

	var r = a.get_rows()
	var c = b.get_cols()
	for row in r:
		var arr = []
		for col in c:
#			print("row: %s * column: %s" % [str(row),str(col)])
			var sum = 0
			for i in range(row.size()):
				var n = row[i] * col[i]
				sum += n
			arr.append(sum)
		result.append(arr)
#	print(result)
	return result

static func p_print(matrix,title:String="") -> void:
	print("---- M %s---- " % title)
	for value in matrix.get_rows():
		print(value)
	print("----")
		
static func p_printm(a,b) -> void:
	for i in range(a.data.size()):
		print(str(a.data[i])+"   "+str(b.data[i]))
		

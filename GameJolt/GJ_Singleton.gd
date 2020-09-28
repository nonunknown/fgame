extends Node

func _ready():
	GameJoltAPI.set_game_credentials({
		"game_id":"535036",
		"private_key":"da1837aefe218cebeeedc38bdbcaac52"
	})
	
	var trophy_request = GameJoltAPI.add_achieved({
	 "username": GameJoltAPI.username,
	 "user_token": GameJoltAPI.user_token,
	 "trophy_id": "128541"
	})

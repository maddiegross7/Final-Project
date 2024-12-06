extends TextureButton
#THE MAIN DIFFERENCE BETWEEN THIS AND BUTTON_2 and BUTTON_3 is that the rarties and cost are different as more rare items are easier to get and cost more
var cost = 25 # cost for case

var rarity_images = {#images for all items mapped by rartie
	"common": [
		{"image": preload("res://rewards/common/pixil-frame-0.png"), "reward_id": "common_0"}
	],
	"rare": [
		{"image": preload("res://rewards/rare/pixil-frame-0 (2).png"), "reward_id": "rare_2"},
		{"image": preload("res://rewards/rare/pixil-frame-0 (4).png"), "reward_id": "rare_4"},
		{"image": preload("res://rewards/rare/pixil-frame-0 (5).png"), "reward_id": "rare_5"}
	],
	"epic": [
		{"image": preload("res://rewards/epic/pixil-frame-0 (6).png"), "reward_id": "epic_6"},
		{"image": preload("res://rewards/epic/pixil-frame-0 (7).png"), "reward_id": "epic_7"}
	],
	"legendary": [
		{"image": preload("res://rewards/legendary/pixil-frame-0 (1).png"), "reward_id": "legendary"}
	]
}

var rarity_probabilities = {#probability of each item based on raritiy 
	"common": 0.9,
	"rare": 0.05,
	"epic": 0.04,
	"legendary": 0.01
}

func _ready(): #Used to intialzie opening an item
	randomize()
	connect("pressed", Callable(self, "_on_texture_button_pressed"))

func _on_texture_button_pressed():#When started checks to see if there's enough coins to open it and removes it from quantity
	if(SceneManager.coins >= cost):
		SceneManager.coins -= cost
		var selected_rarity = get_random_rarity() #gets a rarity based on the percentages 
		var images = rarity_images[selected_rarity] #gets the list of items based on rarity 
		var selected = images[randi() % images.size()] #After get the image and the reward id
		var selected_image = selected["image"]
		var reward_id = selected["reward_id"]

		if selected_rarity != "common":#add to reward manager for tree generation if not a common
			RewardManager.add_reward(reward_id)

		var popup = get_node("/root/Node/Control/RewardPopup")#set popup to the necessary reward earned
		if popup:
			var image_display = popup.get_node("ImageDisplay")
			if image_display:
				image_display.texture = selected_image
			popup.popup_centered()
		else:
			print("RewardPopup node not found.")


func get_random_rarity() -> String: #function to determine the rarity based on the early percentages
	var rand_val = randf()
	var cumulative = 0.0
	for rarity in rarity_probabilities.keys():
		cumulative += rarity_probabilities[rarity]
		if rand_val <= cumulative:
			return rarity
	return "common"

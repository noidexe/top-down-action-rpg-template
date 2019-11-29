extends Node

export(String) var quest_name = "Life as a Rappi Guy"

export(String) var required_item = "Generic Item"
export(int) var required_amount = 10
export(String) var reward_item = "Generic Reward"
export(int) var reward_amount = 1

export(String, MULTILINE) var initial_text = "TLDR; bring me 10 thingies"
export(String, MULTILINE) var pending_text = "You forgot? I want 10 thingies"
export(String, MULTILINE) var delivered_text = "Thank you! Here's your reward.."

func process() -> String:
	print(Quest.quest_list)
	var quest_status = Quest.get_status(quest_name)
	print(typeof(quest_status))
	print(Quest.get_status_as_text(quest_name))
	print (quest_status == Quest.STATUS.STARTED)
	match quest_status:
		Quest.STATUS.NONEXISTENT:
			Quest.accept_quest(quest_name)
			return initial_text
		Quest.STATUS.STARTED:
			print("aca")
			if Inventory.get_item(required_item) >= required_amount:
				Inventory.remove_item(required_item, required_amount)
				Quest.change_status(quest_name, Quest.STATUS.COMPLETE)
				Inventory.add_item(reward_item, reward_amount)
				return delivered_text
			else:
				return pending_text
		_:
			return ""

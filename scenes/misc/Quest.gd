extends Node

"""
Instance this as a child of any Npc.tscn node and it turns into a 
quest giver.

The character will also check if the player has a certain amount of a given item and if true
Remove said amount from the players inventory and give some amount of another item as a reward
This is only useful for fetch quests but you can also ask for '5 demon horns' or something to turn it
into a kill quest.
Otherwise you'll have to make a quest system a bit more complex. 
"""

@export var quest_name: String = "Life as a Rappi Guy"

@export var required_item: String = "Generic Item"
@export var required_amount: int = 10
@export var reward_item: String = "Generic Reward"
@export var reward_amount: int = 1

@export var initial_text = "TLDR; bring me 10 thingies" # (String, MULTILINE)
@export var pending_text = "You forgot? I want 10 thingies" # (String, MULTILINE)
@export var delivered_text = "Thank you! Here's your reward.." # (String, MULTILINE)

func process() -> String:
	var quest_status = Quest.get_status(quest_name)
	match quest_status:
		Quest.STATUS.NONEXISTENT:
			Quest.accept_quest(quest_name)
			return initial_text
		Quest.STATUS.STARTED:
			if Inventory.get_item(required_item) >= required_amount:
				Inventory.remove_item(required_item, required_amount)
				Quest.change_status(quest_name, Quest.STATUS.COMPLETE)
				Inventory.add_item(reward_item, reward_amount)
				return delivered_text
			else:
				return pending_text
		_:
			return ""

# **KeeAdmin**
**An administration system to fit all your needs.**

*Fast command execution and easy configuration, you won't be disappointed.*

## **Packages**
To make a package, go to the Packages file in `KeeAdmin/CORE/Packages`, and follow this template:
```lua
	{
		name = "test", --// Name of the command, word used to execute it
		info = "prints hello world in the console", --// What the command does
		aliases = {"test2", "veryepic"}, --// Another word to execute it, the list can go on
		category = "misc", --// Category of command (misc, fun, moderation)
		level = 0, --// 0 = player, 1 = moderator, 2 = admin, 3 = owner
		VisibleInCommandList = false, --// Should the command show up in the command list
		
		execute = function(player, args) --// Function that is run when the command is executed. Player is the player who executed the command. Args is a table of all the words past the command.
			print("Hello world!")
		end,
	}
```
All Packages are Server-sided

## **Execution** 
You can send one or more commands in a message. In `KeeAdmin/CORE/Settings`

`:speed me | :sit me`

`:shutdown`

## **Settings**
```lua
Prefix = ":", --// What starts your command (ex. the : in :kill me)
Split = " | ", --// Splits your message into multiple commands (ex. :speed me 50 | :fly me)

ToolsDirectory = game.ReplicatedStorage, --// Where the tools will be stored 

--// Format "Username" or UserId i.e the 153125476 in https://www.roblox.com/users/153125476/profile
Moderators = {}, --// Level 1
Admins = {}, --// Level 2
Owners = {"zCrxtix", 153125476}, --// Level 3	

GamePassAdmin = { --// Coming Soon
	[0] = {
		0
	}
},
Banned = { --// Add any users you want banned using the format for moderators
	
},

FunCommandsEnabled = true, --// Can fun commands be executed
PlaceOwnerPermissionsEnabled = true, --// Should the owner of the game have Owner permissions
AdminCreatorPermissionsEnabled = false --// Should the creator of KeeAdmin have Owner Permissions (mostly used for testing)
```

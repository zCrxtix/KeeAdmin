# KeeAdmin
An Admin System to Fit All of Your Needs

With fast command execution and easy configuration, you won't be disappointed.

## Packages
To make a package, go to the Packages file in the LOADER, not source, and follow this template:
```
{
	name = "test", --name of the command, word used to execute it
	aliases = {"test2"}, --another word to execute it, the list can go on
	category = "misc", --category of command (misc, fun, moderation)
	level = 0, --0 = player, 1 = moderator, 2 = admin, 3 = owner
		
	execute = function(player, args) --what happens when the command is ran
		print("Hello world!")
	end,
}
```
## Execution
You can send one or multiple commands in a message:

`:speed me | :sit me`
`:shutdown`

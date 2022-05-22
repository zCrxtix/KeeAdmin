# **KeeAdmin v2**
**Slogan TBD**

## **Packages**
To make a package, go to the Packages folder in `KeeAdmin/Core/Packages`. You can either make a server-sided or a client-sided command.
To make a package, use the following format:
```lua
{
	name = "clienttest", --// What is used to execute the command
	aliases = {"clienttest2", "clienttest3"}, --// More words to execute it
	prefix = ":", --// First character to signal that the command is going to be executed
	description = "Test command for packages on the client", --// Description for command in commands list
	category = "misc", --// Category for command in commands list
	level = 0, --// What permission level is required to execute the command
		
	execute = function(player, args)
		print("Hello from the client!")
		print(string.format("Player %s sent client test package", player.Name))
	end,
}
```

## **Execution** 
To execute a command, use the prefix set inside of `KeeAdmin/Core/Configuration`<br>
You can change `split` or `prefix`<br>
`split` is used to split commands. For example, the '|' in:<br>
:speed me 15 | :sit me<br>

`prefix` is used to define a command. For example the ':' in:<br>
`:speed me 100`

## **Configuration**
To configure KeeAdmin, go to `KeeAdmin/Core/Configuration`.<br>
`prefix` and `split` see "Execution"

`DataStoreKey` **CHANGE THIS** This is used to save and store your data. Changing it will result in losing all your data. If it is set back data will be restored.

It is reccomended to use a user's UserId to set their rank. Username also works.<br>
`Moderators` Level 1<br>
`Administrators` Level 2<br>
`Owners` Level 3<br>

`ToolsDirectory` Where tools are stored

`FunCommandsEnabled` Whether or not fun commands are allowed<br>
`PlaceOwnerPermissionsEnabled` Gives the owner of the game owner permissions
`AdminCreatorPermissionsEnabled` Gives the creators of KeeAdmin owner permissions

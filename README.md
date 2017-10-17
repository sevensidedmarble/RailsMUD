#### Dark Elf -- A MUD (Multi User Dungeon) framework in Ruby on Rails
--

View a live demo [here.](https://dark-elf-mud.herokuapp.com/home)

Keep in mind this is a work in progress, most of the current work was setting up the framework to actually send messages both through ActionCable and the custom Telnet server. Certain functionality might not be there yet but the skeleton of the game is working. In particular, currently the Rails server will not start the telnet process when Rails starts. That will be fixed soon.
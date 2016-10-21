require "awesome_print"
AwesomePrint.pry!

Pry.config.prompt = proc { |obj, nest_level, _| "(#{obj}):#{nest_level}> " }
Pry.config.history.should_save = false

Pry.commands.alias_command 'q', 'exit' rescue nil

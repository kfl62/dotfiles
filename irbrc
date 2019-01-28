#!/usr/bin/env ruby
require 'rubygems'
require 'wirble'
require 'irb/ext/save-history'

Wirble::Colorize::Color::COLORS.merge!({
  :blue => '0;35'
})

Wirble.init
Wirble.colorize

alias q exit

IRB.conf[:PROMPT][:MY_PROMPT] = IRB.conf[:PROMPT][:SIMPLE].merge(
  :PROMPT_S=>"%l>> ",
  :PROMPT_C=>"*>> ",
)
IRB.conf[:PROMPT_MODE] = :MY_PROMPT
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end
end

load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']

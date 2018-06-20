# frozen_string_literal: true

folders = 'lib,config,services,forms,controllers,models'
Dir.glob("./{#{folders}}/init.rb").each do |file|
  require file
end

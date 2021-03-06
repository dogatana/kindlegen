require "kindlegen/version"
require 'pathname'
require 'open3'

module Kindlegen
  Root = Pathname.new(File.expand_path('../..', __FILE__))
  Bin  = Root.join('bin')

  #
  # Getting command path of kindlegen.
  #
  def self.command
    Bin.join('kindlegen')
  end

  #
  # Run kindlegen command with spacified parameters
  #
  # _params_:: array of command parameters.
  #
  def self.run( *params )
    clean_env do
      Open3.capture3("#{command} #{params.join(' ')}")
    end
  end

private
  def self.clean_env
    env_backup = ENV.to_h
    ENV.clear
    ret = yield
    ENV.replace(env_backup)
    return ret
  end
end

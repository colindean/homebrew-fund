# frozen_string_literal: true

require "pathname"

def which(command)
  Pathname("/usr/local/bin/#{command}")
end

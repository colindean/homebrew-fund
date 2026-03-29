# frozen_string_literal: true

def which(command)
  Pathname("/usr/local/bin/#{command}")
end

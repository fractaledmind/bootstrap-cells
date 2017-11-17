# frozen_string_literal: true

require 'cells'
require 'cells-erb'

require 'bootstrap-cells/version'
require 'bootstrap-cells/cell'

Dir[::File.join(__dir__, 'cells', '**', '*.rb')].each do |cell|
  require cell
end

module BootstrapCells
end

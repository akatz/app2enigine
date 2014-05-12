require 'foo'
require 'bar'

module Monorail
  class EmptyClass
    def something
      require 'baz'
    end
  end
end

module Staircase

  def add_step(id, step)
    @@steps ||= {}
    @@steps[id] = step
  end

  def get_step(id)
    @@steps[id]
  end
  
  def define_step(id, opts={}, &block)
    add_step id, Step.new(id, opts[:previous], &block)
    run_step(id) if opts[:run]
  end

  def run_step(id)
    step = get_step(id)
    if step
      run_step(step.previous)
      instance_eval(&step.block)
    end
  end
  
  class Step
    attr_accessor :id, :previous, :block
    def initialize(id, previous=nil, &block)
      @id, @previous, @block = id, previous, block
    end
  end
end
include Staircase

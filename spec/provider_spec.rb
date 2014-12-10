require 'spec_helper'

describe Thornbed::Providers::Provider do
  it "raises NotImplementedError when pattern is not implemented in a subclass" do
    Proc.new do
      klass = Class.new(Thornbed::Providers::Provider)
      klass.new.pattern.must_raise NotImplementedError
    end
  end
end

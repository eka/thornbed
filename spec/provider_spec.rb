require 'spec_helper'

describe Thornbed::Providers::Provider do
  it "raises NotImplementedError when pattern is not implemented in a subclass" do
    klass = Class.new(Thornbed::Providers::Provider)
    -> { klass.new.pattern }.should raise_error(NotImplementedError)
  end
end

class Thornbed < Thor
  include Thor::Actions

  desc 'test', 'run all tests'
  def test
    $:.unshift './lib', './spec'
    Dir.glob('./spec/**/*_spec.rb').each do |filename|

      # puts `ruby -Ilib -Ispec #{filename}`
      require filename
    end
  end
end
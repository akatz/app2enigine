describe App2engine::FileConverter do
  context 'with an empty class' do
    let(:file) { 'spec/fixtures/rails_app/app/models/empty_class.rb' }
    let(:converted_contents) { "module Monorail\n  class EmptyClass\n  end\nend\n" }
    it 'will namespace the class' do
      expect(described_class.new(file).call).to eq(converted_contents)
    end
  end

  context 'with a class with requires' do
    let(:file) { 'spec/fixtures/rails_app/app/models/class_with_require.rb' }
    let(:converted_contents) { "require 'foo'\nrequire 'bar'\n\nmodule Monorail\n  class EmptyClass\n    def something\n      require 'baz'\n    end\n  end\nend\n" }
    it 'will namespace after requires' do
      expect(described_class.new(file).call).to eq(converted_contents)
    end
  end
end

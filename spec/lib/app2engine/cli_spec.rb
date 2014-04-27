require 'fileutils'
describe App2engine::Cli do
  let(:fixture_file) { "spec/fixtures/auth_token.rb" }
  let(:fixture_file_backup) { "spec/fixtures/auth_token.rb.old" }
  let(:conversion_command) { "convert" }

  let(:expected_output_file) { "spec/fixtures/converted_auth_token.rb" }
  let(:original_file) { "spec/fixtures/bad_auth_token.rb" }

  before do
    FileUtils.copy(original_file, fixture_file)
  end

  after do
    File.delete(fixture_file_backup) if File.exists?(fixture_file_backup)
    File.delete(fixture_file) if File.exists?(fixture_file)
  end

  it 'can convert a file' do
    described_class.start([conversion_command, fixture_file])
    expect(File.read(fixture_file)).to eq(File.read(expected_output_file))
  end

  it 'saves a copy of the old file alongside the new one' do
    described_class.start([conversion_command, fixture_file])

    expect(File).to exist(fixture_file_backup)
  end
end

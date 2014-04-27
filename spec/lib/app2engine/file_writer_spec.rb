require 'app2engine/file_writer'

describe App2engine::FileWriter do
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

  context 'with the backup option set' do
    it 'writes out the contents of the file as a backup' do
      described_class.new(fixture_file, backup: true).call('')

      expect(File).to exist(fixture_file_backup)
    end
  end
end

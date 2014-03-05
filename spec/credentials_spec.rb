require 'spec_helper'


describe TwitterUs do
  context 'credentials and initializing basic client' do
    describe 'configuration of credentializing' do
      it 'should have ::DEFAULT_KEY_FILE point to ENV["TWITTER_CREDS"]' do
        expect(TwitterUs::DEFAULT_KEY_FILE).to eq SPEC_TWITTER_CREDS_FILE
      end
    end

    subject(:filename){ SPEC_TWITTER_CREDS_FILE }
    subject(:creds){ YAML.load_file(filename) }
    subject(:cred_values){ creds.values}

    describe 'instantiation and client initialization' do
      describe '.new' do
        it 'basically defers to .initialize_client' do
          client = TwitterUs.initialize_client(creds)
          # this test sucks
          expect(TwitterUs.new(creds).client.credentials).to eq client.credentials          
        end
      end

      describe '.initialize_client' do

        it 'should return a Twitter::REST::Client' do
          expect(TwitterUs.initialize_client).to be_a Twitter::REST::Client
        end

        context 'no arguments' do
          it 'should create client using options from default cred file' do
            expect(TwitterUs.initialize_client.credentials.values).to eq cred_values
          end
        end

        context 'filename as String is passed in' do
          it 'should parse filename as YAML' do
            tempfile = Tempfile.new('foo')
            tempfile.tap{ |f| f. write(creds.to_yaml); f.rewind }
            client = TwitterUs.initialize_client(tempfile.path)

            expect(client.credentials.values).to eq cred_values
          end
        end

        context 'options Hash is passed in' do
          it 'should create a client' do
            expect(TwitterUs.initialize_client(creds)).to be_a Twitter::REST::Client
          end
        end
      end
    end
  end
end
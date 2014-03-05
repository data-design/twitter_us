require 'spec_helper'

describe TwitterUs do
  subject{ TwitterUs.new }

  describe '#fetch_user' do
    context 'with a :screen_name (as String)', vcr: true  do      
      let(:screen_name){'librarycongress'}
      let(:user){ subject.fetch_user(screen_name) } 
        
      it 'should be a Hash' do
        expect(user).to be_a Hash
      end

      it 'should contain Twitter::User data' do
        expect(user[:screen_name]).to eq screen_name
      end
    end

    context 'with a :user_id (as Integer)', vcr: true  do
      let(:user_id){ 7152572 }
      let(:user){ subject.fetch_user(user_id) } 
    end
  end

  describe '#fetch_users' do
    describe 'yield and return value', vcr: true do      
      let(:screen_names){['ev', 'twitter']}

      it 'should yield for each screen_name found' do
        expect{ |b| subject.fetch_users(screen_names, &b) 
          }.to yield_control.exactly(screen_names.length).times
      end

      it 'should yield a Hash each time' do
        expect{ |b| subject.fetch_users(screen_names, &b) }.to yield_successive_args(Hash, Hash)
      end

      it 'should return the last member as a Hash' do
        expect(subject.fetch_users(screen_names){}[:screen_name]).to eq screen_names.last
      end 

      it 'should raise an error if no block given' do
        expect{ subject.fetch_users(screen_names) }.to raise_error LocalJumpError
      end
    end  



    context 'more than 100 values as an array' do      
      let(:big_screen_names){ Array(1..101).map(&:to_s) }

      it 'should call the :fetch routine twice'
    end



    
  end
end
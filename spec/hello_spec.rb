require 'spec_helper'

describe 'Hello World' do 
  it 'should say hello' do
    expect('hello').to be_a String
  end
end


describe 'Hello TwitterUs' do
  it 'should be a Class' do
    expect(TwitterUs).to be_a Class
  end
end
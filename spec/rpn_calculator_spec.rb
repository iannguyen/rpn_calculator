require 'rspec'
require_relative '../lib/rpn_calculator'
require_relative 'spec_helper'

describe RPNCalculator do
  before :each do
    @rpn = RPNCalculator.new
  end

  it 'ignores invalid inputs' do
    @rpn.test_input('ezpz')
    @rpn.test_input('l3m0n $qu3ezy')

    expect(@rpn.stack).to be_empty
  end

  it 'ignores operations unless there are at least 2 numbers' do
    @rpn.test_input('+')
    expect(@rpn.stack).to be_empty

    @rpn.test_input('1')
    @rpn.test_input('-')
    expect(@rpn.stack).to eq([1.0])
  end

  it 'performs an operation if there are at least 2 numbers' do
    @rpn.test_input('1')
    @rpn.test_input('2')
    @rpn.test_input('+')

    expect(@rpn.stack).to eq([3.0])
  end

  it 'does not divide by zero' do
    @rpn.test_input('4')
    @rpn.test_input('0')
    @rpn.test_input('/')

    expect(@rpn.stack).to eq([4.0, 0.0])
  end

  it 'handles negative numbers' do
    @rpn.test_input('-3')
    @rpn.test_input('-9')
    @rpn.test_input('*')

    expect(@rpn.stack).to eq([27.0])
  end

  it 'handles float numbers' do
    @rpn.test_input('1.5')
    @rpn.test_input('-5.0')
    @rpn.test_input('-')

    expect(@rpn.stack).to eq([6.5])
  end
end

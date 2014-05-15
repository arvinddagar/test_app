# /spec/models/Setting_spec.rb
require 'spec_helper'

describe Setting do
  before do
    @config = Setting.new(name: 'foo', value: 'bar', data_type: 'String')
  end

  it{ should validate_presence_of :name }

  it 'should be valid from factory' do
    expect(@config).to be_valid
  end

  context '#get' do
    before do
      @config.save!
      Setting.create(name: 'fixnum_config', value: 1234, data_type: 'Fixnum')
      Setting.create(name: 'float_config', value: 122.234, data_type: 'Float')
      Setting.create(name: 'false_boolean_config', value: false, data_type: 'FalseClass')
      Setting.create(name: 'true_boolean_config', value: true, data_type: 'TrueClass')
    end

    it 'should get config String value' do
      expect(Setting[:foo]).to eq 'bar'
    end

    it 'should get config Fixnum value' do
      expect(Setting[:fixnum_config]).to eq 1234
    end

    it 'should get config Float value' do
      expect(Setting[:float_config]).to eq 122.234
    end

    it 'should get config Flase Boolean value' do
      expect(Setting[:false_boolean_config]).to eq false
    end

    it 'should get config True Boolean value' do
      expect(Setting[:true_boolean_config]).to eq true
    end

    it 'should return nil when not found' do
      expect(Setting[:not_found_config]).to be_nil
    end

    it 'should return array' do
      expect(Setting[:foo, :fixnum_config]).to eq ['bar', 1234]
    end
  end

end
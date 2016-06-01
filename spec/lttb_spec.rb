require 'spec_helper'

describe Lttb do
  let(:data) { (1..200).map { |i| [i, i ^ 2] } }
  let(:datetime_data) { (1..20).map { |i| [DateTime.now - (10 - i), i ^ 2] } }

  it 'has a version number' do
    expect(Lttb::VERSION).not_to be nil
  end

  it 'samples down to correct size' do
    expect(Lttb.process(data, 50).size).to eq(50)
  end

  it 'works with DateTime objects' do
    expect(Lttb.process(datetime_data, 10, dates: true).size).to eq(10)
  end

  it 'does not change DateTime objects' do
    d = datetime_data
    expect(Lttb.process(d, 10, dates: true)[0][0]).to eq(d[0][0])
  end
end

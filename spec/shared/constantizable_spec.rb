require "spec_helper"

shared_examples "constantizable" do

  constantized_columns = described_class.instance_variable_get(:@constantized_columns)

  create_mock_record_with = -> (column_data) {
    described_class.new({ constantized_columns[0] => column_data })
  }

  context "##{constantized_columns}" do
    it "returns an string" do
      record = create_mock_record_with.call("sample")
      described_class.stub(:find_by).and_return(record)
      expect(record.send(constantized_columns[0])).to be_an_instance_of String
    end
  end
  
  context "querying" do
    context "when #{described_class.to_s} is queried with :#{constantized_columns}" do
      it "when :#{constantized_columns} contains single word" do
        record = create_mock_record_with.call("sample")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample).to eq record
      end

      it "when :#{constantized_columns} contains more than 1 word without space" do
        record = create_mock_record_with.call("sample_name")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample_name).to eq record
      end

      it "when :#{constantized_columns} contains more than 1 word with space" do
        record = create_mock_record_with.call("sample name")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample_name).to eq record
      end

      it "when :#{constantized_columns} contains more than 1 word with space and upper case" do
        record = create_mock_record_with.call("Sample Name")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample_name).to eq record
      end
    end
  end

  context "inquiry" do
    context "when an instance of #{described_class.to_s} is inquired with :#{constantized_columns}?" do
      it "when :#{constantized_columns} contains single word" do
        record = create_mock_record_with.call("sample")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample.sample?).to eq true
      end

      it "when :#{constantized_columns} contains more than 1 word without space" do
        record = create_mock_record_with.call("sample_name")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample_name.sample_name?).to eq true
      end

      it "when :#{constantized_columns} contains more than 1 word with space" do
        record = create_mock_record_with.call("sample name")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample_name.sample_name?).to eq true
      end

      it "when :#{constantized_columns} contains more than 1 word with space and upper case" do
        record = create_mock_record_with.call("Sample Name")
        described_class.stub(:find_by).and_return(record)
        expect(described_class.sample_name.sample_name?).to eq true
      end
    end
  end
end

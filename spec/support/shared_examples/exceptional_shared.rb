require 'spec_helper'

RSpec.shared_examples "exceptional" do
  let(:model) { described_class }
  let(:model_sym) { described_class.to_s.underscore.to_sym }

  describe "exceptions for` #{described_class.name}" do
    before { @instance = model.new }

    context "adding errors" do
      it "should add an error with translation" do
        expect(@instance).to respond_to(:add_error)
        attr = model.validators.last.attributes.first
        expect { @instance.add_error(attr, "errors.messages.blank") }.to change { @instance.errors.size }.from(0).to(1)
      end

      it "should add an error with translation and raise an Exceptions::Model" do
        expect(@instance).to respond_to(:add_error!)
        attr = model.validators.last.attributes.first
        expect { @instance.add_error!(attr, "errors.messages.blank") }.to raise_error(Exceptions::Model)
      end
      
      it "should add an error with message" do
        expect(@instance).to respond_to(:add_error_with_message)
        attr = model.validators.last.attributes.first
        expect { @instance.add_error(attr, "something goes wrong") }.to change { @instance.errors.size }.from(0).to(1)      
      end

      it "should add an error with message and raise an Exceptions::model" do
        expect(@instance).to respond_to(:add_error_with_message!)
        attr = model.validators.last.attributes.first
        expect { @instance.add_error!(attr, "something goes wrong") }.to raise_error(Exceptions::Model)
      end
    end

    context "raising exceptios" do
      it "should raise Exceptions::Simple with translation" do
        expect(model).to respond_to(:raise_simple)
        attr = model.validators.last.attributes.first
        expect { model.raise_simple(attr, "errors.messages.blank") }.to raise_error(Exceptions::Simple)
      end

      it "should raise Exceptions::Model with translation" do
        expect(model).to respond_to(:raise_model)
        attr = model.validators.last.attributes.first
        expect { model.raise_model(attr, "errors.messages.blank") }.to raise_error(Exceptions::Model)      
      end

      it "should raise Exceptions::Model with error" do
        expect(model).to respond_to(:raise_model!)
        @instance.valid?
        expect { model.raise_model!(@instance.errors.first) }.to raise_error(Exceptions::Model)
      end
    end

  end
end

require 'spec_helper'

RSpec.shared_examples "buildable" do
  let(:model) { described_class }
  let(:model_sym) { described_class.to_s.underscore.to_sym }

  describe "building #{described_class.name}" do
    context "creating" do
      it "should build a new #{described_class.name} with a database record" do
        expect( model.build(attributes_for(model_sym) ).class.name ).to eql(model.to_s)
      end

      it "should raise Exceptions::Model if has any invalid param" do
        if model.validators.size > 1
          expect { model.build({}) }.to raise_error(Exceptions::Model)
        end
      end
    end

    context "updating" do
      before do 
        @instance = model.build(attributes_for(model_sym))
      end

      it "should update a #{described_class.name}" do
        expect(@instance.build_update(attributes_for(model_sym))).to be true  
      end

      it "should raise an Exceptions::Model if some param is invalid" do
        if model.validators.size > 1
          attr = model.validators.last.attributes.first
          expect { @instance.build_update(attr => "") }.to raise_error(Exceptions::Model)
        end  
      end

    end
  end
end

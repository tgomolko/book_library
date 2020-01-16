require 'rails_helper'

RSpec.describe CreateProduct do
  subject(:context) { CreateProduct.call(params) }

  let(:params) { FactoryBot.attributes_for(:product) }
  let(:product) { FactoryBot.create(:product) }
  let(:stipe_plan) { instance_double(Stripe::Product) }
  let(:product) { instance_double(Stripe::Products::Create) }
  let(:stubbed_product_params) { params.merge(stripe_id: "id") }

  before do
    allow(Product).to receive(:create).with(stubbed_product_params).and_return(product)
    allow(Stripe::Products::Create).to receive(:new).and_return product
    allow(product).to receive(:call).and_return stipe_plan
    allow_any_instance_of(CreateProduct).to receive(:build_product_params).and_return stubbed_product_params
  end

  describe ".call" do
    it "succeeds" do
      expect(context).to be_a_success
    end

    # it "provides the product" do
    #   expect(context.product).to eq(product)
    # end
  end
end

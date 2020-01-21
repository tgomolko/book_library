require 'rails_helper'

RSpec.describe CreateProduct do
  subject(:context) { CreateProduct.call(product_params: product_params) }

  let(:product_params) { attributes_for(:product) }
  let(:stipe_plan) { double(:stipe_plan, id: "plan_GQ5df6yO2ZK0Cm") }

  describe ".call" do
    before do
      allow(Stripe::Products::Create).to receive_message_chain(:new, :call) { stipe_plan }
    end

    context "when given correct params" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the product" do
        expect(context.product).to eq(Product.last)
      end
    end

    context "when stripe service fails" do
      before do
        allow(Stripe::Products::Create).to receive_message_chain(:new, :call).and_raise(Stripe::StripeError, "error message")
      end

      it "fails" do
        expect(context).to be_a_failure
      end

      it "provides a failure message" do
        expect(context.message).to be_present
      end
    end

    context "when active record fails" do
      before do
        allow(Product).to receive(:create!).and_raise(ActiveRecord::ActiveRecordError, "error message")
        allow(Stripe::Products::Destroy).to receive_message_chain(:new, :call) { stipe_plan }
      end

      it "fails" do
        expect(context).to be_a_failure
      end

      it "provides a failure message" do
        expect(context.message).to be_present
      end
    end

  end
end

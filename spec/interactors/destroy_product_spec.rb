require 'rails_helper'

RSpec.describe DestroyProduct do
  subject(:context) { DestroyProduct.call(product: product) }

  let(:product) { create(:product) }

  describe ".call" do
    context "when given product" do
      before do
        allow(Stripe::Products::Destroy).to receive_message_chain(:new, :call) { true }
      end

      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the product" do
        expect(context.product).to eq(product)
      end
    end

    context "when stripe service fails" do
      before do
        allow(Stripe::Products::Destroy).to receive_message_chain(:new, :call).and_raise(Stripe::StripeError, "error message")
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
        allow(Product).to receive(:destroy).and_raise(ActiveRecord::ActiveRecordError, "error message")
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

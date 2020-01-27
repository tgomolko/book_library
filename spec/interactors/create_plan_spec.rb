require 'rails_helper'

RSpec.describe CreatePlan do
  subject(:context) { CreatePlan.call(plan_params: plan_params) }

  let(:plan_params) { attributes_for(:plan, product_id: create(:product).id ) }
  let(:stripe_plan) { double(:stripe_plan, id: "plan_GQ5df6yO2ZK0Cm") }

  describe ".call" do
    before do
      allow(Stripe::Plans::Create).to receive_message_chain(:new, :call) { stripe_plan }
    end

    context "when given correct params" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the plan" do
        expect(context.plan).to eq(Plan.last)
      end
    end

    context "when stripe service fails" do
      before do
        allow(Stripe::Plans::Create).to receive_message_chain(:new, :call).and_raise(Stripe::StripeError, "error message")
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
        allow(Plan).to receive(:create!).and_raise(ActiveRecord::ActiveRecordError, "error message")
        allow(Stripe::Plans::Destroy).to receive_message_chain(:new, :call) { stripe_plan }
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

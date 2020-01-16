require_dependency("create")

class CreatePlan
  include Interactor

  delegate :plan_params, :product_stripe_id, to: :context

  def call
    Plan.transaction do
      @stripe_plan = Stripe::Plans::Create.new(plan_params, product_stripe_id).call

      context.plan = Plan.create!(build_plan_params)
    end

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError  => e
      rollback if e.kind_of?(ActiveRecord::ActiveRecordError)
      context.fail!(message: e.message)
  end

  private

  def rollback
    Stripe::Plans::Destroy.new(@stripe_plan.id).call if @stripe_plan.id
  end

  def build_plan_params
    plan_params.merge(stripe_id: @stripe_plan.id)
  end
end

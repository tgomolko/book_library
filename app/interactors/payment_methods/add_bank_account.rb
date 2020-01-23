require_dependency("add_bank_account")

class AddBankAccount
  include Interactor

  delegate :bank_account_token, :current_user, to: :context

  def call
    @bank_account = Stripe::PaymentMethods::AddBankAccount.new(bank_account_token, current_user.stripe_id).call

    context.bank_account = current_user.payment_methods.create!(stripe_id: @bank_account.id)

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError => error
      rollback if error.kind_of?(ActiveRecord::ActiveRecordError)
      context.fail!(message: error.message)
  end

  private

  def rollback
    #Stripe::PaymentMethods::Destroy.new(@bank_account.id, current_user.id).call if @bank_account.id
  end
end

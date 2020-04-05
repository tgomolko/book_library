class PdfBillGenerator
  include Interactor

  delegate :charge, :current_user, to: :context

  def call
    context.charge = Receipts::Receipt.new(
      id: charge.id,
      subheading: "RECEIPT FOR CHARGE #{charge.id}",
      product: product_name,
      company: {
        name: "BookLibrary, Inc.",
        address: "49 Platonova \nFloor 9\nMinsk",
        email: "bookLibrary@gmail.com",
        logo: Rails.root.join("app/assets/images/logo_book.png")
      },
      line_items: [
        ["Date",           created_at],
        ["Account Billed", "#{customer_name} (#{customer_email})"],
        ["Product",        product_name],
        ["Amount",         "$#{product_price}"],
        ["Charged to",     "Card (**** **** **** #{charge.user.payment_methods.last.last4})"],
        ["Transaction ID", charge.stripe_id]
      ],
    )
  end

  private

  def product_price
    charge.book.price.to_f
  end

  def created_at
    charge.created_at.localtime.strftime("%d.%m.%Y, %H:%M")
  end

  def product_name
    charge.book.title
  end

  def customer_email
    charge.user.email
  end

  def customer_name
    charge.user.name
  end
end

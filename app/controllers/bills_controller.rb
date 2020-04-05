class BillsController < ApplicationController
  before_action :load_charge

  def generate
    respond_to do |format|
      format.pdf {
        send_data PdfBillGenerator.call(charge: @charge).charge.render,
          filename: "#{@charge.created_at.strftime("%Y-%m-%d")}-book_library-bill.pdf",
          type: "application/pdf",
          disposition: :inline
      }
    end
  end

  def load_charge
    @charge = Charge.find(params[:id])
  end
end

class CustomersController < ApplicationController
  def index
    @customers = Customer.all
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @customers }
      format.xls{ headers['Content-Disposition'] = 'attachment; filename=customers.xls' }
    end

  end

  def new
    @customer = Customer.new
    @address_types = AddressType.all
    @address = @customer.addresses.build
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to customers_path, alert: "Customer created successfully."
    else
      flash[:alert] = "Customer could not created."
      render action: :new
    end

  end

  def edit
    @address_types = AddressType.all
    get_customer

    @customer.addresses.build  if @customer.addresses.blank?
  end

  def update

    get_customer
    if @customer.update(customer_params)
      redirect_to customers_path, alert: "Customer updated successfully."
    else
      flash[:alert] = "Customer could not updated."
      render action: :edit
    end

  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, addresses_attributes:[:id, :address, :city, :state, :address_type_id])

  end

  def get_customer
    return redirect_to customers_path if params[:id].blank?

    @customer = Customer.where(id: params[:id]).first

  end
end

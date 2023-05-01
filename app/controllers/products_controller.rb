class ProductsController < ApplicationController
  def index
    @categories = Category.all.order(name: :asc).load_async
    @pagy, @products = pagy_countless(FindProducts.new.call(params).load_async, items: 12)
  end

  def show
    product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: t('createdMsg')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    product
  end

  def update
    if product.update(product_params)
      redirect_to products_path, notice: t('editedMsg')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product.destroy
    redirect_to products_path, notice: t('deletedMsg'), status: :see_other
  end

  def product_params
    params.require(:product).permit(:title,:description,:price,:photo, :category_id)
  end

  def product
    @product = Product.find(params[:id])
  end
end
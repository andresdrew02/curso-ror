class ProductsController < ApplicationController
  def index
    @categories = Category.all.order(name: :asc).load_async
    @products = Product.all.with_attached_photo
    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end
    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price])
    end
    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])
    end
    if params[:title].present?
      @products = @products.where("title like ?", "%#{params[:title]}%").
        or(@products.where("description like ?", "%#{params[:title]}%"))
    end
    orders = {
      newest: "created_at DESC",
      expensives: "price DESC",
      cheapest: "price ASC"
    }.fetch(params[:order_by]&.to_sym, "created_at DESC")
      @products = @products.order(orders).load_async
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
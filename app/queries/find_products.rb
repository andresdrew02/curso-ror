class FindProducts
  attr_reader :products
  def initialize(products = initial_scope)
    @products = products
  end

  def call(params = {})
    scoped = products
    scoped = filter_by_category_id(scoped, params[:category_id])
    scoped = filter_by_min_price(scoped, params[:min_price])
    scoped = filter_by_max_price(scoped, params[:max_price])
    scoped = filter_by_name(scoped,params[:title])
    sort(scoped,params[:order_by])
  end

  private
  def initial_scope
    Product.with_attached_photo
  end

  def filter_by_category_id(scoped,category_id)
    return scoped unless category_id.present?

    scoped.where(category_id: category_id)
  end

  def filter_by_min_price(scoped,min_price)
    return scoped unless min_price.present?

    scoped.where("price >= ?",min_price)
  end

  def filter_by_max_price(scoped,max_price)
    return scoped unless max_price.present?

    scoped.where("price <= ?",max_price)
  end

  def filter_by_name(scoped,search)
    return scoped unless search.present?

    scoped.where("title like ?", "%#{search}%").
      or(@products.where("description like ?", "%#{search}%"))
  end

  def sort(scoped,order_by)
    order_by_query = Product::ORDER_BY.fetch(order_by&.to_sym,
                                    Product::ORDER_BY[:newest])
    scoped.order(order_by_query)
  end
end
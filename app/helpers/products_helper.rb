module ProductsHelper
  def product_form_opts(category, product)
    if product.new_record?
      { model: [ category, category.products.build ], class: "w-100", multipart: true }
    else
      { model: product, url: category_product_path(category), method: :patch, local: true, multipart: true }
    end
  end
end

module RenderPartial
  def partial(page, options={})
    haml page, options.merge!(:layout => false)
  end
end

if respond_to?(:helpers)
  helpers RenderPartial
end

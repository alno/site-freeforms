module FormsHelper
  def e(str)
    HTMLEntities.encode_entities(str, :basic, :decimal)
  end
end

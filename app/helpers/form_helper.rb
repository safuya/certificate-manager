module FormHelper
  def create_or_update(item)
    item.new_record? ? 'CREATE' : 'UPDATE'
  end
end

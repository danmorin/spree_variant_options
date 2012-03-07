Spree::Product.class_eval do

  include ActionView::Helpers::NumberHelper

  def option_values
    # Sorting by presentation so color is always first. It would be nice
    # to do this with acts_as_list, but we're always adding new option types
    # so this easier for now.
    option_types.sort{|a,b| a.presentation<=>b.presentation}.map{|i| i.option_values }.flatten.uniq
  end
  
  def grouped_option_values
    option_values.group_by(&:option_type)
  end
  
  def variant_options_hash  
    return @variant_options_hash if @variant_options_hash
    @variant_options_hash = Hash[grouped_option_values.map{ |type, values| 
      [type.id.inspect, Hash[values.map{ |value|         
        [value.id.inspect, Hash[variants.includes(:option_values).select{ |variant| 
          variant.option_values.select{ |val| 
            val.id == value.id && val.option_type_id == type.id 
          }.length == 1 }.map{ |v| [ v.id, { :id => v.id, :count => v.count_on_hand, :price => number_to_currency(v.price), :image_id => v.images.first.try(:id) } ] }]
        ]
      }]]
    }]
    @variant_options_hash
  end
  
end

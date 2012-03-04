Spree::OptionValue.class_eval do

  default_scope order(:position)
    
  has_attached_file :image, 
    :styles => { :small => '40x30#', :large => '140x110#' },
    :default_style => :small
    
  validates :hex_color, :length => { :is => 6, :allow_blank => true }
  
  def has_image?
    image_file_name && !image_file_name.empty?
  end
  
  def hex_color=(value)
    write_attribute(:hex_color, value.gsub('#', ''))
  end
  
  def formatted_hex_color
    "##{read_attribute(:hex_color)}" if hex_color?
  end
  
end

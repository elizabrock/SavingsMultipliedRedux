class AuctionSearch
  include ActiveModel::Model

  attr_accessor :brand_ids, :clothing_condition_id, :child_configuration_id, :child_genders, :clothing_size_ids, :clothing_type_ids, :season_ids, :search_term, :siblings_type, :sort_by

  def initialize(params = {})
    return unless params.is_a? Hash
    params.each do |name, value|
      send("#{name}=", value)
    end
  end

  def compact(value)
    if value.is_a? String
      value.blank? ? nil : value.gsub(/\[|\]/,'').split(/,/).map(&:to_i)
    else
      value = value.delete_if(&:blank?)
      value.empty? ? nil : value.map(&:to_i)
    end
  end

  def brand_ids=(value)
    @brand_ids = compact(value)
  end

  def clothing_condition_id=(value)
    @clothing_condition_id = compact(value)
  end

  def clothing_size_ids=(value)
    @clothing_size_ids = compact(value)
  end

  def clothing_type_ids=(value)
    @clothing_type_ids = compact(value)
  end

  def season_ids=(value)
    @season_ids = compact(value)
  end

  def child_configuration
    if child_configuration_id.present?
      @child_configuration = ChildConfiguration.find(child_configuration_id)
    elsif @siblings_type and @child_genders
      @child_configuration = ChildConfiguration.where(siblings_type: params[:siblings_type], genders: params[:genders]).first
    end
    @child_configuration
  end

  def needs_child_genders?
    !(child_configuration_id || child_genders)
  end

  def possible_child_configurations
    if child_configuration
      [child_configuration]
    elsif siblings_type
      ChildConfiguration.where(:siblings_type => siblings_type)
    else
      ChildConfiguration.all
    end
  end

  def siblings_type
    @siblings_type || child_configuration.try(:siblings_type)
  end

  def needs_siblings_type?
    !(child_configuration_id || siblings_type)
  end

  def auctions
    composed_scope = Auction.active
    composed_scope = composed_scope.joins(:child_configurations).where('auction_child_configurations.child_configuration_id' => possible_child_configurations)

    if brand_ids.present?
      composed_scope = composed_scope.where(brand_id: brand_ids)
    end

    if clothing_condition_id.present?
      composed_scope = composed_scope.where(clothing_condition_id: clothing_condition_id)
    end

    if clothing_size_ids.present?
      composed_scope = composed_scope.joins(:clothing_sizes).where('auction_clothing_sizes.clothing_size_id' => clothing_size_ids)
    end

    if clothing_type_ids.present?
      composed_scope = composed_scope.where(clothing_type_id: clothing_type_ids)
    end

    if season_ids.present?
      composed_scope = composed_scope.where(season_id: season_ids)
    end

    if search_term.present?
      q = "%#{search_term.gsub(' ', '%').downcase}%"
      composed_scope = composed_scope.joins(:brand).joins(:user).where("LOWER(brands.name) LIKE :q OR LOWER(title) LIKE :q OR LOWER(description) LIKE :q OR LOWER(users.first_name) LIKE :q OR LOWER(users.last_name) LIKE :q", :q => q)
    end

    case sort_by
    when "Price"
      # composed_scope = composed_scope.sort{|a,b| a.buy_now_price <=> b.buy_now_price}
    when "Title"
      composed_scope = composed_scope.order("title ASC")
    else
      composed_scope = composed_scope.order("ends_at ASC")
    end

    composed_scope.uniq
  end

  def to_hash(merge_in = {})
    hash = {}
    hash[:siblings_type] = siblings_type if siblings_type
    hash[:search_term] = search_term if search_term
    hash.merge!(merge_in)
    { auction_search: hash }
  end
end

class AuctionSearch
  include ActiveModel::Model

  attr_accessor :child_configuration_id, :child_genders
  attr_accessor :search_term, :siblings_type

  def initialize(params = {})
    return unless params.is_a? Hash
    params.each do |name, value|
      send("#{name}=", value)
    end
  end

  def needs_siblings_type?
    !(child_configuration_id || siblings_type)
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

  def child_configuration
    if child_configuration_id.present?
      @child_configuration = ChildConfiguration.find(child_configuration_id)
    elsif @siblings_type and @child_genders
      @child_configuration = ChildConfiguration.where(siblings_type: params[:siblings_type], genders: params[:genders]).first
    end
    @child_configuration
  end

  def auctions
    composed_scope = Auction.active
    composed_scope = composed_scope.joins(:child_configurations).where('auction_child_configurations.child_configuration_id' => possible_child_configurations)

    if search_term
      q = "%#{search_term.gsub(' ', '%').downcase}%"
      composed_scope = composed_scope.joins(:brand).joins(:user).where("LOWER(brands.name) LIKE :q OR LOWER(title) LIKE :q OR LOWER(description) LIKE :q OR LOWER(users.first_name) LIKE :q OR LOWER(users.last_name) LIKE :q", :q => q)
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

RSpec::Matchers.define :have_auction_results do |expected_auction_titles|
  match do |page|
    expected_auction_titles.each do |title|
      page.should have_css(".auction .title", :text => title)
    end
  end
end

RSpec::Matchers.define :have_no_auction_results do |unexpected_auction_titles|
  match do |page|
    unexpected_auction_titles.each do |title|
      page.should have_no_css(".auction", :text => title)
    end
  end
end

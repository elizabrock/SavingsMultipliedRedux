RSpec::Matchers.define :have_auction_results do |expected_auction_titles|
  match do |page|
    @expectedly_present = []
    expected_auction_titles.each do |title|
      result = page.all(:css, ".auction", :text => title)
      @expectedly_present << title if result.empty?
    end
    @expectedly_present.should be_empty
  end

  failure_message_for_should do |actual|
    "Auction results didn't include #{@expectedly_present}."
  end
end

RSpec::Matchers.define :have_no_auction_results do |unexpected_auction_titles|
  match do |page|
    @unexpectedly_present = []
    unexpected_auction_titles.each do |title|
      result = page.all(:css, ".auction", :text => title)
      @unexpectedly_present << title unless result.empty?
    end
    @unexpectedly_present.should be_empty
  end

  failure_message_for_should do |actual|
    "Auction results unexpectedly included #{@unexpectedly_present}."
  end
end

RSpec::Matchers.define :have_sorted_auction_results do |expected_auction_titles, options|
  expected_order = options[:order]
  match do |page|
    @expected_order = (expected_order & expected_auction_titles)
    @actual_order = page.all(:css, ".auction .title").map(&:text)
    @actual_order.should == @expected_order
  end

  failure_message_for_should do |actual|
    "Auction results should have been #{@expected_order} but were #{@actual_order}."
  end
end

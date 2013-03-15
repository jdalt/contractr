FactoryGirl.define do
  factory :client do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    sequence(:street) { |n| "12#{n} Avenue" }
    sequence(:city) { |n| "Midgard Sector #{n}" }
    sequence(:state) do |n| 
      n % 2  == 1 ? "WI" : "MN"
    end
    sequence(:phone) do |n| 
      # !! caution overflow after 8999
      local = 1000 + n
      "555-555-" + local.to_s
    end
    sequence(:zip) { |n| n + 55555 }
  end
end

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

  factory :work_category do
    name "Hydroseeding"
    price_per_unit 0.07
    unit "sq foot"
    labor_time_per_unit 30
    is_taxable true
  end
end

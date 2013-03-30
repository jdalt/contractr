FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Jimbo #{n}" }
    sequence(:email) { |n| "jimbo_#{n}@example.com" }
    sequence(:business) { |n| "Acme Packing ##{n}" }
    password "foobarbaz"
    password_confirmation "foobarbaz"
  end
    
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

  factory :work_item do
    # In the future this could be optimized to allow
    # build rather than creating work_category.
    job
    work_category
    work_amount 12500
  end

  factory :job do
    name "Jon Doe's New Lawn"
    client
    is_bid true
    is_billed false
    is_paid false
    
    factory :job_with_items do
      ignore do
        work_item_count 3
      end
      # after(:create) do |job, evaluator| 
      #   # FactoryGirl.create_list(:work_item, evaluator.work_item_count, job: job)
      #   # job.work_items.save
      # end
      after(:build) do |job, evaluator|
        job.work_items = FactoryGirl.build_list(:work_item, evaluator.work_item_count, job: job)
      end
    end
  end
end

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    sample_categories = [
      { name: "Hyrdoseeding",
        unit: "sq ft",
        price_per_unit: 0.075,
        labor_time_per_unit: 30,
        is_taxable: true
      },
      { name: "Sodding",
        unit: "yard",
        price_per_unit: 2.75,
        labor_time_per_unit: 0.5,
        is_taxable: true
      },
      { name: "Drill Seeding",
        unit: "sq ft",
        price_per_unit: 0.05,
        labor_time_per_unit: 10,
        is_taxable: true
      },
      { name: "Top Soil",
        unit: "yard",
        price_per_unit: 25,
        labor_time_per_unit: 30,
        is_taxable: false
      },
      { name: "Rock",
        unit: "yard",
        price_per_unit: 15,
        labor_time_per_unit: 10,
        is_taxable: false
      },
      { name: "Fertilize Lawn",
        unit: "10000 sq ft",
        price_per_unit: 25,
        labor_time_per_unit: 15,
        is_taxable: true
      }
    ]

    sample_categories.each do |category|
      WorkCategory.create(category)
    end
  end
end

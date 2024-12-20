FactoryBot.define do
    factory :training_log do
      association :user
      training_type { "Bench Press" }
      weight { 50 }
      reps { 10 }
      sets { 3 }
      day_of_week { "Monday" }
    end
  end
  
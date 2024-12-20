require 'rails_helper'

RSpec.describe TrainingLog, type: :model do
  describe 'バリデーション' do
    subject { build(:training_log) } # FactoryBotで:training_logファクトリが定義されている前提

    it '有効なファクトリを持つこと' do
      expect(subject).to be_valid
    end

    context '必須項目' do
      it 'training_typeが必須であること' do
        subject.training_type = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:training_type]).to include("can't be blank")
      end

      it 'weightが1以上であること' do
        subject.weight = 0
        expect(subject).not_to be_valid
        expect(subject.errors[:weight]).to include("must be greater than or equal to 1")
      end

      it 'repsが1以上であること' do
        subject.reps = 0
        expect(subject).not_to be_valid
        expect(subject.errors[:reps]).to include("must be greater than or equal to 1")
      end

      it 'setsが1以上であること' do
        subject.sets = 0
        expect(subject).not_to be_valid
        expect(subject.errors[:sets]).to include("must be greater than or equal to 1")
      end

      it 'day_of_weekが曜日いずれかであること' do
        subject.day_of_week = 'Holiday'
        expect(subject).not_to be_valid
        expect(subject.errors[:day_of_week]).to include("is not included in the list")
      end
    end
  end
end

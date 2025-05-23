require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    subject { build(:user) }

    it '有効なファクトリを持つこと' do
      expect(subject).to be_valid
    end

    context 'emailカラム' do
      it '必須であること' do
        subject.email = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to include("を入力してください")
      end

      it '正しい形式であること' do
        subject.email = 'invalid_email'
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to include("の形式が正しくありません")
      end

      it '重複メールアドレスは無効であること' do
        existing_user = create(:user, email: 'test@example.com')
        subject.email = 'test@example.com'
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to include("はすでに登録されています")
      end
    end
  end
end

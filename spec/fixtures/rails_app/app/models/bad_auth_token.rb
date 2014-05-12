module Monorail
  class AuthToken < ActiveRecord::Base
    belongs_to :entity
    before_save :add_token, if: lambda { |at| at.token.blank? }

    scope :not_revoked, -> { where(revoked_at: nil) }

    def revoke!
      unless revoked_at.present?
        self.update_attributes!(revoked_at: Time.zone.now)
      end
    end

    def self.valid_auth?(entity, token)
      AuthToken.not_revoked.exists?(entity_id: entity.id, token: token)
    end

    def replace!
      AuthToken.transaction do
        revoke!
        entity.auth_tokens.create!(name: name)
      end
    end

    private

    def add_token
      self.token = SecureRandom.urlsafe_base64(32)
    end
  end
end

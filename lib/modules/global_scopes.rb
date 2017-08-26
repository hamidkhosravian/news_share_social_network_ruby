module GlobalScopes
  def self.included(base)
    base.class_eval {
      scope :only_deleted_items, -> (last_updated_at = nil) {
        records = base.only_deleted
        if last_updated_at.present?
          records = records.where("deleted_at > ?", last_updated_at)
        end
        records
      }
    }
  end
end

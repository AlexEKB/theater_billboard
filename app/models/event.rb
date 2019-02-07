class Event < ApplicationRecord
  validates :title, :started_at, :end_at, presence: true
  validate :cannot_overlap_another_event

  def cannot_overlap_another_event
    range = Range.new started_at, end_at
    overlaps = Event.exclude_self(id).in_range(range)
    overlap_error unless overlaps.empty?
  end

  scope :in_range, -> range { where('(started_at BETWEEN ? AND ? OR end_at BETWEEN ? AND ?) OR (started_at <= ? AND end_at >= ?)',
                               range.first, range.last, range.first, range.last, range.first, range.last) }

  scope :exclude_self, -> id { where.not(id: id) }

  def overlap_error
    errors.add(:overlap_error, 'На эту дату уже запланировано событие!')
  end

end

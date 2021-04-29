module SegmentsHelper
  def waypoints_for_select(trip)
    trip.waypoints.collect { |w| [w.name, w.id] }
  end

  def segment_statuses_list
    Segment.statuses.keys.collect { |k| [k.split('_').last.humanize, k] }
  end

  def segment_status_color(segment)
    colors = {
      segment_open: 'black',
      segment_active: 'yellow',
      segment_finished: 'green'
    }
    colors[segment.status.to_sym]
  end
end

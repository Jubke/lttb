module Lttb

  # Return a downsampled version of data.
  # Parameters
  # ----------
  # data: list of lists/tuples
  #     data must be formated this way: [[x,y], [x,y], [x,y], ...]
  #                                 or: [(x,y), (x,y), (x,y), ...]
  # threshold: int
  #     threshold must be >= 2 and <= to the len of data
  # Returns
  # -------
  # data, but downsampled using threshold
  def self.largest_triangle_three_buckets(data, threshold, options = {})

    # Check if data and threshold are valid
    check_data(data)
    check_threshold(threshold)
    check_tuples(data) if options[:check_tuples]

    data = handle_dates(data) if options[:dates]

    # cache data size
    data_length = data.size

    # Nothing to do?
    return data if threshold >= data_length || threshold == 0

    # Bucket size. Leave room for start and end data points
    every = (data_length - 2).fdiv(threshold - 2)

    a = 0 # Initially a is the first point in the triangle
    next_a = 0
    max_area_point = nil
    max_area = 0
    area = 0

    sampled = []
    sampled[0] = data[a] # Always add the first point
    sampled_index = 1 # Now we start at index 1

    i = 0
    # initializing first buckets
    bucket_start = (((i + 0) * every).floor + 1).to_i
    bucket_mid = (((i + 1) * every).floor + 1).to_i

    while i < threshold - 2
      # Calculate new bucket end
      bucket_end = (((i + 2) * every).floor + 1).to_i

      # Calculate point average for next bucket (containing c)
      avg_x = 0
      avg_y = 0
      avg_range_start = bucket_mid
      avg_range_end = bucket_end < data_length ? bucket_end : data_length
      avg_range_length = avg_range_end - avg_range_start

      while avg_range_start < avg_range_end
        avg_x += data[avg_range_start][0]
        avg_y += data[avg_range_start][1]

        avg_range_start += 1 # increment
      end

      avg_x = avg_x.fdiv avg_range_length
      avg_y = avg_y.fdiv avg_range_length

      # Get the range for this bucket
      range_offs = bucket_start
      range_to = bucket_mid

      # Point a
      point_ax = data[a][0]
      point_ay = data[a][1]

      max_area = area = -1

      while range_offs < range_to
        # Calculate triangle area over three buckets
        area = (
          (point_ax - avg_x) * (data[range_offs][1] - point_ay) -
          (point_ax - data[range_offs][0]) * (avg_y - point_ay)
        ).abs * 0.5

        if area > max_area
          max_area = area
          max_area_point = data[range_offs]
          next_a = range_offs # Next a is this b
        end

        range_offs += 1 # increment
      end

      # move the bucket by one step (every)
      bucket_start = bucket_mid
      bucket_mid = bucket_end

      sampled[sampled_index] = max_area_point # Pick this point from the bucket
      sampled_index += 1
      a = next_a # This a is the next a (chosen b)
      i += 1 # increase count
    end

    sampled[sampled_index] = data[data.size - 1] # Always add last

    sampled = as_dates(sampled) if options[:dates]
    sampled
  end

  class << self

    alias process largest_triangle_three_buckets

    private

    def check_data(data)
      raise LttbException, 'data is not an array' unless data.is_a? Array
    end

    def check_threshold(threshold)
      return if threshold.is_a?(Integer) && threshold > 2
      raise LttbException, "threshold not well defined: #{threshold}"
    end

    def check_tuples(data)
      data.each do |i|
        next if i.is_a?(Array) && i.size == 2
        raise LttbException, 'datapoints are not lists or tuples'
      end
    end

    def handle_dates(data)
      data.map do |d|
        d[0] = d[0].strftime('%Q').to_i
        d
      end
    end

    def as_dates(data)
      data.map do |d|
        d[0] = DateTime.strptime(d[0].to_s, '%Q')
        d
      end
    end

  end

  class LttbException < StandardError

    def initialize(msg)
      super msg
    end

  end

end

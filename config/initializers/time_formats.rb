# custom date-time-formats for use with Time#to_s

Time::DATE_FORMATS[:date_time_no_sec] = '%Y-%m-%d %H:%M'
Time::DATE_FORMATS[:day] = '%b %d'
Time::DATE_FORMATS[:day_and_year] = '%b %d, %Y'

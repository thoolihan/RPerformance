library(data.table)

# flights in 2014 from NYC
# https://github.com/arunsrinivasan/flights/wiki/NYCflights14/flights14.csv
flights <- fread("data/flights14.csv")

# data.table automatically shows a reasonable chunk of data
flights

# data.table scopes column names in index
#  as a sql query, this would be:
#  select month, day, origin, dest from flights where carrier = "AA"
flights[carrier == "AA", .(month, day, origin, dest)]

# data.table has nice syntax for aggregations
#  select carrier, sum(distance) as miles from flights group by carrier
#  Note: I don't love the double indexing to order by an aggregation,
#   but I can't index by miles as data.table applies the row index before
#   the column index creates that new column titled miles
mbc <- flights[, .(miles = sum(distance)), by = "carrier"][order(-miles)]
setorder(mbc, -miles)
mbc

# Find flights with same endpoints and different distance
trip_variance <- flights[, .(avg_dist = mean(distance), sd_dist = sd(distance)), 
                         by = .(origin, dest)]
trip_variance[sd_dist > 0,]

# why is that?
unique(flights[origin == 'EWR' & dest == 'HNL', .(distance, carrier)])

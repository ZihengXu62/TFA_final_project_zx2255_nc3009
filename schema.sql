SELECT  Trip_Pickup_DateHour AS hour, AVG(passenger_count) AS avg_passengers
FROM taxitips
WHERE Trip_Pickup_Date >= '2009-01-06' AND Trip_Pickup_Date <= '2015-06-30'
GROUP BY  Trip_Pickup_DateHour
ORDER BY hour;
SELECT strftime('%w', pickup_datetime) as day_of_week,
       AVG(passenger_count) as avg_passenger_count
FROM ubertips
WHERE pickup_datetime >= '2009-01-06' AND pickup_datetime < '2015-07-01'
GROUP BY day_of_week;
SELECT strftime('%Y-%m', Trip_Pickup_Date) AS month,
       ROUND(0.95 * AVG(trip_distance), 2) AS distance
FROM taxitips
WHERE Trip_Pickup_Date >= '2013-07-01' AND Trip_Pickup_Date < '2013-08-01'
GROUP BY month;
SELECT Trip_Pickup_Date, COUNT(*) AS count_trips, AVG(trip_distance) AS avg_distance
FROM taxitips
WHERE Trip_Pickup_Date BETWEEN '2009-01-01' AND '2009-12-31'
GROUP BY Trip_Pickup_Date
ORDER BY count_trips DESC
LIMIT 10;
SELECT t.Trip_Pickup_Date, AVG(w.HourlyWindSpeed), COUNT(t.trip_distance) as trip_count
FROM taxitips t
JOIN daylyweather w
ON DATE(t.Trip_Pickup_Date) = w.DATE
WHERE t.Trip_Pickup_Date >= '2014-01-01' AND t.Trip_Pickup_Date < '2015-01-01'
GROUP BY t.Trip_Pickup_Date
ORDER BY AVG(w.HourlyWindSpeed) DESC
LIMIT 10;
SELECT
  strftime('%Y-%m-%d %H:00:00', wt.ndate) as DateHour,
  COUNT(ut.passenger_count) as TripsCount,
  AVG(wt.HourlyPrecipitation) as AvgPrecipitation,
  AVG(wt.HourlyWindSpeed) as AvgWindSpeed
FROM
  hourlyweather wt
LEFT JOIN
  ubertips ut
ON
  strftime('%Y-%m-%d %H:00:00', ut.pickup_datetime) = strftime('%Y-%m-%d %H:00:00', wt.ndate)
WHERE
  wt.ndate BETWEEN '2012-10-22 00:00:00' AND '2012-11-05 23:59:59'
GROUP BY
  strftime('%Y-%m-%d %H', wt.ndate)
ORDER BY
  DateHour ASC;

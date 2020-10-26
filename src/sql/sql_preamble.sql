USE gtfsfarroupilha;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS agency;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS stops;
DROP TABLE IF EXISTS stop_times;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS agency;
DROP TABLE IF EXISTS shapes;

#SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `agency` (
  agency_id int(11) PRIMARY KEY,
  agency_url VARCHAR(255),
  agency_lang VARCHAR(10),
  agency_name VARCHAR(255),
  agency_phone VARCHAR(50),
  agency_timezone VARCHAR(50),
  agency_fare_url VARCHAR(255)
);

CREATE TABLE `shapes` (
  shape_id VARCHAR(50),
  shape_pt_lat DECIMAL(9,6),
  shape_pt_lon DECIMAL(9,6),
  shape_pt_sequence INT(11),
  shape_dist_traveled DECIMAL(20,6),
  KEY `shape_id` (shape_id)
);

CREATE TABLE `routes` (
  agency_id INT(11),
  route_id INT(11) PRIMARY KEY,
  route_short_name VARCHAR(50),
  route_long_name VARCHAR(255),
  route_desc VARCHAR(255),
  route_type TINYINT,
  route_url VARCHAR(50),
  route_color VARCHAR(11),
  route_text_color VARCHAR(11),
  route_sort_order INT(11),
  min_headway_minutes INT(11),
  eligibility_restricted INT(2),
  KEY `route_type` (route_type),

  FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);

CREATE TABLE `stops` (
  stop_id INT PRIMARY KEY,
  stop_code VARCHAR(10),
  platform_code VARCHAR(10),
  stop_name VARCHAR(255),
  stop_desc VARCHAR(255),
  stop_lat DECIMAL(9,6),
  stop_lon DECIMAL(9,6),
  zone_id INT,
  stop_url VARCHAR(50),
  location_type TINYINT,
  parent_station INT,
  stop_timezone VARCHAR(20),
  position INT,       #not in the specification
  direction_id INT,   #not in the specification
  wheelchair_boarding TINYINT,
  KEY `stop_lat` (stop_lat),
  KEY `stop_lon` (stop_lon)
);


CREATE TABLE `trips` (
  route_id INT,
  service_id VARCHAR(30),
  trip_id VARCHAR(20) PRIMARY KEY,
  trip_short_name VARCHAR(50),
  trip_headsign VARCHAR(100),
  direction_id TINYINT,
  block_id INT,
  shape_id VARCHAR(20),
  bikes_allowed TINYINT,
  wheelchair_accessible TINYINT,
  trip_type INT(11),
  drt_max_travel_time INT(11),
  drt_avg_travel_time INT(11),
  drt_advance_book_min INT(11),
  drt_pickup_message INT(11),
  drt_drop_off_message INT(11),
  continuous_pickup_message VARCHAR(50),
  continuous_drop_off_message VARCHAR(50),

  KEY `route_id` (route_id),
  KEY `service_id` (service_id),
  KEY `direction_id` (direction_id),
  KEY `shape_id` (shape_id),

  FOREIGN KEY (route_id) REFERENCES routes(route_id),
  FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
  #FOREIGN KEY service_id REFERENCES calendar(service_id),
  #FOREIGN KEY service_id REFERENCES calendar_dates(service_id),

);

CREATE TABLE `stop_times` (
  trip_id VARCHAR(20) NOT NULL,
  arrival_time VARCHAR(8),    #time
  departure_time VARCHAR(8),  #time
  stop_id INT NOT NULL,
  stop_sequence INT NOT NULL,
  stop_headsign VARCHAR(20),
  pickup_type TINYINT ,
  drop_off_type TINYINT,
  shape_dist_traveled DECIMAL(15,10),
  timepoint TINYINT,
  start_service_area_id VARCHAR(11),    #these fields onwards are not in the specification
  end_service_area_id VARCHAR(11),
  start_service_area_radius VARCHAR(11),
  end_service_area_radius VARCHAR(11),
  continuous_pickup VARCHAR(11),
  continuous_drop_off VARCHAR(11),
  pickup_area_id VARCHAR(11),
  drop_off_area_id VARCHAR(11),
  pickup_service_area_radius VARCHAR(11),
  drop_off_service_area_radius VARCHAR(11),

  KEY `trip_id` (trip_id),
  KEY `stop_id` (stop_id),
  KEY `stop_sequence` (stop_sequence),

  FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
  FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);

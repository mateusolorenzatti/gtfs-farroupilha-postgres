
DROP TABLE IF EXISTS stop_times;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS stops;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS shapes;
DROP TABLE IF EXISTS agency;

CREATE TABLE agency (
  agency_id int PRIMARY KEY,
  agency_url VARCHAR(255),
  agency_lang VARCHAR(10),
  agency_name VARCHAR(255),
  agency_phone VARCHAR(50),
  agency_timezone VARCHAR(50),
  agency_fare_url VARCHAR(255)
);

-- --------------------------------------------------------

CREATE TABLE shapes (
  shape_id_serial SERIAL,
  shape_id VARCHAR(50),
  shape_pt_lat DECIMAL(9,6),
  shape_pt_lon DECIMAL(9,6),
  shape_pt_sequence INT,
  shape_dist_traveled DECIMAL(20,6),

  CONSTRAINT pk_shapes PRIMARY KEY (shape_id_serial, shape_id)
);
 
CREATE INDEX shape_id_shapes ON shapes(shape_id);

-- --------------------------------------------------------

CREATE TABLE routes (
  agency_id INT,
  route_id INTEGER PRIMARY KEY,
  route_short_name VARCHAR(50),
  route_long_name VARCHAR(255),
  route_desc VARCHAR(255),
  route_type SMALLINT,
  route_url VARCHAR(50),
  route_color VARCHAR(11),
  route_text_color VARCHAR(11),
  route_sort_order INT,
  min_headway_minutes INT,
  eligibility_restricted INT,
	
  FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);

CREATE INDEX route_type ON routes(route_type);

-- --------------------------------------------------------

CREATE TABLE stops (
  stop_id INTEGER PRIMARY KEY,
  stop_code VARCHAR(10),
  platform_code VARCHAR(10),
  stop_name VARCHAR(255),
  stop_desc VARCHAR(255),
  stop_lat DECIMAL(9,6),
  stop_lon DECIMAL(9,6),
  zone_id INT,
  stop_url VARCHAR(50),
  location_type SMALLINT,
  parent_station INT,
  stop_timezone VARCHAR(20),
  position INT,      
  direction_id INT,   
  wheelchair_boarding SMALLINT
);

CREATE INDEX stop_lat ON stops(stop_lat);
CREATE INDEX stop_lon ON stops(stop_lon);

-- --------------------------------------------------------

CREATE TABLE trips (
  route_id INT,
  service_id VARCHAR(30),
  trip_id VARCHAR(20) PRIMARY KEY,
  trip_short_name VARCHAR(50),
  trip_headsign VARCHAR(100),
  direction_id SMALLINT,
  block_id INT,
  shape_id VARCHAR(20),
  shape_id_serial INT,
  bikes_allowed SMALLINT,
  wheelchair_accessible SMALLINT,
  trip_type INT,
  drt_max_travel_time INT,
  drt_avg_travel_time INT,
  drt_advance_book_min INT,
  drt_pickup_message INT,
  drt_drop_off_message INT,
  continuous_pickup_message VARCHAR(50),
  continuous_drop_off_message VARCHAR(50),
	
  FOREIGN KEY (route_id) REFERENCES routes(route_id),
  FOREIGN KEY (shape_id_serial, shape_id) REFERENCES shapes(shape_id_serial, shape_id)
);

CREATE INDEX route_id_trips ON trips(route_id);
CREATE INDEX service_id_trips ON trips(service_id);
CREATE INDEX direction_id_trips ON trips(direction_id);
CREATE INDEX shape_id_trips ON trips(shape_id);

-- --------------------------------------------------------

CREATE TABLE stop_times (
  trip_id VARCHAR(20) NOT NULL,
  arrival_time VARCHAR(8),     
  departure_time VARCHAR(8),  
  stop_id INTEGER NOT NULL,
  stop_sequence INTEGER NOT NULL,
  stop_headsign VARCHAR(20),
  pickup_type SMALLINT ,
  drop_off_type SMALLINT,
  shape_dist_traveled DECIMAL(15,10),
  timepoint SMALLINT,
  start_service_area_id VARCHAR(11),   
  end_service_area_id VARCHAR(11),
  start_service_area_radius VARCHAR(11),
  end_service_area_radius VARCHAR(11),
  continuous_pickup VARCHAR(11),
  continuous_drop_off VARCHAR(11),
  pickup_area_id VARCHAR(11),
  drop_off_area_id VARCHAR(11),
  pickup_service_area_radius VARCHAR(11),
  drop_off_service_area_radius VARCHAR(11),

  FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
  FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);

CREATE INDEX trip_id_stop_times ON stop_times(trip_id);
CREATE INDEX stop_id_stop_times ON stop_times(stop_id);
CREATE INDEX stop_sequence_stop_times ON stop_times(stop_sequence);
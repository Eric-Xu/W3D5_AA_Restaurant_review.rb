DROP TABLE IF EXISTS chefs;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS chef_tenures;
DROP TABLE IF EXISTS critics;
DROP TABLE IF EXISTS restaurant_reviews;


CREATE TABLE chefs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  mentor_id INTEGER,
  FOREIGN KEY(mentor_id) REFERENCES chefs(id)
);

INSERT INTO chefs
	 VALUES (1, 'Gordon', 'Ramsay', 2);
INSERT INTO chefs
	 VALUES (2, 'David', 'Chang', 3);
INSERT INTO chefs
	 VALUES (3, 'Cathal', 'Armstrong', 1);	
INSERT INTO chefs
	 VALUES (4, 'Mark', 'Bittman', 1);	 
INSERT INTO chefs
   VALUES (5, 'Rachael', 'Ray', 1);  

CREATE TABLE restaurants (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(225) NOT NULL,
  neighborhood VARCHAR(255) NOT NULL,
  cuisine VARCHAR(255) NOT NULL
);

INSERT INTO restaurants
	 VALUES (1, 'Prospect', 'NYC', 'American');
INSERT INTO restaurants
   VALUES (2, 'Sechuan', 'NJ', 'Chinese');
INSERT INTO restaurants
   VALUES (3, 'Bay Wolf', 'Oakland', 'French');
INSERT INTO restaurants
   VALUES (4, 'Ninja', 'NYC', 'Japanese');

-- JOIN TABLE
CREATE TABLE chef_tenures (
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_head_chef TINYINT NOT NULL,
  chef_id INTEGER NOT NULL,
  restaurants_id INTEGER NOT NULL,
  FOREIGN KEY(chef_id) REFERENCES chefs(id),
  FOREIGN KEY(restaurants_id) REFERENCES restaurants(id)
);

INSERT INTO chef_tenures
   VALUES ('2012-1-1', '2012-12-31', 1, 1, 1);
INSERT INTO chef_tenures
   VALUES ('2012-2-1', '2012-12-31', 1, 2, 2);
INSERT INTO chef_tenures
   VALUES ('2012-3-1', '2012-12-31', 1, 3, 3);
INSERT INTO chef_tenures
   VALUES ('2012-4-1', '2012-12-31', 1, 4, 4);
INSERT INTO chef_tenures
   VALUES ('2012-5-1', '2012-12-31', 1, 5, 1);

CREATE TABLE critics (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  screen_name VARCHAR(255) NOT NULL
);

INSERT INTO critics
   VALUES (1, 'Critic1');
INSERT INTO critics
   VALUES (2, 'Critic2');
INSERT INTO critics
   VALUES (3, 'Critic3');

-- JOIN TABLE
CREATE TABLE restaurant_reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  review TEXT NOT NULL,
  score INTEGER NOT NULL,
  date TEXT NOT NULL,
  critic_id INTEGER NOT NULL,
  restaurant_id INTEGER NOT NULL,
  FOREIGN KEY(restaurant_id) REFERENCES restaurants(id),
  FOREIGN KEY(critic_id) REFERENCES critics(id)
);

INSERT INTO restaurant_reviews
   VALUES (1, "Review1", 5, '2012-1-1', 1, 1);
INSERT INTO restaurant_reviews
   VALUES (2, "Review2", 7, '2012-1-2', 2, 2);
INSERT INTO restaurant_reviews
   VALUES (3, "Review3", 9, '2012-1-3', 3, 3);
INSERT INTO restaurant_reviews
   VALUES (4, "Review4", 11, '2012-1-4', 1, 4);
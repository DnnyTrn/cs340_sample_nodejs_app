-- got_characters, got_species 
-- select all characters with column names (get request to display table)
SELECT c.id, fname, lname, h.name AS house_name, l.name AS location_name, weapon, status, organization, s.name AS species_name 
FROM got_characters c LEFT JOIN got_house h ON h.id = c.house_id 
LEFT JOIN got_locations l ON l.id = c.origin 
LEFT JOIN got_species s ON s.id = c.species_id;

-- select all charcters where fname like ? (get - search/filter)
SELECT c.id, fname, lname, h.name AS house_name, l.name AS location_name, weapon, status, organization, s.name AS species_name 
FROM got_characters c 
LEFT JOIN got_house h ON h.id = c.house_id LEFT JOIN got_locations l ON l.id = c.origin 
LEFT JOIN got_species s ON s.id = c.species_id
 WHERE c.fname LIKE ?%;
 
-- get all character IDs and names to populate the current head dropdown in location insert form
SELECT id, name FROM got_characters

-- get all characters and their cooresponding houses on the same character/house table (get request)
SELECT got_characters.id, fname, lname, got_house.name AS house_id FROM got_characters 
INNER JOIN got_house ON house_id = got_house.id

-- add a new character (post)
INSERT INTO got_characters (fname, lname, house_id, origin, weapon, species_id, status, organization) VALUES (?,?,?,?,?,?,?,?)

-- update a character's data based on submission of the Update Character form (put request)
UPDATE got_characters SET fname = ?, lname = ?, house_id = ?, origin = ?, weapon = ?, status = ?, organization = ?, species_id = ? 
WHERE id = ?;

-- delete a character with character id (delete request)
DELETE FROM got_characters WHERE id = ?

-- select all species (to fill drop down table)
SELECT id AS species_id, name AS species_name FROM got_species


-- got_house, got_house_status
--select all houses with column names (get request)
SELECT h.id AS house_id, name AS house_name, sigil, c.fname, c.lname , hs.status FROM got_house h 
LEFT JOIN got_characters c ON c.id = h.head 
LEFT JOIN got_house_status hs ON hs.id = h.status_id;

-- get all house IDs and names to populate the house dropdown in character insert form 
SELECT id, name FROM got_house

-- select all houses where house_name like ? (get search/filter)
SELECT h.id as house_id, name as house_name, sigil, c.fname, c.lname, hs.status FROM got_house h
left join got_characters c on c.id = h.head
left join got_house_status hs on hs.id = h.status_id
WHERE house_name like ?

-- add a new house (post)
INSERT INTO got_house (name, sigil, head, status_id) VALUES (?,?,?,?)

-- update a houses's data based on submission of the Update House form (put request)
UPDATE got_house SET name = ?, sigil = ?, head = ?, status_id = ? WHERE id = ?

-- delete house with house id (delete request)
DELETE FROM got_house WHERE id = ?


-- got_locations, got_continents
-- select locations with their column names (populate table for get request)
SELECT l.id, l.name AS name, region, c.name AS continent FROM got_locations l 
LEFT JOIN got_continents c ON c.id = l.continent_id;

-- select locations with column names where name like ? (search query)
SELECT l.id, l.name, region, c.name AS continent FROM got_locations l 
LEFT JOIN got_continents c ON c.id = l.continent_id 
WHERE l.name LIKE '?'%;

-- get all location_IDs and names to populate the origin dropdown in character/house/event insert form
SELECT id, name, region, continent_id FROM got_locations

-- select continent rows from got_continents (populate drop down)
SELECT id, name FROM got_continents

-- insert new location (post request)
INSERT into got_locations(name, region, continent_id) VALUES(?,?,?);

-- update a location's data based on submission of the Update Location form (put request)
UPDATE got_locations SET name = ?, region = ?, continent_id = ? WHERE id = ?;

-- delete location with location id (delete request)
DELETE FROM got_locations WHERE id = ?


-- got_events
-- select event with column names (get request)
SELECT e.id, e.name, l.name AS location, season, episode, summary FROM got_events e 
LEFT JOIN got_locations l ON l.id = e.location;

-- select all events where name like ? (get - search/filter)
SELECT e.id, e.name, l.name as location, season, episode, summary from got_events e
left join got_locations l on l.id = e.location
where e.name like ?;

--  insert into events (post request)
INSERT into got_events (name, location, season, episode, summary) VALUES (?, ?, ?, ?, ?);

-- update a event's data based on submission of the Update Event form (put request)
UPDATE got_events SET name = ?, location = ?, season = ?, episode = ?, summary = ? WHERE id = ?

-- delete event with event id (delete)
DELETE FROM got_events WHERE id = ?



-- got_event_characters
--get all events that one character is a part of (get request)
SELECT ec.id AS combined_id, e.name AS event_name, c.fname, c.lname FROM got_events_characters ec 
LEFT JOIN got_characters c ON c.id = ec.character_id 
LEFT JOIN got_events e ON e.id = ec.event_id

--associate a character with an event (post)
INSERT INTO got_events_characters (event_id, character_id) VALUES (?,?)

-- used to populate drop down and render update-eventCharacter page
SELECT id, fname, lname FROM got_characters
SELECT id as fromEvent_id, name FROM got_events
SELECT id, event_id, character_id FROM got_events_characters WHERE id = ?

-- add new event character association
INSERT INTO got_events_characters (event_id, character_id) VALUES (?,?)

-- put request to update event_character
UPDATE got_events_characters SET event_id = ?, character_id = ? WHERE id = ?

-- search function by event name
SELECT ec.id as combined_id, e.name as event_name, c.fname, c.lname FROM got_events_characters ec 
 left join got_characters c on c.id = ec.character_id 
left join got_events e on e.id = ec.event_id where e.name like ?%;

-- delete event_character by id
DELETE FROM got_events_characters WHERE id = ?
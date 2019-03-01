-- safely insert into events
INSERT into got_events (name, location, season, episode, summary)
VALUES (?, ?, ?, ?, ?);

-- select event columns with location name
select e.id, e.name, l.name as location, season, episode, summary from got_events e
left join got_locations l on l.id = e.location;

-- insert new location SAFELY
INSERT into got_locations (name, region, continent_id) 
VALUES (?,?,?)

-- select id, name from got_continents
select id, name from got_continents

-- select all locations with their column names
select l.id, l.name as name, region, c.name as continent from got_locations l
left join got_continents c on c.id = l.continent_id;

-- getHouses() - select all houses for get request
SELECT h.id as house_id, name as house_name, sigil, c.fname, c.lname , hs.status FROM got_house h
left join got_characters c on c.id = h.head
left join got_house_status hs on hs.id = h.status_id;

-- getSpecies() - select all species for get request
select id as species_id, name as species_name from got_species

-- select all characters and their rows 
SELECT c.id, fname, lname, h.name as house_name, 
l.name as location_name, weapon, status, organization, s.name as species_name FROM got_characters c
left join got_house h on h.id = c.house_id
left join got_locations l on l.id = c.origin
left join got_species s on s.id = c.species_id;

--functionality with colon : character being used to
-- denote the variables that will have data from the backend programming language

-- get all house IDs and names to populate the house dropdown in character insert form
SELECT id, name FROM got_house

-- get all location_IDs and names to populate the origin dropdown in character/house/event insert form
-- getLocations()
SELECT id, name, region, continent_id FROM got_locations

-- get all character IDs and names to populate the current head dropdown in location insert form
SELECT id, name FROM got_characters

-- get all characters and their cooresponding houses on the same character/house table
SELECT got_characters.id, fname, lname, got_house.name AS house_id FROM got_characters INNER JOIN got_house ON house_id = got_house.id

--get all events that one character is a part of
SELECT e.name, c.fname, c.lname FROM got_events_characters ec INNER JOIN got_events e ON e.id = ec.event_id INNER JOIN got_characters c ON c.id = ec.character_id

--get a single (character/house/location/event) data for the update form
SELECT id, fname, lname, house_id, origin, weapon, species_id, status, organization FROM got_characters WHERE id = 52
SELECT id, name, status, head FROM got_house WHERE id = :house_row_selected_on_website_homepage
SELECT id, name, region, continent_id FROM got_locations WHERE id = ?
select name, location, season, episode, summary from got_events where id = ?

--associate a character with an event
INSERT INTO got_events_characters (event_id, character_id) VALUES (:character_ID_from_dropdown, :event_id_from_dropdown)

-- add a new character
INSERT INTO got_characters (fname, lname, house_id, origin, weapon, species_id, status, organization) VALUES (?,?,?,?,?,?,?,?)

-- add a new house
INSERT INTO got_house (name, status, head) VALUES (:nameInput, :status_from_dropdown_Input, :head_id_from_dropdown_Input)

-- add a new location
INSERT INTO got_locations (name, region, continent) VALUES (:nameInput, :regionInput, :continent_from_dropdown_input)

-- add a new event
INSERT INTO got_events (name, location, season, episode, summary) VALUES (:nameInput, :location_id_from_dropdown_input, :seasonInput, :episodeInput, :summaryInput)

-- update a character's data based on submission of the Update Character form
UPDATE got_characters SET fname = ?, lname = ?, house_id = ?, origin = ?, weapon = ?, status = ?, organization = ?, species_id = ? 
WHERE id = ?;

-- update a houses's data based on submission of the Update House form
UPDATE got_house SET name = :nameInput, status = :status_from_dropdown_Input, head = :head_id_from_dropdown_Input WHERE id = :house_ID_from_the_update_form

-- update a location's data based on submission of the Update Location form
UPDATE got_locations SET name = ?, region = ?, continent_id = ? WHERE id = ?;

-- update a event's data based on submission of the Update Event form
UPDATE got_events SET name = ?, location = ?, season = ?, episode = ?, summary = ? WHERE id = ?

-- delete a character/house/location/event
DELETE FROM got_characters WHERE id = ?
DELETE FROM got_house WHERE id = :house_ID_selected_from_database_homepage
DELETE FROM got_locations WHERE id = :location_ID_selected_from_database_homepage
DELETE FROM got_events WHERE id = :event_ID_selected_from_database_homepage

--Dis-associate an event from a person
DELETE FROM got_events_characters WHERE character_id = :character_id_selected_from_character_and_events_list AND event_id = :events_id_selected_from_character_and_events_list


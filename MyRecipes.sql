--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 15.3

-- Started on 2024-06-11 10:56:50 EDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 234 (class 1255 OID 17024)
-- Name: addmealplanentry(numeric, numeric, numeric, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addmealplanentry(entry_id numeric, plan_id numeric, recipe_id numeric, meal_type character varying, day_of_week character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO MealPlanEntry(entry_id, plan_id, recipe_id,
						   meal_type, day_of_week)
	VALUES(entry_id, plan_id, recipe_id,
						   meal_type, day_of_week);
END;
$$;


ALTER FUNCTION public.addmealplanentry(entry_id numeric, plan_id numeric, recipe_id numeric, meal_type character varying, day_of_week character varying) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 17023)
-- Name: addnutritionfacts(numeric, numeric, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addnutritionfacts(nutrition_id numeric, recipe_id numeric, total_cal numeric, total_carb numeric, total_fat numeric, total_fiber numeric, total_protein numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO NutritionFacts(nutrition_id, recipe_id, total_cal, total_carb,
						total_fat, total_fiber, total_protein)
	VALUES(nutrition_id, recipe_id, total_cal, total_carb,
						total_fat, total_fiber, total_protein);
END;
$$;


ALTER FUNCTION public.addnutritionfacts(nutrition_id numeric, recipe_id numeric, total_cal numeric, total_carb numeric, total_fat numeric, total_fiber numeric, total_protein numeric) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 17025)
-- Name: addrecipe_ingredients(numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addrecipe_ingredients(rec_ing_id numeric, recipe_id numeric, ing_id numeric, ing_quan_id numeric, ing_measure_id numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO Recipe_ingredients(rec_ing_id, recipe_id, ing_id,
								   ing_quan_id, ing_measure_id)
	VALUES(rec_ing_id, recipe_id, ing_id,
								   ing_quan_id, ing_measure_id);
END;
$$;


ALTER FUNCTION public.addrecipe_ingredients(rec_ing_id numeric, recipe_id numeric, ing_id numeric, ing_quan_id numeric, ing_measure_id numeric) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 17001)
-- Name: addrecipes(numeric, character varying, character varying, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addrecipes(recipe_id numeric, recipe_name character varying, recipe_url character varying, recipe_serving_size numeric, recipe_prep_time numeric, recipe_cook_time numeric, user_id numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO Recipes(recipe_id, recipe_name, recipe_URL, recipe_serving_size,
						recipe_prep_time, recipe_cook_time, user_id)
	VALUES(recipe_id, recipe_name, recipe_URL, recipe_serving_size,
						recipe_prep_time, recipe_cook_time, user_id);
END;
$$;


ALTER FUNCTION public.addrecipes(recipe_id numeric, recipe_name character varying, recipe_url character varying, recipe_serving_size numeric, recipe_prep_time numeric, recipe_cook_time numeric, user_id numeric) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 16995)
-- Name: addusers(numeric, character varying, character varying, character varying, character varying, date, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addusers(user_id numeric, first_name character varying, last_name character varying, email character varying, encrypted_password character varying, created_on date, user_type character) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO Users(user_id, first_name, last_name, email, encrypted_password, created_on, user_type)
	VALUES(user_id, first_name, last_name, email, encrypted_password, created_on, user_type);
END;
$$;


ALTER FUNCTION public.addusers(user_id numeric, first_name character varying, last_name character varying, email character varying, encrypted_password character varying, created_on date, user_type character) OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 17026)
-- Name: recipe_history_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.recipe_history_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO RecipesHistory (
            recipe_id,
            old_recipe_name, new_recipe_name,
            old_recipe_URL, new_recipe_URL,
            old_recipe_serving_size, new_recipe_serving_size,
            old_recipe_prep_time, new_recipe_prep_time,
            old_recipe_cook_time, new_recipe_cook_time,
            change_date
        	) 
		VALUES (
            OLD.recipe_id,
            OLD.recipe_name, NEW.recipe_name,
            OLD.recipe_URL, NEW.recipe_URL,
            OLD.recipe_serving_size, NEW.recipe_serving_size,
            OLD.recipe_prep_time, NEW.recipe_prep_time,
            OLD.recipe_cook_time, NEW.recipe_cook_time,
            CURRENT_DATE
        	);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO RecipesHistory (
            recipe_id,
            old_recipe_name, new_recipe_name,
            old_recipe_URL, new_recipe_URL,
            old_recipe_serving_size, new_recipe_serving_size,
            old_recipe_prep_time, new_recipe_prep_time,
            old_recipe_cook_time, new_recipe_cook_time,
            change_date
        ) VALUES (
            OLD.recipe_id,
            OLD.recipe_name, NULL,
            OLD.recipe_URL, NULL,
            OLD.recipe_serving_size, NULL,
            OLD.recipe_prep_time, NULL,
            OLD.recipe_cook_time, NULL,
            CURRENT_DATE
        );
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.recipe_history_func() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 16865)
-- Name: beverage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.beverage (
    recipe_id numeric(12,0) NOT NULL
);


ALTER TABLE public.beverage OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16810)
-- Name: favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites (
    fav_id numeric(12,0) NOT NULL,
    recipe_id numeric(12,0) NOT NULL
);


ALTER TABLE public.favorites OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16855)
-- Name: food; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food (
    recipe_id numeric(12,0) NOT NULL
);


ALTER TABLE public.food OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16674)
-- Name: freeusers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.freeusers (
    user_id numeric(12,0) NOT NULL
);


ALTER TABLE public.freeusers OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16805)
-- Name: ing_measurement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ing_measurement (
    ing_measure_id numeric(12,0) NOT NULL,
    unit character varying(64) NOT NULL
);


ALTER TABLE public.ing_measurement OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16800)
-- Name: ing_quantity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ing_quantity (
    ing_quan_id numeric(12,0) NOT NULL,
    quantity numeric(12,0) NOT NULL
);


ALTER TABLE public.ing_quantity OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16795)
-- Name: ingredient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredient (
    ing_id numeric(12,0) NOT NULL,
    ing_name character varying(64) NOT NULL
);


ALTER TABLE public.ingredient OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16885)
-- Name: mealplan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mealplan (
    plan_id numeric(12,0) NOT NULL,
    user_id numeric(12,0) NOT NULL,
    week_start_date date
);


ALTER TABLE public.mealplan OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16903)
-- Name: mealplanentry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mealplanentry (
    entry_id numeric(12,0) NOT NULL,
    plan_id numeric(12,0) NOT NULL,
    recipe_id numeric(12,0) NOT NULL,
    meal_type character varying(10) NOT NULL,
    day_of_week character varying(20) NOT NULL
);


ALTER TABLE public.mealplanentry OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16918)
-- Name: mealplanentryhistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mealplanentryhistory (
    entry_id numeric(12,0) NOT NULL,
    old_recipe_id numeric(12,0) NOT NULL,
    new_recipe_id numeric(12,0) NOT NULL,
    old_meal_type character varying(10) NOT NULL,
    new_meal_type character varying(10) NOT NULL,
    old_day_of_week character varying(20) NOT NULL,
    new_day_of_week character varying(20) NOT NULL,
    change_date date NOT NULL
);


ALTER TABLE public.mealplanentryhistory OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16895)
-- Name: mealplanhistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mealplanhistory (
    plan_id numeric(12,0) NOT NULL,
    old_week_date date NOT NULL,
    new_week_date date NOT NULL,
    change_date date NOT NULL
);


ALTER TABLE public.mealplanhistory OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16820)
-- Name: nutritionfacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nutritionfacts (
    nutrition_id numeric(12,0) NOT NULL,
    recipe_id numeric(12,0) NOT NULL,
    total_cal numeric(12,2) NOT NULL,
    total_carb numeric(12,2) NOT NULL,
    total_fat numeric(12,2) NOT NULL,
    total_fiber numeric(12,2) NOT NULL,
    total_protein numeric(12,2) NOT NULL
);


ALTER TABLE public.nutritionfacts OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16684)
-- Name: paidusers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paidusers (
    user_id numeric(12,0) NOT NULL
);


ALTER TABLE public.paidusers OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16830)
-- Name: recipe_ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipe_ingredients (
    rec_ing_id numeric(12,0) NOT NULL,
    recipe_id numeric(12,0) NOT NULL,
    ing_id numeric(12,0) NOT NULL,
    ing_quan_id numeric(12,0) NOT NULL,
    ing_measure_id numeric(12,0) NOT NULL
);


ALTER TABLE public.recipe_ingredients OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16788)
-- Name: recipes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipes (
    recipe_id numeric(12,0) NOT NULL,
    recipe_name character varying(256) NOT NULL,
    recipe_url character varying(256) NOT NULL,
    recipe_serving_size numeric(5,0) NOT NULL,
    recipe_prep_time numeric(5,0) NOT NULL,
    recipe_cook_time numeric(5,0) NOT NULL,
    user_id numeric(12,0)
);


ALTER TABLE public.recipes OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17028)
-- Name: recipeshistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipeshistory (
    recipe_id numeric(12,0) NOT NULL,
    old_recipe_name character varying(256) NOT NULL,
    new_recipe_name character varying(256) NOT NULL,
    old_recipe_url character varying(256) NOT NULL,
    new_recipe_url character varying(256) NOT NULL,
    old_recipe_serving_size numeric(5,0) NOT NULL,
    new_recipe_serving_size numeric(5,0) NOT NULL,
    old_recipe_prep_time numeric(5,0) NOT NULL,
    new_recipe_prep_time numeric(5,0) NOT NULL,
    old_recipe_cook_time numeric(5,0) NOT NULL,
    new_recipe_cook_time numeric(5,0) NOT NULL,
    change_date date NOT NULL
);


ALTER TABLE public.recipeshistory OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16667)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id numeric(12,0) NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    email character varying(255) NOT NULL,
    encrypted_password character varying(255) NOT NULL,
    created_on date NOT NULL,
    user_type character(1) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 3732 (class 0 OID 16865)
-- Dependencies: 225
-- Data for Name: beverage; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3728 (class 0 OID 16810)
-- Dependencies: 221
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3731 (class 0 OID 16855)
-- Dependencies: 224
-- Data for Name: food; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3722 (class 0 OID 16674)
-- Dependencies: 215
-- Data for Name: freeusers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3727 (class 0 OID 16805)
-- Dependencies: 220
-- Data for Name: ing_measurement; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ing_measurement VALUES (21, 'count');
INSERT INTO public.ing_measurement VALUES (22, 'pinch');
INSERT INTO public.ing_measurement VALUES (23, 'pound');
INSERT INTO public.ing_measurement VALUES (24, 'cup');
INSERT INTO public.ing_measurement VALUES (25, 'tablespoon');
INSERT INTO public.ing_measurement VALUES (26, 'teaspoon');
INSERT INTO public.ing_measurement VALUES (27, 'ounce');
INSERT INTO public.ing_measurement VALUES (28, 'clove');


--
-- TOC entry 3726 (class 0 OID 16800)
-- Dependencies: 219
-- Data for Name: ing_quantity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ing_quantity VALUES (31, 1);
INSERT INTO public.ing_quantity VALUES (32, 1);
INSERT INTO public.ing_quantity VALUES (33, 2);
INSERT INTO public.ing_quantity VALUES (34, 0);
INSERT INTO public.ing_quantity VALUES (35, 4);
INSERT INTO public.ing_quantity VALUES (36, 32);


--
-- TOC entry 3725 (class 0 OID 16795)
-- Dependencies: 218
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingredient VALUES (101, 'salmon fillet');
INSERT INTO public.ingredient VALUES (102, 'red onion');
INSERT INTO public.ingredient VALUES (103, 'grapeseed oil');
INSERT INTO public.ingredient VALUES (104, 'salt');
INSERT INTO public.ingredient VALUES (105, 'black pepper');
INSERT INTO public.ingredient VALUES (106, 'romaine lettuce');
INSERT INTO public.ingredient VALUES (107, 'olives');
INSERT INTO public.ingredient VALUES (108, 'caper dressing');
INSERT INTO public.ingredient VALUES (109, 'tomato');


--
-- TOC entry 3733 (class 0 OID 16885)
-- Dependencies: 226
-- Data for Name: mealplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mealplan VALUES (100001, 1, '2023-08-07');


--
-- TOC entry 3735 (class 0 OID 16903)
-- Dependencies: 228
-- Data for Name: mealplanentry; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mealplanentry VALUES (200001, 100001, 14, 'Breakfast', 'Monday');
INSERT INTO public.mealplanentry VALUES (200002, 100001, 11, 'Lunch', 'Monday');
INSERT INTO public.mealplanentry VALUES (200003, 100001, 13, 'Dinner', 'Monday');


--
-- TOC entry 3736 (class 0 OID 16918)
-- Dependencies: 229
-- Data for Name: mealplanentryhistory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3734 (class 0 OID 16895)
-- Dependencies: 227
-- Data for Name: mealplanhistory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3729 (class 0 OID 16820)
-- Dependencies: 222
-- Data for Name: nutritionfacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.nutritionfacts VALUES (1001, 11, 480.00, 18.00, 26.00, 5.00, 26.00);
INSERT INTO public.nutritionfacts VALUES (1002, 12, 400.00, 60.00, 15.00, 6.00, 14.00);
INSERT INTO public.nutritionfacts VALUES (1003, 13, 375.00, 41.00, 18.00, 11.00, 11.00);
INSERT INTO public.nutritionfacts VALUES (1004, 14, 150.00, 25.00, 5.00, 6.00, 6.00);


--
-- TOC entry 3723 (class 0 OID 16684)
-- Dependencies: 216
-- Data for Name: paidusers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3730 (class 0 OID 16830)
-- Dependencies: 223
-- Data for Name: recipe_ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recipe_ingredients VALUES (5000, 11, 101, 35, 21);
INSERT INTO public.recipe_ingredients VALUES (5001, 11, 102, 35, 21);
INSERT INTO public.recipe_ingredients VALUES (5002, 11, 103, 33, 25);
INSERT INTO public.recipe_ingredients VALUES (5003, 11, 104, 31, 22);
INSERT INTO public.recipe_ingredients VALUES (5004, 11, 105, 31, 22);
INSERT INTO public.recipe_ingredients VALUES (5005, 11, 106, 31, 23);
INSERT INTO public.recipe_ingredients VALUES (5006, 11, 107, 36, 21);
INSERT INTO public.recipe_ingredients VALUES (5007, 11, 108, 34, 24);
INSERT INTO public.recipe_ingredients VALUES (5008, 11, 109, 32, 24);


--
-- TOC entry 3724 (class 0 OID 16788)
-- Dependencies: 217
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recipes VALUES (12, 'Wild Mushroom Soup with Soba', 'https://www.hsph.harvard.edu/nutritionsource/wild-mushroom-soup-with-soba/', 4, 10, 36, 1);
INSERT INTO public.recipes VALUES (13, 'Caesar Salad', 'https://www.hsph.harvard.edu/nutritionsource/caesar-salad/', 6, 15, 8, 1);
INSERT INTO public.recipes VALUES (14, 'Hearty Whole Grain Bread', 'https://www.hsph.harvard.edu/nutritionsource/hearty-whole-grain-bread/', 10, 20, 120, 1);
INSERT INTO public.recipes VALUES (11, 'Salmon Salad', 'https://www.hsph.harvard.edu/nutritionsource/wild-salmon-salad/', 2, 20, 15, 1);


--
-- TOC entry 3737 (class 0 OID 17028)
-- Dependencies: 230
-- Data for Name: recipeshistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recipeshistory VALUES (14, 'Hearty Whole Grain Brain', 'Hearty Whole Grain Bread', 'https://www.hsph.harvard.edu/nutritionsource/hearty-whole-grain-bread/', 'https://www.hsph.harvard.edu/nutritionsource/hearty-whole-grain-bread/', 8, 8, 20, 20, 100, 100, '2023-08-05');
INSERT INTO public.recipeshistory VALUES (14, 'Hearty Whole Grain Bread', 'Hearty Whole Grain Bread', 'https://www.hsph.harvard.edu/nutritionsource/hearty-whole-grain-bread/', 'https://www.hsph.harvard.edu/nutritionsource/hearty-whole-grain-bread/', 8, 10, 20, 20, 100, 100, '2023-08-05');
INSERT INTO public.recipeshistory VALUES (14, 'Hearty Whole Grain Bread', 'Hearty Whole Grain Bread', 'https://www.hsph.harvard.edu/nutritionsource/hearty-whole-grain-bread/', 'https://www.hsph.harvard.edu/nutritionsource/hearty-whole-grain-bread/', 10, 10, 20, 20, 100, 120, '2023-08-05');
INSERT INTO public.recipeshistory VALUES (11, 'Wild Salmon Salad', 'Salmon Salad', 'https://www.hsph.harvard.edu/nutritionsource/wild-salmon-salad/', 'https://www.hsph.harvard.edu/nutritionsource/wild-salmon-salad/', 4, 4, 20, 20, 15, 15, '2023-08-05');
INSERT INTO public.recipeshistory VALUES (11, 'Salmon Salad', 'Salmon Salad', 'https://www.hsph.harvard.edu/nutritionsource/wild-salmon-salad/', 'https://www.hsph.harvard.edu/nutritionsource/wild-salmon-salad/', 4, 2, 20, 20, 15, 15, '2023-08-05');


--
-- TOC entry 3721 (class 0 OID 16667)
-- Dependencies: 214
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Ellen', 'Burhansjah', 'eburhan@bu.edu', '1aeni2434', '2023-08-03', '1');


--
-- TOC entry 3556 (class 2606 OID 16869)
-- Name: beverage beverage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beverage
    ADD CONSTRAINT beverage_pkey PRIMARY KEY (recipe_id);


--
-- TOC entry 3548 (class 2606 OID 16814)
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (fav_id);


--
-- TOC entry 3554 (class 2606 OID 16859)
-- Name: food food_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food
    ADD CONSTRAINT food_pkey PRIMARY KEY (recipe_id);


--
-- TOC entry 3534 (class 2606 OID 16678)
-- Name: freeusers freeusers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freeusers
    ADD CONSTRAINT freeusers_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3546 (class 2606 OID 16809)
-- Name: ing_measurement ing_measurement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ing_measurement
    ADD CONSTRAINT ing_measurement_pkey PRIMARY KEY (ing_measure_id);


--
-- TOC entry 3544 (class 2606 OID 16804)
-- Name: ing_quantity ing_quantity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ing_quantity
    ADD CONSTRAINT ing_quantity_pkey PRIMARY KEY (ing_quan_id);


--
-- TOC entry 3542 (class 2606 OID 16799)
-- Name: ingredient ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_pkey PRIMARY KEY (ing_id);


--
-- TOC entry 3558 (class 2606 OID 16889)
-- Name: mealplan mealplan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mealplan
    ADD CONSTRAINT mealplan_pkey PRIMARY KEY (plan_id);


--
-- TOC entry 3560 (class 2606 OID 16907)
-- Name: mealplanentry mealplanentry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mealplanentry
    ADD CONSTRAINT mealplanentry_pkey PRIMARY KEY (entry_id);


--
-- TOC entry 3550 (class 2606 OID 16824)
-- Name: nutritionfacts nutritionfacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nutritionfacts
    ADD CONSTRAINT nutritionfacts_pkey PRIMARY KEY (nutrition_id);


--
-- TOC entry 3536 (class 2606 OID 16688)
-- Name: paidusers paidusers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paidusers
    ADD CONSTRAINT paidusers_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3552 (class 2606 OID 16834)
-- Name: recipe_ingredients recipe_ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_pkey PRIMARY KEY (rec_ing_id);


--
-- TOC entry 3539 (class 2606 OID 16794)
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (recipe_id);


--
-- TOC entry 3531 (class 2606 OID 16673)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3537 (class 1259 OID 16927)
-- Name: recipepreptimeidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recipepreptimeidx ON public.recipes USING btree (recipe_prep_time);


--
-- TOC entry 3540 (class 1259 OID 16928)
-- Name: recipeservsizeidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recipeservsizeidx ON public.recipes USING btree (recipe_serving_size);


--
-- TOC entry 3532 (class 1259 OID 16926)
-- Name: userscreatedonidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX userscreatedonidx ON public.users USING btree (created_on);


--
-- TOC entry 3578 (class 2620 OID 17027)
-- Name: recipes recipes_history_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER recipes_history_trigger AFTER DELETE OR UPDATE ON public.recipes FOR EACH ROW EXECUTE FUNCTION public.recipe_history_func();


--
-- TOC entry 3571 (class 2606 OID 16870)
-- Name: beverage beverage_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beverage
    ADD CONSTRAINT beverage_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- TOC entry 3564 (class 2606 OID 16815)
-- Name: favorites favorites_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- TOC entry 3570 (class 2606 OID 16860)
-- Name: food food_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food
    ADD CONSTRAINT food_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- TOC entry 3561 (class 2606 OID 16679)
-- Name: freeusers freeusers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.freeusers
    ADD CONSTRAINT freeusers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3572 (class 2606 OID 16890)
-- Name: mealplan mealplan_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mealplan
    ADD CONSTRAINT mealplan_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3574 (class 2606 OID 16908)
-- Name: mealplanentry mealplanentry_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mealplanentry
    ADD CONSTRAINT mealplanentry_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.mealplan(plan_id);


--
-- TOC entry 3575 (class 2606 OID 16913)
-- Name: mealplanentry mealplanentry_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mealplanentry
    ADD CONSTRAINT mealplanentry_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- TOC entry 3576 (class 2606 OID 16921)
-- Name: mealplanentryhistory mealplanentryhistory_entry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mealplanentryhistory
    ADD CONSTRAINT mealplanentryhistory_entry_id_fkey FOREIGN KEY (entry_id) REFERENCES public.mealplanentry(entry_id);


--
-- TOC entry 3573 (class 2606 OID 16898)
-- Name: mealplanhistory mealplanhistory_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mealplanhistory
    ADD CONSTRAINT mealplanhistory_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.mealplan(plan_id);


--
-- TOC entry 3565 (class 2606 OID 16825)
-- Name: nutritionfacts nutritionfacts_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nutritionfacts
    ADD CONSTRAINT nutritionfacts_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- TOC entry 3562 (class 2606 OID 16689)
-- Name: paidusers paidusers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paidusers
    ADD CONSTRAINT paidusers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3566 (class 2606 OID 16840)
-- Name: recipe_ingredients recipe_ingredients_ing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_ing_id_fkey FOREIGN KEY (ing_id) REFERENCES public.ingredient(ing_id);


--
-- TOC entry 3567 (class 2606 OID 16850)
-- Name: recipe_ingredients recipe_ingredients_ing_measure_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_ing_measure_id_fkey FOREIGN KEY (ing_measure_id) REFERENCES public.ing_measurement(ing_measure_id);


--
-- TOC entry 3568 (class 2606 OID 16845)
-- Name: recipe_ingredients recipe_ingredients_ing_quan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_ing_quan_id_fkey FOREIGN KEY (ing_quan_id) REFERENCES public.ing_quantity(ing_quan_id);


--
-- TOC entry 3569 (class 2606 OID 16835)
-- Name: recipe_ingredients recipe_ingredients_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- TOC entry 3563 (class 2606 OID 16996)
-- Name: recipes recipes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3577 (class 2606 OID 17033)
-- Name: recipeshistory recipeshistory_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipeshistory
    ADD CONSTRAINT recipeshistory_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


-- Completed on 2024-06-11 10:56:50 EDT

--
-- PostgreSQL database dump complete
--


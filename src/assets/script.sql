CREATE TABLE disc_discount_businesspartners
(
  id serial NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL,
  empresa_id integer NOT NULL,
  disc_discount_id integer NOT NULL,
  business_partner_id integer NOT NULL,
  CONSTRAINT disc_discount_bp_pkey PRIMARY KEY (id),
  CONSTRAINT disc_discount_bp_bp_fk FOREIGN KEY (business_partner_id)
      REFERENCES business_partners (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discount_bp_discount_fk FOREIGN KEY (disc_discount_id)
      REFERENCES disc_discounts (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discount_bp_empresa_fk FOREIGN KEY (empresa_id)
      REFERENCES empresas (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


CREATE TABLE product_categories
(
  id serial NOT NULL,
  name character varying(255) NOT NULL,
  empresa_id integer,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL,
  customized_fields json,
  CONSTRAINT product_categories_pkey PRIMARY KEY (id),
  CONSTRAINT product_categories_empresa_fk FOREIGN KEY (empresa_id)
      REFERENCES empresas (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE product_categories
  OWNER TO contalinkdbuser;

-- Index: index_product_categories_empresa_idx

-- DROP INDEX index_product_categories_empresa_idx;

CREATE INDEX index_product_categories_empresa_idx
  ON product_categories
  USING btree
  (empresa_id);



CREATE INDEX index_disc_bp_bp_disc
  ON disc_discount_businesspartners
  USING btree
  (business_partner_id, disc_discount_id);



CREATE TABLE disc_discount_kitproducts
(
  id serial NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL,
  empresa_id integer NOT NULL,
  disc_discount_id integer NOT NULL,
  product_id integer NOT NULL,
  quantity numeric NOT NULL,
  unitprice numeric NOT NULL,
  discountpercentage numeric DEFAULT 0,
  discounttype character varying DEFAULT 'PRICE'::character varying,
  CONSTRAINT disc_discount_kp_pkey PRIMARY KEY (id),
  CONSTRAINT disc_discount_kp_discount_fk FOREIGN KEY (disc_discount_id)
      REFERENCES disc_discounts (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discount_kp_empresa_fk FOREIGN KEY (empresa_id)
      REFERENCES empresas (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE disc_discount_kitproducts
  OWNER TO contalinkdbuser;

-- Index: index_disc_dpk_prod_disc

-- DROP INDEX index_disc_dpk_prod_disc;

CREATE INDEX index_disc_dpk_prod_disc
  ON disc_discount_kitproducts
  USING btree
  (product_id, disc_discount_id);


CREATE TABLE disc_discount_pricelists
(
  id serial NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL,
  empresa_id integer NOT NULL,
  disc_discount_id integer NOT NULL,
  pricelist_id integer NOT NULL,
  CONSTRAINT disc_discount_pl_pkey PRIMARY KEY (id),
  CONSTRAINT disc_discount_pl_discount_fk FOREIGN KEY (disc_discount_id)
      REFERENCES disc_discounts (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discount_pl_empresa_fk FOREIGN KEY (empresa_id)
      REFERENCES empresas (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discount_pl_pl_fk FOREIGN KEY (pricelist_id)
      REFERENCES pricelists (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE disc_discount_pricelists
  OWNER TO contalinkdbuser;

-- Index: index_disc_dpl_pl_disc

-- DROP INDEX index_disc_dpl_pl_disc;

CREATE INDEX index_disc_dpl_pl_disc
  ON disc_discount_pricelists
  USING btree
  (pricelist_id, disc_discount_id);



CREATE TABLE disc_discount_product_categories
(
  id serial NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL,
  empresa_id integer NOT NULL,
  disc_discount_id integer NOT NULL,
  product_category_id integer NOT NULL,
  CONSTRAINT disc_discount_pc_pkey PRIMARY KEY (id),
  CONSTRAINT disc_discount_pc_discount_fk FOREIGN KEY (disc_discount_id)
      REFERENCES disc_discounts (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discount_pc_empresa_fk FOREIGN KEY (empresa_id)
      REFERENCES empresas (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discount_pc_pc_fk FOREIGN KEY (product_category_id)
      REFERENCES product_categories (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE disc_discount_product_categories
  OWNER TO contalinkdbuser;

-- Index: index_disc_pc_cat_disc

-- DROP INDEX index_disc_pc_cat_disc;

CREATE INDEX index_disc_pc_cat_disc
  ON disc_discount_product_categories
  USING btree
  (product_category_id, disc_discount_id);


CREATE TABLE disc_discount_products
(
  id serial NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL,
  empresa_id integer NOT NULL,
  disc_discount_id integer NOT NULL,
  product_id integer NOT NULL,
  CONSTRAINT disc_discount_p_pkey PRIMARY KEY (id),
  CONSTRAINT disc_discount_p_discount_fk FOREIGN KEY (disc_discount_id)
      REFERENCES disc_discounts (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discount_p_empresa_fk FOREIGN KEY (empresa_id)
      REFERENCES empresas (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discount_p_pr_fk FOREIGN KEY (product_id)
      REFERENCES productos (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE disc_discount_products
  OWNER TO contalinkdbuser;

-- Index: index_disc_dp_prod_disc

-- DROP INDEX index_disc_dp_prod_disc;

CREATE INDEX index_disc_dp_prod_disc
  ON disc_discount_products
  USING btree
  (product_id, disc_discount_id);


CREATE TABLE disc_discount_rules
(
  id serial NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL,
  name character varying NOT NULL,
  procedure character varying NOT NULL,
  field_definition json,
  CONSTRAINT disc_discount_rules_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);


CREATE TABLE disc_discounts
(
  id serial NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL,
  empresa_id integer NOT NULL,
  disc_discount_rule_id integer NOT NULL,
  validfrom date NOT NULL,
  validto date NOT NULL,
  name character varying NOT NULL,
  print_name character varying NOT NULL,
  productcategory_rule character varying NOT NULL,
  product_rule character varying NOT NULL,
  pricelist_rule character varying NOT NULL,
  businesspartner_rule character varying NOT NULL,
  customized_fields json,
  priority integer DEFAULT 0,
  apply_when_discount_exists boolean DEFAULT true,
  active boolean DEFAULT true,
  discount_type character varying NOT NULL,
  CONSTRAINT disc_discounts_pkey PRIMARY KEY (id),
  CONSTRAINT disc_discounts_dr_fk FOREIGN KEY (disc_discount_rule_id)
      REFERENCES disc_discount_rules (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT disc_discounts_empresa_fk FOREIGN KEY (empresa_id)
      REFERENCES empresas (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE disc_discounts
  OWNER TO contalinkdbuser;

-- Index: index_disc_discounts_for_validation

-- DROP INDEX index_disc_discounts_for_validation;

CREATE INDEX index_disc_discounts_for_validation
  ON disc_discounts
  USING btree
  (empresa_id, validfrom, validto, active);


CREATE TABLE disc_point_cards
(
  id serial NOT NULL,
  card_number character varying(255) NOT NULL,
  empresa_id integer,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL,
  customized_fields json,
  CONSTRAINT disc_point_cards_pkey PRIMARY KEY (id),
  CONSTRAINT disc_point_cards_empresa_fk FOREIGN KEY (empresa_id)
      REFERENCES empresas (id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE disc_point_cards
  OWNER TO contalinkdbuser;

-- Index: card_number_empresa_card_idx

-- DROP INDEX card_number_empresa_card_idx;

CREATE UNIQUE INDEX card_number_empresa_card_idx
  ON disc_point_cards
  USING btree
  (empresa_id, card_number COLLATE pg_catalog."default");




CREATE OR REPLACE FUNCTION disc_is_apply_discount(
    p_order json,
    p_discount integer)
  RETURNS boolean AS
$BODY$
DECLARE 

v_count INTEGER;
CUR_DISCOUNT RECORD;

BEGIN

	SELECT * INTO CUR_DISCOUNT FROM disc_discounts WHERE id = p_discount;

	SELECT COUNT(*) FROM disc_discount_pricelists INTO v_count WHERE disc_discount_id = p_discount and pricelist_id = (p_order->>'pricelist_id')::integer;
	IF ((CUR_DISCOUNT.pricelist_rule = 'I' AND v_count = 0) OR (CUR_DISCOUNT.pricelist_rule = 'NI' AND v_count > 0)) THEN
		RETURN FALSE;
	END IF;

	SELECT COUNT(*) FROM disc_discount_businesspartners INTO v_count WHERE disc_discount_id = p_discount and business_partner_id = (p_order->>'businesspartner_id')::integer;
	IF ((CUR_DISCOUNT.businesspartner_rule = 'I' AND v_count = 0) OR (CUR_DISCOUNT.businesspartner_rule = 'NI' AND v_count > 0)) THEN
		RETURN FALSE;
	END IF;
	
	RETURN TRUE;
	
END ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;




CREATE OR REPLACE FUNCTION disc_is_apply_discount_lines(
    p_line json,
    p_discount integer)
  RETURNS boolean AS
$BODY$
DECLARE 

v_count INTEGER;
CUR_DISCOUNT RECORD;

BEGIN

	SELECT * INTO CUR_DISCOUNT FROM disc_discounts WHERE id = p_discount;

	SELECT COUNT(*) FROM disc_discount_products INTO v_count WHERE disc_discount_id = p_discount and product_id = (p_line->>'product_id')::integer;
	IF ((CUR_DISCOUNT.product_rule = 'I' AND v_count = 0) OR (CUR_DISCOUNT.product_rule = 'NI' AND v_count > 0)) THEN
		RETURN FALSE;
	END IF;

	SELECT COUNT(*) FROM disc_discount_product_categories INTO v_count WHERE disc_discount_id = p_discount and product_category_id = (SELECT product_category_id FROM productos WHERE id = (p_line->>'product_id')::integer);
	IF ((CUR_DISCOUNT.productcategory_rule = 'I' AND v_count = 0) OR (CUR_DISCOUNT.productcategory_rule = 'NI' AND v_count > 0)) THEN
		RETURN FALSE;
	END IF;
	
	RETURN TRUE;
	
END ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


CREATE OR REPLACE FUNCTION disc_search_card_id(p_request json)
  RETURNS json AS
$BODY$
DECLARE 

v_jsonReturn JSON;
v_cardID NUMERIC;

BEGIN

	select id INTO v_cardID FROM disc_point_cards where empresa_id = (p_request->>'empresa_id')::integer and card_number = p_request->>'card_number';
	v_jsonReturn = json_build_object('disc_point_card_id', COALESCE(v_cardID,0));
	
	RETURN v_jsonReturn;
	
END ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



CREATE OR REPLACE FUNCTION disc_util_add_discount_to_line(
    p_line json,
    p_apply_when_discount_exists boolean,
    p_discount_id integer,
    p_discountname character varying,
    p_baseamount numeric,
    p_discountamount numeric,
    p_discount_type character varying)
  RETURNS json AS
$BODY$
DECLARE 

v_oldDiscount JSON;
v_newDiscount JSON;
v_discountList JSON ARRAY;
v_totalDiscount NUMERIC;

BEGIN

	v_totalDiscount = 0;
	IF (p_discountamount > 0) THEN
		IF (p_discount_type = 'P') THEN
			FOR v_oldDiscount IN SELECT * FROM json_array_elements(p_line->'discounts')
			LOOP
				v_discountList = array_append(v_discountList, v_oldDiscount);
				v_totalDiscount = v_totalDiscount + (v_oldDiscount->>'discount')::numeric;
			END LOOP;
	
			IF (v_totalDiscount = 0 OR p_apply_when_discount_exists IS TRUE) THEN
				v_newDiscount = json_build_object('p_discount_id', p_discount_id, 'discountname', p_discountname, 'baseprice', p_baseamount, 'discount', p_discountamount, 'percentage', ROUND((p_discountamount / p_baseamount) * 100,6));
				v_totalDiscount = COALESCE(v_totalDiscount,0) + p_discountamount;
				v_discountList = array_append(v_discountList, v_newDiscount);
				p_line = util_json_object_set_key(p_line, 'totaldiscount', v_totalDiscount);
				p_line = util_json_object_set_key(p_line, 'discounts', array_to_json(v_discountList));
			END IF;
		END IF;

		IF (p_discount_type = 'PC') THEN
			FOR v_oldDiscount IN SELECT * FROM json_array_elements(p_line->'points')
			LOOP
				v_discountList = array_append(v_discountList, v_oldDiscount);
				v_totalDiscount = v_totalDiscount + (v_oldDiscount->>'discount')::numeric;
			END LOOP;
	
			IF (v_totalDiscount = 0 OR p_apply_when_discount_exists IS TRUE) THEN
				v_newDiscount = json_build_object('p_discount_id', p_discount_id, 'discountname', p_discountname, 'baseprice', p_baseamount, 'discount', p_discountamount, 'percentage', ROUND((p_discountamount / p_baseamount) * 100,6));
				v_totalDiscount = COALESCE(v_totalDiscount,0) + p_discountamount;
				v_discountList = array_append(v_discountList, v_newDiscount);
				p_line = util_json_object_set_key(p_line, 'totalpoints', v_totalDiscount);
				p_line = util_json_object_set_key(p_line, 'points', array_to_json(v_discountList));
			END IF;
		END IF;
		
	END IF;
		
	RETURN p_line ;
	
END ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


CREATE OR REPLACE FUNCTION disc_dr_kit(
    p_order json,
    p_discount json)
  RETURNS json AS
$BODY$
DECLARE 

v_order_line JSON;
v_updated_line JSON;
v_order_line_list JSON ARRAY;
v_discountId INTEGER;
v_minKits INTEGER;
v_kitquantity NUMERIC;
v_product INTEGER;
v_kitMult INTEGER;

v_baseAmount NUMERIC;
v_discountAmount NUMERIC;
v_quantity NUMERIC;

v_totalPrice NUMERIC;
v_priceUnits NUMERIC;
v_discountPercentage NUMERIC;
v_discountedPriceUnit NUMERIC;
v_discountableUnits NUMERIC;
v_nonDiscountableUnits NUMERIC;
v_discountablesPrice NUMERIC;
v_nonDiscountablesPrice NUMERIC;
v_kitprice NUMERIC;
v_kitDiscPctg NUMERIC;
v_kitDiscountType VARCHAR;

BEGIN

	v_discountId = (p_discount->>'id')::integer;
	v_minKits = 0;
	
	-- Gets the minimum number of kits that can be applied to the order.
	FOR v_order_line IN SELECT * FROM json_array_elements(p_order->'lines')
	LOOP
		v_kitquantity = NULL;
		v_quantity = (v_order_line->>'quantity')::numeric;
		v_product = (v_order_line->>'product_id')::integer;

		SELECT quantity INTO v_kitquantity FROM disc_discount_kitproducts WHERE product_id = v_product AND disc_discount_id = v_discountId;

		IF (v_kitquantity IS NULL) THEN
			CONTINUE;
		END IF;

		v_kitMult = TRUNC(v_quantity / v_kitquantity,0);

		IF (v_kitMult = 0) THEN
			v_minKits = 0;
			EXIT;
		END IF;

		IF (v_minKits = 0 OR v_kitMult < v_minKits) THEN
			v_minKits = v_kitMult;
		END IF;
	END LOOP;

	-- Applies the prices on the kits.
	
	IF (v_minKits > 0) THEN

		FOR v_order_line IN SELECT * FROM json_array_elements(p_order->'lines')
		LOOP
			v_kitquantity = NULL;
			v_quantity = (v_order_line->>'quantity')::numeric;
			v_product = (v_order_line->>'product_id')::integer;

			SELECT quantity, unitprice, discountpercentage, discounttype INTO v_kitquantity, v_kitprice, v_kitDiscPctg, v_kitDiscountType FROM disc_discount_kitproducts WHERE product_id = v_product AND disc_discount_id = v_discountId;

			IF (v_kitquantity IS NULL) THEN
				v_order_line_list = array_append(v_order_line_list, v_order_line);
				CONTINUE;
			END IF;

			v_baseAmount = (v_order_line->>'price')::numeric - COALESCE((v_order_line->>'totaldiscount')::numeric, 0) - COALESCE((v_order_line->>'totalpoints')::numeric, 0);

			v_priceUnits = v_baseAmount / v_quantity;
			
			IF (v_kitDiscountType = 'PRICE') THEN
				v_discountPercentage = (1 - (v_kitprice / v_baseAmount));
			END IF;
			IF (v_kitDiscountType = 'PERCENTAGE') THEN
				v_discountPercentage = v_kitDiscPctg / 100;
			END IF;
			
			v_discountedPriceUnit = v_priceUnits * (1-COALESCE(v_discountPercentage,0));
			v_discountableUnits = v_minKits * v_kitquantity;
			v_nonDiscountableUnits = v_quantity - v_discountableUnits;
			v_discountablesPrice = v_discountedPriceUnit * v_discountableUnits;
			v_nonDiscountablesPrice = v_nonDiscountableUnits * v_priceUnits;
			v_totalPrice = v_discountablesPrice + v_nonDiscountablesPrice;
			v_discountAmount = ROUND(v_baseAmount - v_totalPrice, 6);

			v_updated_line = disc_util_add_discount_to_line(v_order_line, (p_discount->>'apply_when_discount_exists')::boolean, (p_discount->>'id')::integer, p_discount->>'print_name', v_baseAmount, v_discountAmount, p_discount->>'discount_type');
			v_order_line_list = array_append(v_order_line_list, v_updated_line);
		END LOOP;
		
		p_order = util_json_object_set_key(p_order, 'lines', array_to_json(v_order_line_list));
		RETURN p_order;
		
	ELSE
		RETURN p_order;
	END IF;
	
END ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


CREATE OR REPLACE FUNCTION disc_dr_buy_x_pay_y(
    p_order json,
    p_discount json)
  RETURNS json AS
$BODY$
DECLARE 

v_order_line JSON;
v_updated_line JSON;
v_order_line_list JSON ARRAY;
v_baseAmount NUMERIC;
v_percentage NUMERIC;
v_discountAmount NUMERIC;
v_buy NUMERIC;
v_pay NUMERIC;
v_quantity NUMERIC;
v_priceUnits NUMERIC;
v_discountedPriceUnit NUMERIC;
v_appliedPromotions NUMERIC;
v_discountableUnits NUMERIC;
v_nonDiscountableUnits NUMERIC;
v_discountablesPrice NUMERIC;
v_nonDiscountablesPrice NUMERIC;
v_totalPrice NUMERIC;

BEGIN

	
	FOR v_order_line IN SELECT * FROM json_array_elements(p_order->'lines')
	LOOP
	
		v_baseAmount = (v_order_line->>'price')::numeric - COALESCE((v_order_line->>'totaldiscount')::numeric, 0) - COALESCE((v_order_line->>'totalpoints')::numeric, 0);
		v_buy = COALESCE((p_discount->'customized_fields'->>'buy')::numeric, 1);
		v_pay = COALESCE((p_discount->'customized_fields'->>'pay')::numeric, 1);
		v_quantity = (v_order_line->>'quantity')::numeric;
		v_priceUnits = v_baseAmount / v_quantity;
		v_discountedPriceUnit = v_priceUnits * v_pay / v_buy;
		v_appliedPromotions = TRUNC(v_quantity / v_buy, 0);
		v_discountableUnits = v_appliedPromotions * v_buy;
		v_nonDiscountableUnits = v_quantity - v_discountableUnits;
		v_discountablesPrice = v_discountedPriceUnit * v_discountableUnits;
		v_nonDiscountablesPrice = v_nonDiscountableUnits * v_priceUnits;
		v_totalPrice = v_discountablesPrice + v_nonDiscountablesPrice;
		v_discountAmount = ROUND(v_baseAmount - v_totalPrice, 6);

		v_updated_line = disc_util_add_discount_to_line(v_order_line, (p_discount->>'apply_when_discount_exists')::boolean, (p_discount->>'id')::integer, p_discount->>'print_name', v_baseAmount, v_discountAmount, p_discount->>'discount_type');
		v_order_line_list = array_append(v_order_line_list, v_updated_line);
		
	END LOOP;

	p_order = util_json_object_set_key(p_order, 'lines', array_to_json(v_order_line_list));

	RETURN p_order;
	
END ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



CREATE OR REPLACE FUNCTION disc_dr_basic_percentage(
    p_order json,
    p_discount json)
  RETURNS json AS
$BODY$
DECLARE 

v_order_line JSON;
v_updated_line JSON;
v_order_line_list JSON ARRAY;
v_baseAmount NUMERIC;
v_percentage NUMERIC;
v_discountAmount NUMERIC;
v_minqty NUMERIC;
v_maxqty NUMERIC;
v_quantity NUMERIC;
v_isApplyDiscount BOOLEAN;

BEGIN

	v_minqty = COALESCE((p_discount->'customized_fields'->>'min_qty')::numeric,0);
	v_maxqty = COALESCE((p_discount->'customized_fields'->>'max_qty')::numeric,0);
	v_maxqty = CASE WHEN v_maxqty = 0 THEN 99999999999 ELSE v_maxqty END;
	
	FOR v_order_line IN SELECT * FROM json_array_elements(p_order->'lines')
	LOOP
		v_isApplyDiscount = disc_is_apply_discount_lines(v_order_line, (p_discount->>'id')::integer);
		IF (v_isApplyDiscount) THEN
			v_quantity = (v_order_line->>'quantity')::numeric;
			
			IF (v_quantity BETWEEN v_minqty AND v_maxqty) THEN
				v_baseAmount = (v_order_line->>'price')::numeric - COALESCE((v_order_line->>'totaldiscount')::numeric, 0) - COALESCE((v_order_line->>'totalpoints')::numeric, 0);
				v_percentage = COALESCE((p_discount->'customized_fields'->>'percentage')::numeric,0);
				v_discountAmount = ROUND(v_baseAmount * (v_percentage / 100),6);
				
				v_updated_line = disc_util_add_discount_to_line(v_order_line, (p_discount->>'apply_when_discount_exists')::boolean, (p_discount->>'id')::integer, p_discount->>'print_name', v_baseAmount, v_discountAmount, p_discount->>'discount_type');
				v_order_line_list = array_append(v_order_line_list, v_updated_line);
			ELSE
				v_order_line_list = array_append(v_order_line_list, v_order_line);
			END IF;
		ELSE
			v_order_line_list = array_append(v_order_line_list, v_order_line);
		END IF;
	END LOOP;

	p_order = util_json_object_set_key(p_order, 'lines', array_to_json(v_order_line_list));

	RETURN p_order;
	
END ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



CREATE OR REPLACE FUNCTION disc_calculate_point_card_balance(p_request json)
  RETURNS json AS
$BODY$
DECLARE 

v_jsonReturn JSON;
v_balance NUMERIC;

BEGIN

	select COALESCE(ROUND(sum(COALESCE(deposito,0) - COALESCE(retiro, 0))::numeric,2),0) INTO v_balance FROM status_accounts where disc_point_card_id = (p_request->>'disc_point_card_id')::integer;
	v_jsonReturn = json_build_object('balance', v_balance);
	
	RETURN v_jsonReturn;
	
END ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


CREATE OR REPLACE FUNCTION disc_calculate_discounts(p_order json)
  RETURNS json AS
$BODY$
DECLARE 

CUR_DISCOUNTS RECORD;
v_empresaId INTEGER;
v_procedure VARCHAR;
v_sql VARCHAR;
v_discount JSON;
v_applyDiscount BOOLEAN;

BEGIN

	SELECT empresa_id INTO v_empresaId FROM pos_configuration WHERE id = (p_order->'header'->>'pos_configuration_id')::integer;
	FOR CUR_DISCOUNTS IN (SELECT * FROM disc_discounts WHERE DATE(p_order->'header'->>'orderdate') BETWEEN validfrom and validto and empresa_id = v_empresaId  AND active is TRUE ORDER BY discount_type, priority, id)
	LOOP
		v_discount = row_to_json(CUR_DISCOUNTS);
		v_applyDiscount = disc_is_apply_discount(p_order->'header', CUR_DISCOUNTS.id);
		IF (v_applyDiscount IS TRUE) THEN
			SELECT procedure into v_procedure FROM disc_discount_rules WHERE id = CUR_DISCOUNTS.disc_discount_rule_id;
			v_sql = 'SELECT ' || v_procedure || '(''' || p_order || ''', ''' || v_discount || ''')';
			EXECUTE v_sql INTO p_order;
		END IF;
		
	END LOOP;
	
	RETURN p_order;
	
END ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



INSERT INTO disc_discount_rules(created_at, updated_at, name, procedure, field_definition)
VALUES (now(), now(), 'Kit', 'disc_dr_kit', NULL)

INSERT INTO disc_discount_rules(created_at, updated_at, name, procedure, field_definition)
VALUES (now(), now(), 'Buy X and pay for Y', 'disc_dr_buy_x_pay_y', '[{"fieldname":"buy", "datatype":"integer", "label":"Compras"}, {"fieldname":"pay", "datatype":"integer", "label":"Pagas"}]')

INSERT INTO disc_discount_rules(created_at, updated_at, name, procedure, field_definition)
VALUES (now(), now(), 'Basic Percentage Discount', 'disc_dr_basic_percentage', '[{"fieldname": "percentage", "datatype":"integer", "label":"porcentaje"}, {"fieldname": "min_qty", "datatype":"integer", "label":"Cantidad minima"}, {"fieldname": "max_qty", "datatype":"integer", "label":"Cantidad maxima"}]')


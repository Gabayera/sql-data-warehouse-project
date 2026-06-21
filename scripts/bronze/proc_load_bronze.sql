CREATE OR REPLACE PROCEDURE bronze.load_bronze()
    LANGUAGE plpgsql
AS
$$
DECLARE
    start_time       TIMESTAMP;
    end_time         TIMESTAMP;
    batch_start_time TIMESTAMP;
    batch_end_time   TIMESTAMP;
    load_seconds     NUMERIC;
BEGIN
    batch_start_time := clock_timestamp();

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '================================================';

    -------------------------------------------------------
    -- CRM Tables
    -------------------------------------------------------
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading CRM Tables';
    RAISE NOTICE '------------------------------------------------';

    -- 1. crm_cust_info
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    RAISE NOTICE '>> Inserting Data Into: bronze.crm_cust_info';
    COPY bronze.crm_cust_info
        FROM 'D:/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
        WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    load_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
    RAISE NOTICE '>> Load Duration: % seconds', load_seconds::TEXT;
    RAISE NOTICE '>> -------------';

    -- 2. crm_prd_info
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
    RAISE NOTICE '>> Inserting Data Into: bronze.crm_prd_info';
    COPY bronze.crm_prd_info
        FROM 'D:/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
        WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    load_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
    RAISE NOTICE '>> Load Duration: % seconds', load_seconds::TEXT;
    RAISE NOTICE '>> -------------';

    -- 3. crm_sales_details
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
    RAISE NOTICE '>> Inserting Data Into: bronze.crm_sales_details';
    COPY bronze.crm_sales_details
        FROM 'D:/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
        WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    load_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
    RAISE NOTICE '>> Load Duration: % seconds', load_seconds::TEXT;
    RAISE NOTICE '>> -------------';

    -------------------------------------------------------
    -- ERP Tables
    -------------------------------------------------------
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading ERP Tables';
    RAISE NOTICE '------------------------------------------------';

    -- 4. erp_loc_a101
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;
    RAISE NOTICE '>> Inserting Data Into: bronze.erp_loc_a101';
    COPY bronze.erp_loc_a101
        FROM 'D:/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
        WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    load_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
    RAISE NOTICE '>> Load Duration: % seconds', load_seconds::TEXT;
    RAISE NOTICE '>> -------------';

    -- 5. erp_cust_az12
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
    RAISE NOTICE '>> Inserting Data Into: bronze.erp_cust_az12';
    COPY bronze.erp_cust_az12
        FROM 'D:/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
        WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    load_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
    RAISE NOTICE '>> Load Duration: % seconds', load_seconds::TEXT;
    RAISE NOTICE '>> -------------';

    -- 6. erp_px_cat_g1v2
    start_time := clock_timestamp();
    RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    RAISE NOTICE '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
    COPY bronze.erp_px_cat_g1v2
        FROM 'D:/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
        WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    load_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
    RAISE NOTICE '>> Load Duration: % seconds', load_seconds::TEXT;
    RAISE NOTICE '>> -------------';

    -- Batch summary
    batch_end_time := clock_timestamp();
    RAISE NOTICE '==========================================';
    RAISE NOTICE 'Loading Bronze Layer is Completed';
    RAISE NOTICE '   - Total Load Duration: % seconds',
        EXTRACT(EPOCH FROM (batch_end_time - batch_start_time))::TEXT;
    RAISE NOTICE '==========================================';

EXCEPTION
    WHEN OTHERS THEN
        -- Detailed error information
        RAISE NOTICE '==========================================';
        RAISE NOTICE 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        RAISE NOTICE 'Error Message: %', SQLERRM;
        RAISE NOTICE 'SQLSTATE: %', SQLSTATE;
        RAISE NOTICE '==========================================';
        RAISE; -- re-raise the original error to stop execution
END;
$$;

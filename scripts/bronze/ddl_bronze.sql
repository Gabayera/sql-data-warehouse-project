drop table if exists bronze.crm_cust_info;
create table bronze.crm_cust_info
(
    cst_id              INT,
    cst_key             VARCHAR(250),
    cst_firsname        VARCHAR(250),
    cst_lastname        VARCHAR(250),
    cst_material_status VARCHAR(250),
    cst_gndr            VARCHAR(250),
    cst_create_date     DATE
);

drop table if exists bronze.crm_prd_info;
create table bronze.crm_prd_info
(
    prd_id       int,
    prd_key      varchar(250),
    prd_nm       varchar(250),
    prd_cost     decimal,
    prd_line     varchar(250),
    prd_start_dt date,
    prd_end_dt   date
);

drop table if exists bronze.crm_sales_details;
create table bronze.crm_sales_details
(
    sls_ord_num  varchar(250),
    sls_prd_key  varchar(250),
    sls_cust_id  int,
    sls_order_dt int,
    sls_ship_dt  int,
    sls_due_dt   int,
    sls_sales    decimal,
    sls_quantity int,
    sls_price    decimal
);


drop table if exists bronze.erp_cust_az12;
create table bronze.erp_CUST_AZ12
(
    CID   varchar(250),
    BDATE date,
    GEN   varchar(250)
);

drop table if exists bronze.erp_loc_a101;
create table bronze.erp_LOC_A101
(
    CID   varchar(250),
    CNTRY varchar(250)
);


drop table if exists bronze.erp_px_cat_g1v2;
create table bronze.erp_PX_CAT_G1V2
(
    ID          varchar(250),
    CAT         varchar(250),
    SUBCAT      varchar(250),
    MAINTENANCE varchar(250)
);










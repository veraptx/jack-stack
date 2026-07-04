ALTER SESSION SET CONTAINER = FREEPDB1;

BEGIN
    ords_admin.enable_schema(
        p_enabled              => TRUE,
        p_schema                => 'APPUSER',
        p_url_mapping_type      => 'BASE_PATH',
        p_url_mapping_pattern    => 'appuser',
        p_auto_rest_auth         => TRUE
    );
    COMMIT;
END;
/
variable "db_parameters" {
  description = "(Optional) A list of DB parameters to apply. UTF8, ASIA/SEOUL, Timeout 60s, apply_method=pending-reboot"
  type        = map

  default = {
    back_log                            = 100
    binlog_checksum                     = "NONE"
    binlog_format                       = "ROW"
    binlog_row_image                    = "minimal"
    bulk_insert_buffer_size             = 33554432 # 32MB (32*1024*1024)
    character_set_client                = "utf8"
    character_set_connection            = "utf8"
    character_set_database              = "utf8"
    character_set_filesystem            = "utf8"
    character_set_results               = "utf8"
    character_set_server                = "utf8"
    collation_connection                = "utf8_general_ci"
    collation_server                    = "utf8_general_ci"
    connect_timeout                     = 60
    event_scheduler                     = "OFF"
    general_log                         = "0"
    innodb_buffer_pool_dump_at_shutdown = "1"
    innodb_buffer_pool_load_at_startup  = "1"
    innodb_buffer_pool_size             = "{DBInstanceClassMemory*2/3}"
    innodb_file_format                  = "Barracuda"
    innodb_file_per_table               = "1"
    innodb_flush_log_at_trx_commit      = "1"
    innodb_flush_method                 = "O_DIRECT"
    innodb_io_capacity                  = "1000"
    innodb_io_capacity_max              = "2000"
    innodb_lock_wait_timeout            = "60"
    innodb_max_dirty_pages_pct          = "30"
    innodb_read_io_threads              = "8"
    innodb_rollback_on_timeout          = "1"
    innodb_write_io_threads             = "8"
    interactive_timeout                 = "60"
    lock_wait_timeout                   = "60"
    log_bin_trust_function_creators     = "1"
    log_output                          = "TABLE"
    log_queries_not_using_indexes       = "1"
    long_query_time                     = "1"
    max_allowed_packet                  = "536870912" # 512MB (512 * 1048576)
    max_connect_errors                  = "999999"
    net_read_timeout                    = "60"
    net_write_timeout                   = "60"
    performance_schema                  = "1"
    time_zone                           = "Asia/Seoul"
    tx_isolation                        = "REPEATABLE-READ"
    wait_timeout                        = 60
  }
}

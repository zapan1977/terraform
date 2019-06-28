variable "regions" {
  type = string
}

variable "family" {
  description = "(Required) The family of the DB parameter group."
  type        = string
  default     = "mysql5.6"
}

variable "mysql56_db_parameters" {
  description = "(Optional) A list of DB parameters to apply. Note that parameters may differ from a family to an other. Full list of all parameters can be discovered via aws rds describe-db-parameters after initial creation of the group."
  type        = map(string)

  default = {
    back_log                            = 100 # 클라이언트가 MySQL 서버에 인증을 거칠때까지 몇 개까지의 커넥션을 대기 큐에 맏아 둘지 설정.
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
    event_scheduler                     = "OFF" # Default: On. Cron과 비슷하게 일정 시간에 반복되는 작업(주로 프로시저 실행)을 실행.
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
    innodb_lock_wait_timeout            = "60"       # innodb 레코드 잠금에 대한 대기 타임 아웃
    innodb_log_file_size                = 1073741824 # 1GB (1 * 1024 * 1024 * 1024) InnoDB 리두 로그 파일 크기.
    innodb_max_dirty_pages_pct          = "30"
    innodb_read_io_threads              = "8"
    innodb_rollback_on_timeout          = "1"
    innodb_write_io_threads             = "8"
    interactive_timeout                 = "60"
    lock_wait_timeout                   = "60" # Meta Data 잠금에 대한 time out
    log_bin_trust_function_creators     = "1"
    log_output                          = "FILE" # FILE 형태로 권고. TABLE 형태로 남길 경우 Database size 문제가 발생할 수 있다.
    log_queries_not_using_indexes       = "1"
    log_slow_admin_statements           = "1" # DDL 문장의 슬로우 쿼리 로그 기록 여부 설정. 활성화해서 DDL이 오래 걸리면서 발생하는 문제를 확인할 수 있다.
    long_query_time                     = "1"
    max_allowed_packet                  = "536870912" # 512MB (512 * 1048576) MySQL 클라이언드가 서버로 요청하는 경우에만 해당한다. 그러나 Backup, 배치 처리 등에 영향을 받기에 높게 잡고 사용.
    max_connect_errors                  = "999999"
    # max_connections는 Default 설정 값으로 충분하지만, 중요한 값이라 설명 추가.
    # Application 의 Connection Pool 설정 값 * 배포 서버 대수 * 2 로 설정.
    # AWS 위에서 커넥션 풀과 배포 서버 대수의 2배수로 잡는 이유는 Blue/Green 배포나 Auto-scaling 에 따른 Connection 증가로 인한 장애 대비를 위해서.
    # max_connections = "{DBInstanceClassMemory/12582880}" # Default: AWS RDS MySQL, MariaDB, Aurora MySQL은 인스턴스 메모리를 기준으로 계산
    net_read_timeout   = "60"
    net_write_timeout  = "60"
    performance_schema = "1"
    time_zone          = "Asia/Seoul"
    tx_isolation       = "REPEATABLE-READ"
    wait_timeout       = 60 # Default: engine-default MySQL 서버에 연결된 클라이언트가 아무런 요청 없이 대기하는 할 수 있는 시간(초) 기본 28800초(8시간)
    # 주요한 메모리 버퍼 커넥션(세션)별로 설정이 되기 때문에 RDS에서는 OOM 발생의 주요 원인.
    # AWS 파라미터 설명에는 증가시켜주면 성능 향상이 된다고 하지만 2MB 이상은 설정은 성능 향상보다 OOM 발생에 주요 원인.
    # 128KB ~ 512KB가 적당한 설정 값. 512 이상 설정을 할 경우 innodb_buffer_pool_size 를 줄여 주는 것이 좋음.
    # Percona blog 에서는 2MB까지 설정해서 성능이 향상된 벤치마킹 결과도 있다. 대부분의 서비스에서는 적절한 설정은 아닙니다.
    sort_buffer_size     = 131072 # 128 * 1024 정렬에 인덱스를 사용할 수 없는 경우에 정렬 대상 데이터 저장.
    join_buffer_size     = 131072 # 128 * 1024 적절한 조인 조건이 없이 드리븐 테이블의 검색이 풀 테이블 스캔으로 유도 되는 경우에 사용.
    read_buffer_size     = 131072 # 128 * 1024 풀 테이블 스캔에 사용. 많이 늘려도 풀 테이블 스캔 성능이 향상되는 것은 아닌 것으로 보임.
    read_rnd_buffer_size = 131072 # 128 * 1024 Tow-pass 알고리즘 정렬에 사용하는 버퍼.
  }
}

variable "tags" {
  type = map(string)
  default = {
    Terraform     = "true"
    Workload-type = "others" # production, test
  }
}

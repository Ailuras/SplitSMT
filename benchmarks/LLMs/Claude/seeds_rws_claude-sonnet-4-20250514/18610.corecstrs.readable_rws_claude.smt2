(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :category "industrial")

; Declare string variables for configuration parsing
(declare-fun config_line () String)
(declare-fun ini_section () String)
(declare-fun multi_line_config () String)
(declare-fun key_part () String)
(declare-fun value_part () String)
(declare-fun section_name () String)
(declare-fun database_config () String)
(declare-fun server_settings () String)

; Configuration line parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= key_part (str.split_at config_line "=" 0)))
(assert (= value_part (str.split_at config_line "=" 1)))
(assert (= (str.num_splits config_line "=") 2))

; Key validation - must be non-empty and contain only valid characters
(assert (> (str.len key_part) 0))
(assert (not (str.contains key_part " ")))
(assert (str.prefixof "database" key_part))

; ; Value extraction and validation
(assert (= value_part "localhost"))
(assert (> (str.len value_part) 0))

; INI section handling with brackets
(assert (= ini_section "[database]"))
(assert (= (str.split_at ini_section "[" 0) ""))
(assert (= (str.split_at (str.split_at ini_section "[" 1) "]" 0) "database"))
(assert (= section_name (str.split_at (str.split_at ini_section "[" 1) "]" 0)))

; Multi-line configuration parsing
(assert (= multi_line_config "host=127.0.0.1\nport=5432\nuser=admin"))
(assert (= (str.num_splits multi_line_config "\n") 3))

; ; Extract first configuration pair
(assert (= (str.split_at multi_line_config "\n" 0) "host=127.0.0.1"))
(assert (= (str.split_at multi_line_config "\n" 1) "port=5432"))
(assert (= (str.split_at multi_line_config "\n" 2) "user=admin"))

; Parse individual key-value pairs from multi-line config
(declare-fun host_line () String)
(declare-fun port_line () String)
(declare-fun user_line () String)
(declare-fun host_key () String)
(declare-fun host_value () String)
(declare-fun port_key () String)
(declare-fun port_value () String)

(assert (= host_line (str.split_at multi_line_config "\n" 0)))
(assert (= port_line (str.split_at multi_line_config "\n" 1)))
(assert (= user_line (str.split_at multi_line_config "\n" 2)))

; Parse host configuration
(assert (= host_key (str.split_at host_line "=" 0)))
(assert (= host_value (str.split_at host_line "=" 1)))
(assert (= host_key "host"))
(assert (= host_value "127.0.0.1"))

; Parse port configuration
(assert (= port_key (str.split_at port_line "=" 0)))
(assert (= port_value (str.split_at port_line "=" 1)))
(assert (= port_key "port"))
(assert (= port_value "5432"))

; Alternative delimiter handling with colon
(assert (= database_config "timeout:30"))
(assert (= (str.split_at database_config ":" 0) "timeout"))
(assert (= (str.split_at database_config ":" 1) "30"))
(assert (= (str.num_splits database_config ":") 2))

; Complex INI file section with multiple entries
(assert (= server_settings "[server]\naddress=0.0.0.0\nssl=true"))
(assert (= (str.split_at server_settings "\n" 0) "[server]"))

; ; Extract section header and validate
(declare-fun server_header () String)
(declare-fun server_section_name () String)
(assert (= server_header (str.split_at server_settings "\n" 0)))
(assert (= server_section_name (str.split_at (str.split_at server_header "[" 1) "]" 0)))
(assert (= server_section_name "server"))

; Parse server configuration entries
(declare-fun address_line () String)
(declare-fun ssl_line () String)
(assert (= address_line (str.split_at server_settings "\n" 1)))
(assert (= ssl_line (str.split_at server_settings "\n" 2)))

; ; Validate address configuration
(declare-fun address_key () String)
(declare-fun address_value () String)
(assert (= address_key (str.split_at address_line "=" 0)))
(assert (= address_value (str.split_at address_line "=" 1)))
(assert (= address_key "address"))
(assert (= address_value "0.0.0.0"))

; ; Validate SSL configuration
(declare-fun ssl_key () String)
(declare-fun ssl_value () String)
(assert (= ssl_key (str.split_at ssl_line "=" 0)))
(assert (= ssl_value (str.split_at ssl_line "=" 1)))
(assert (= ssl_key "ssl"))
(assert (= ssl_value "true"))

; Key validation constraints
(assert (not (str.contains address_key " ")))
(assert (not (str.contains ssl_key " ")))
(assert (not (str.contains host_key " ")))
(assert (not (str.contains port_key " ")))

; Value validation constraints
(assert (> (str.len address_value) 0))
(assert (> (str.len ssl_value) 0))
(assert (> (str.len host_value) 0))
(assert (> (str.len port_value) 0))

; Section name validation
(assert (> (str.len section_name) 0))
(assert (> (str.len server_section_name) 0))
(assert (not (str.contains section_name "[")))
(assert (not (str.contains section_name "]")))
(assert (not (str.contains server_section_name "[")))
(assert (not (str.contains server_section_name "]")))

; ; Test remaining content extraction
(declare-fun remaining_config () String)
(assert (= remaining_config (str.split_rest server_settings "\n" 1)))
(assert (str.contains remaining_config "address=0.0.0.0"))
(assert (str.contains remaining_config "ssl=true"))

; Constraint that should make the system unsatisfiable
; Uncomment the next line to test unsatisfiability
; (assert (= section_name "invalid_section"))

(check-sat)
(exit)
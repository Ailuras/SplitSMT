(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2062 0)
(declare-sort var3169 0)
(declare-sort var2375 0)
(declare-sort var1777 0)
(declare-sort var2227 0)
(declare-sort var1063 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3169-init () var3169)
(declare-fun <init>/-201242697 (var3169) void)
(declare-fun var2375_isEmpty/-813097145 (String) Bool)
(declare-fun var1063_info/484404803 (var1063 String) void)
(declare-fun cast-from-var1777-to-var1063 (var1777) var1063)
(declare-const null-String String)
(declare-const var2227-logger var1777)
(declare-const var1513 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1513 null-String)))
(define-const var543 var3169 var3169-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var543)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var543!1 var3169)
(define-const var823 Bool (var2375_isEmpty/-813097145 var1513)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = new java.util.Properties 
(assert (not (= (ite var823 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var767 var1777 var2227-logger) ; Statement: $r6 = <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var1063_info/484404803 (cast-from-var1777-to-var1063 var767) "Config center was specified, but no config item found.")) ; Statement: interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>("Config center was specified, but no config item found.") 

(declare-const var767!1 var1777)
(declare-const var1757 String)
 ; Statement: goto [?= return $r0] 
(assert true) ; Non Conditional
 ; Statement: return $r0 
(check-sat)
; {var3169-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var2375_isEmpty/-813097145=([java.lang.String], boolean), var1063_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var1777-to-var1063=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var1513=r1, var2062=null_type, var3169=java.util.HashMap, var543=$r0, var2375=org.apache.dubbo.common.utils.StringUtils, var823=$z0, var1777=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2227=org.apache.dubbo.common.config.ConfigurationUtils, var767=$r6, var1063=org.apache.dubbo.common.logger.Logger, var1757="Config center was specified, but no config item found."}
; {r1=var1513, null_type=var2062, java.util.HashMap=var3169, $r0=var543, org.apache.dubbo.common.utils.StringUtils=var2375, $z0=var823, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1777, org.apache.dubbo.common.config.ConfigurationUtils=var2227, $r6=var767, org.apache.dubbo.common.logger.Logger=var1063, "Config center was specified, but no config item found."=var1757}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = new java.util.Properties;	$r6 = <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>("Config center was specified, but no config item found.");	goto [?= return $r0];	return $r0
;block_num 3
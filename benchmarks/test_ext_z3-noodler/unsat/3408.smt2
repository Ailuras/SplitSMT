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

(declare-sort var1707 0)
(declare-sort var2215 0)
(declare-sort var675 0)
(declare-sort var315 0)
(declare-sort var1462 0)
(declare-sort var2776 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1707-init () var1707)
(declare-fun <init>/-2175807 (var1707) void)
(declare-fun cast-from-var1707-to-var2215 (var1707) var2215)
(declare-fun var675_getSystemProperty/590859155 (String String) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun var315-init () var315)
(declare-fun <init>/-1682312399 (var315) void)
(declare-fun var1462_setLoggerAdapter/-730232915 (var2776) void)
(declare-fun cast-from-var315-to-var2776 (var315) var2776)
(define-const var250 var1707 var1707-init) ; Statement: $r0 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var250)) ; Statement: specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var250!1 var1707)
(define-const var2255 var2215 (cast-from-var1707-to-var2215 var250!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0 
(define-const var600 var1707 var1707-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var600)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var600!1 var1707)
(define-const var3839 var2215 (cast-from-var1707-to-var2215 var600!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1 
(define-const var261 String (var675_getSystemProperty/590859155 "dubbo.application.logger" "")) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "") 
(define-const var285 Int -1) ; Statement: b1 = -1 
(assert true)
(define-const var3564 Int (hashCode/-467973558 var261)) ; Statement: $i0 = virtualinvoke r2.<java.lang.String: int hashCode()>() 
 ; Statement: lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; } 
(assert (and (not (= var3564 109522083)) (and (not (= var3564 103147770)) (and (not (= var3564 105073)) (and (not (= var3564 105043)) (and (not (= var3564 -1097386376)) true)))))) ; Intersect: Negate: Cond: $i0 == 109522083   and Intersect: Negate: Cond: $i0 == 103147770   and Intersect: Negate: Cond: $i0 == 105073   and Intersect: Negate: Cond: $i0 == 105043   and Intersect: Negate: Cond: $i0 == -1097386376   and Non Conditional     
 ; Statement: tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; } 
(assert (and (= var285 0) true)) ; Intersect: Cond: b1 == 0  and Non Conditional 
(define-const var2305 var315 var315-init) ; Statement: $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter 
(assert true)
;(assert (<init>/-1682312399 var2305)) ; Statement: specialinvoke $r7.<org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter: void <init>()>() 

(declare-const var2305!1 var315)
;(assert (var1462_setLoggerAdapter/-730232915 (cast-from-var315-to-var2776 var2305!1))) ; Statement: staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r7) 

(declare-const var2305!2 var315)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var1707-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var1707-to-var2215=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), var675_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), hashCode/-467973558=([java.lang.String], int), var315-init=([], org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter), <init>/-1682312399=([org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter], void), var1462_setLoggerAdapter/-730232915=([org.apache.dubbo.common.logger.LoggerAdapter], void), cast-from-var315-to-var2776=([org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter], org.apache.dubbo.common.logger.LoggerAdapter)}
; {var1707=java.util.concurrent.ConcurrentHashMap, var250=$r0, var2215=java.util.concurrent.ConcurrentMap, var2255=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>, var600=$r1, var3839=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>, var675=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var261=r2, var285=b1, var3564=$i0, var315=org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter, var2305=$r7, var1462=org.apache.dubbo.common.logger.LoggerFactory, var2776=org.apache.dubbo.common.logger.LoggerAdapter}
; {java.util.concurrent.ConcurrentHashMap=var1707, $r0=var250, java.util.concurrent.ConcurrentMap=var2215, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>=var2255, $r1=var600, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>=var3839, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var675, r2=var261, b1=var285, $i0=var3564, org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter=var315, $r7=var2305, org.apache.dubbo.common.logger.LoggerFactory=var1462, org.apache.dubbo.common.logger.LoggerAdapter=var2776}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts $r0 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0;	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1;	r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "");	b1 = -1;	$i0 = virtualinvoke r2.<java.lang.String: int hashCode()>();	lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; };	tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; };	$r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;	specialinvoke $r7.<org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter: void <init>()>();	staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r7);	goto [?= return];	return
;block_num 4
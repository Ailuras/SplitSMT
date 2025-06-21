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

(declare-sort var1026 0)
(declare-sort var2709 0)
(declare-sort var2047 0)
(declare-sort var2380 0)
(declare-sort var3001 0)
(declare-sort var3219 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1026-init () var1026)
(declare-fun <init>/-2175807 (var1026) void)
(declare-fun cast-from-var1026-to-var2709 (var1026) var2709)
(declare-fun var2047_getSystemProperty/590859155 (String String) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun var2380-init () var2380)
(declare-fun <init>/-1583027621 (var2380) void)
(declare-fun var3001_setLoggerAdapter/-730232915 (var3219) void)
(declare-fun cast-from-var2380-to-var3219 (var2380) var3219)
(define-const var728 var1026 var1026-init) ; Statement: $r0 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var728)) ; Statement: specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var728!1 var1026)
(define-const var3642 var2709 (cast-from-var1026-to-var2709 var728!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0 
(define-const var1848 var1026 var1026-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1848)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1848!1 var1026)
(define-const var2080 var2709 (cast-from-var1026-to-var2709 var1848!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1 
(define-const var719 String (var2047_getSystemProperty/590859155 "dubbo.application.logger" "")) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "") 
(define-const var2681 Int -1) ; Statement: b1 = -1 
(assert true)
(define-const var1582 Int (hashCode/-467973558 var719)) ; Statement: $i0 = virtualinvoke r2.<java.lang.String: int hashCode()>() 
 ; Statement: lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; } 
(assert (and (not (= var1582 109522083)) (and (not (= var1582 103147770)) (and (not (= var1582 105073)) (and (not (= var1582 105043)) (and (not (= var1582 -1097386376)) true)))))) ; Intersect: Negate: Cond: $i0 == 109522083   and Intersect: Negate: Cond: $i0 == 103147770   and Intersect: Negate: Cond: $i0 == 105073   and Intersect: Negate: Cond: $i0 == 105043   and Intersect: Negate: Cond: $i0 == -1097386376   and Non Conditional     
 ; Statement: tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; } 
(assert (and (= var2681 4) (and (not (= var2681 3)) (and (not (= var2681 2)) (and (not (= var2681 1)) (and (not (= var2681 0)) true)))))) ; Intersect: Cond: b1 == 4  and Intersect: Negate: Cond: b1 == 3   and Intersect: Negate: Cond: b1 == 2   and Intersect: Negate: Cond: b1 == 1   and Intersect: Negate: Cond: b1 == 0   and Non Conditional     
(define-const var494 var2380 var2380-init) ; Statement: $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter 
(assert true)
;(assert (<init>/-1583027621 var494)) ; Statement: specialinvoke $r3.<org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter: void <init>()>() 

(declare-const var494!1 var2380)
;(assert (var3001_setLoggerAdapter/-730232915 (cast-from-var2380-to-var3219 var494!1))) ; Statement: staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r3) 

(declare-const var494!2 var2380)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var1026-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var1026-to-var2709=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), var2047_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), hashCode/-467973558=([java.lang.String], int), var2380-init=([], org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter), <init>/-1583027621=([org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter], void), var3001_setLoggerAdapter/-730232915=([org.apache.dubbo.common.logger.LoggerAdapter], void), cast-from-var2380-to-var3219=([org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter], org.apache.dubbo.common.logger.LoggerAdapter)}
; {var1026=java.util.concurrent.ConcurrentHashMap, var728=$r0, var2709=java.util.concurrent.ConcurrentMap, var3642=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>, var1848=$r1, var2080=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>, var2047=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var719=r2, var2681=b1, var1582=$i0, var2380=org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter, var494=$r3, var3001=org.apache.dubbo.common.logger.LoggerFactory, var3219=org.apache.dubbo.common.logger.LoggerAdapter}
; {java.util.concurrent.ConcurrentHashMap=var1026, $r0=var728, java.util.concurrent.ConcurrentMap=var2709, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>=var3642, $r1=var1848, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>=var2080, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2047, r2=var719, b1=var2681, $i0=var1582, org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter=var2380, $r3=var494, org.apache.dubbo.common.logger.LoggerFactory=var3001, org.apache.dubbo.common.logger.LoggerAdapter=var3219}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts $r0 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0;	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1;	r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "");	b1 = -1;	$i0 = virtualinvoke r2.<java.lang.String: int hashCode()>();	lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; };	tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; };	$r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;	specialinvoke $r3.<org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter: void <init>()>();	staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r3);	goto [?= return];	return
;block_num 4
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

(declare-sort var2083 0)
(declare-sort var2047 0)
(declare-sort var2657 0)
(declare-sort var18 0)
(declare-sort var3948 0)
(declare-sort var71 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2083-init () var2083)
(declare-fun <init>/-2175807 (var2083) void)
(declare-fun cast-from-var2083-to-var2047 (var2083) var2047)
(declare-fun var2657_getSystemProperty/590859155 (String String) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun var18-init () var18)
(declare-fun <init>/1089475925 (var18) void)
(declare-fun var3948_setLoggerAdapter/-730232915 (var71) void)
(declare-fun cast-from-var18-to-var71 (var18) var71)
(define-const var2787 var2083 var2083-init) ; Statement: $r0 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var2787)) ; Statement: specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var2787!1 var2083)
(define-const var468 var2047 (cast-from-var2083-to-var2047 var2787!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0 
(define-const var1224 var2083 var2083-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1224)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1224!1 var2083)
(define-const var3928 var2047 (cast-from-var2083-to-var2047 var1224!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1 
(define-const var1718 String (var2657_getSystemProperty/590859155 "dubbo.application.logger" "")) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "") 
(define-const var2721 Int -1) ; Statement: b1 = -1 
(assert true)
(define-const var2206 Int (hashCode/-467973558 var1718)) ; Statement: $i0 = virtualinvoke r2.<java.lang.String: int hashCode()>() 
 ; Statement: lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; } 
(assert (and (not (= var2206 109522083)) (and (not (= var2206 103147770)) (and (not (= var2206 105073)) (and (not (= var2206 105043)) (and (not (= var2206 -1097386376)) true)))))) ; Intersect: Negate: Cond: $i0 == 109522083   and Intersect: Negate: Cond: $i0 == 103147770   and Intersect: Negate: Cond: $i0 == 105073   and Intersect: Negate: Cond: $i0 == 105043   and Intersect: Negate: Cond: $i0 == -1097386376   and Non Conditional     
 ; Statement: tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; } 
(assert (and (= var2721 3) (and (not (= var2721 2)) (and (not (= var2721 1)) (and (not (= var2721 0)) true))))) ; Intersect: Cond: b1 == 3  and Intersect: Negate: Cond: b1 == 2   and Intersect: Negate: Cond: b1 == 1   and Intersect: Negate: Cond: b1 == 0   and Non Conditional    
(define-const var991 var18 var18-init) ; Statement: $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter 
(assert true)
;(assert (<init>/1089475925 var991)) ; Statement: specialinvoke $r4.<org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter: void <init>()>() 

(declare-const var991!1 var18)
;(assert (var3948_setLoggerAdapter/-730232915 (cast-from-var18-to-var71 var991!1))) ; Statement: staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r4) 

(declare-const var991!2 var18)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var2083-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var2083-to-var2047=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), var2657_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), hashCode/-467973558=([java.lang.String], int), var18-init=([], org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter), <init>/1089475925=([org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter], void), var3948_setLoggerAdapter/-730232915=([org.apache.dubbo.common.logger.LoggerAdapter], void), cast-from-var18-to-var71=([org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter], org.apache.dubbo.common.logger.LoggerAdapter)}
; {var2083=java.util.concurrent.ConcurrentHashMap, var2787=$r0, var2047=java.util.concurrent.ConcurrentMap, var468=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>, var1224=$r1, var3928=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>, var2657=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var1718=r2, var2721=b1, var2206=$i0, var18=org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter, var991=$r4, var3948=org.apache.dubbo.common.logger.LoggerFactory, var71=org.apache.dubbo.common.logger.LoggerAdapter}
; {java.util.concurrent.ConcurrentHashMap=var2083, $r0=var2787, java.util.concurrent.ConcurrentMap=var2047, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>=var468, $r1=var1224, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>=var3928, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2657, r2=var1718, b1=var2721, $i0=var2206, org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter=var18, $r4=var991, org.apache.dubbo.common.logger.LoggerFactory=var3948, org.apache.dubbo.common.logger.LoggerAdapter=var71}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts $r0 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0;	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1;	r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "");	b1 = -1;	$i0 = virtualinvoke r2.<java.lang.String: int hashCode()>();	lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; };	tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; };	$r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;	specialinvoke $r4.<org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter: void <init>()>();	staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r4);	goto [?= return];	return
;block_num 4
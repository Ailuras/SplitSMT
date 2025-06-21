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

(declare-sort var2675 0)
(declare-sort var3768 0)
(declare-sort var1269 0)
(declare-sort var2137 0)
(declare-sort var1703 0)
(declare-sort var8 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2675-init () var2675)
(declare-fun <init>/-2175807 (var2675) void)
(declare-fun cast-from-var2675-to-var3768 (var2675) var3768)
(declare-fun var1269_getSystemProperty/590859155 (String String) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun var2137-init () var2137)
(declare-fun <init>/1276573315 (var2137) void)
(declare-fun var1703_setLoggerAdapter/-730232915 (var8) void)
(declare-fun cast-from-var2137-to-var8 (var2137) var8)
(define-const var3433 var2675 var2675-init) ; Statement: $r0 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var3433)) ; Statement: specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var3433!1 var2675)
(define-const var702 var3768 (cast-from-var2675-to-var3768 var3433!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0 
(define-const var3710 var2675 var2675-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var3710)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var3710!1 var2675)
(define-const var1206 var3768 (cast-from-var2675-to-var3768 var3710!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1 
(define-const var2645 String (var1269_getSystemProperty/590859155 "dubbo.application.logger" "")) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "") 
(define-const var2722 Int -1) ; Statement: b1 = -1 
(assert true)
(define-const var1560 Int (hashCode/-467973558 var2645)) ; Statement: $i0 = virtualinvoke r2.<java.lang.String: int hashCode()>() 
 ; Statement: lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; } 
(assert (and (not (= var1560 109522083)) (and (not (= var1560 103147770)) (and (not (= var1560 105073)) (and (not (= var1560 105043)) (and (not (= var1560 -1097386376)) true)))))) ; Intersect: Negate: Cond: $i0 == 109522083   and Intersect: Negate: Cond: $i0 == 103147770   and Intersect: Negate: Cond: $i0 == 105073   and Intersect: Negate: Cond: $i0 == 105043   and Intersect: Negate: Cond: $i0 == -1097386376   and Non Conditional     
 ; Statement: tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; } 
(assert (and (= var2722 2) (and (not (= var2722 1)) (and (not (= var2722 0)) true)))) ; Intersect: Cond: b1 == 2  and Intersect: Negate: Cond: b1 == 1   and Intersect: Negate: Cond: b1 == 0   and Non Conditional   
(define-const var3510 var2137 var2137-init) ; Statement: $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter 
(assert true)
;(assert (<init>/1276573315 var3510)) ; Statement: specialinvoke $r5.<org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter: void <init>()>() 

(declare-const var3510!1 var2137)
;(assert (var1703_setLoggerAdapter/-730232915 (cast-from-var2137-to-var8 var3510!1))) ; Statement: staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r5) 

(declare-const var3510!2 var2137)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var2675-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var2675-to-var3768=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), var1269_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), hashCode/-467973558=([java.lang.String], int), var2137-init=([], org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter), <init>/1276573315=([org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter], void), var1703_setLoggerAdapter/-730232915=([org.apache.dubbo.common.logger.LoggerAdapter], void), cast-from-var2137-to-var8=([org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter], org.apache.dubbo.common.logger.LoggerAdapter)}
; {var2675=java.util.concurrent.ConcurrentHashMap, var3433=$r0, var3768=java.util.concurrent.ConcurrentMap, var702=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>, var3710=$r1, var1206=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>, var1269=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2645=r2, var2722=b1, var1560=$i0, var2137=org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter, var3510=$r5, var1703=org.apache.dubbo.common.logger.LoggerFactory, var8=org.apache.dubbo.common.logger.LoggerAdapter}
; {java.util.concurrent.ConcurrentHashMap=var2675, $r0=var3433, java.util.concurrent.ConcurrentMap=var3768, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>=var702, $r1=var3710, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>=var1206, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var1269, r2=var2645, b1=var2722, $i0=var1560, org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter=var2137, $r5=var3510, org.apache.dubbo.common.logger.LoggerFactory=var1703, org.apache.dubbo.common.logger.LoggerAdapter=var8}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts $r0 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0;	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1;	r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "");	b1 = -1;	$i0 = virtualinvoke r2.<java.lang.String: int hashCode()>();	lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; };	tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; };	$r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;	specialinvoke $r5.<org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter: void <init>()>();	staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r5);	goto [?= return];	return
;block_num 4
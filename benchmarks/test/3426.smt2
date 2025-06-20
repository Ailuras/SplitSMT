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

(declare-sort var1360 0)
(declare-sort var3035 0)
(declare-sort var3329 0)
(declare-sort var2439 0)
(declare-sort var2613 0)
(declare-sort var1663 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1360-init () var1360)
(declare-fun <init>/-2175807 (var1360) void)
(declare-fun cast-from-var1360-to-var3035 (var1360) var3035)
(declare-fun var3329_getSystemProperty/590859155 (String String) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun var2439-init () var2439)
(declare-fun <init>/50003217 (var2439) void)
(declare-fun var2613_setLoggerAdapter/-730232915 (var1663) void)
(declare-fun cast-from-var2439-to-var1663 (var2439) var1663)
(define-const var2972 var1360 var1360-init) ; Statement: $r0 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var2972)) ; Statement: specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var2972!1 var1360)
(define-const var2732 var3035 (cast-from-var1360-to-var3035 var2972!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0 
(define-const var949 var1360 var1360-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var949)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var949!1 var1360)
(define-const var292 var3035 (cast-from-var1360-to-var3035 var949!1)) ; Statement: <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1 
(define-const var368 String (var3329_getSystemProperty/590859155 "dubbo.application.logger" "")) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "") 
(define-const var1857 Int -1) ; Statement: b1 = -1 
(assert true)
(define-const var206 Int (hashCode/-467973558 var368)) ; Statement: $i0 = virtualinvoke r2.<java.lang.String: int hashCode()>() 
 ; Statement: lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; } 
(assert (and (not (= var206 109522083)) (and (not (= var206 103147770)) (and (not (= var206 105073)) (and (not (= var206 105043)) (and (not (= var206 -1097386376)) true)))))) ; Intersect: Negate: Cond: $i0 == 109522083   and Intersect: Negate: Cond: $i0 == 103147770   and Intersect: Negate: Cond: $i0 == 105073   and Intersect: Negate: Cond: $i0 == 105043   and Intersect: Negate: Cond: $i0 == -1097386376   and Non Conditional     
 ; Statement: tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; } 
(assert (and (= var1857 1) (and (not (= var1857 0)) true))) ; Intersect: Cond: b1 == 1  and Intersect: Negate: Cond: b1 == 0   and Non Conditional  
(define-const var339 var2439 var2439-init) ; Statement: $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter 
(assert true)
;(assert (<init>/50003217 var339)) ; Statement: specialinvoke $r6.<org.apache.dubbo.common.logger.jcl.JclLoggerAdapter: void <init>()>() 

(declare-const var339!1 var2439)
;(assert (var2613_setLoggerAdapter/-730232915 (cast-from-var2439-to-var1663 var339!1))) ; Statement: staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r6) 

(declare-const var339!2 var2439)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var1360-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var1360-to-var3035=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), var3329_getSystemProperty/590859155=([java.lang.String, java.lang.String], java.lang.String), hashCode/-467973558=([java.lang.String], int), var2439-init=([], org.apache.dubbo.common.logger.jcl.JclLoggerAdapter), <init>/50003217=([org.apache.dubbo.common.logger.jcl.JclLoggerAdapter], void), var2613_setLoggerAdapter/-730232915=([org.apache.dubbo.common.logger.LoggerAdapter], void), cast-from-var2439-to-var1663=([org.apache.dubbo.common.logger.jcl.JclLoggerAdapter], org.apache.dubbo.common.logger.LoggerAdapter)}
; {var1360=java.util.concurrent.ConcurrentHashMap, var2972=$r0, var3035=java.util.concurrent.ConcurrentMap, var2732=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>, var949=$r1, var292=<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>, var3329=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var368=r2, var1857=b1, var206=$i0, var2439=org.apache.dubbo.common.logger.jcl.JclLoggerAdapter, var339=$r6, var2613=org.apache.dubbo.common.logger.LoggerFactory, var1663=org.apache.dubbo.common.logger.LoggerAdapter}
; {java.util.concurrent.ConcurrentHashMap=var1360, $r0=var2972, java.util.concurrent.ConcurrentMap=var3035, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS>=var2732, $r1=var949, <org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS>=var292, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3329, r2=var368, b1=var1857, $i0=var206, org.apache.dubbo.common.logger.jcl.JclLoggerAdapter=var2439, $r6=var339, org.apache.dubbo.common.logger.LoggerFactory=var2613, org.apache.dubbo.common.logger.LoggerAdapter=var1663}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts $r0 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r0.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap LOGGERS> = $r0;	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.logger.LoggerFactory: java.util.concurrent.ConcurrentMap ERROR_TYPE_AWARE_LOGGERS> = $r1;	r2 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String,java.lang.String)>("dubbo.application.logger", "");	b1 = -1;	$i0 = virtualinvoke r2.<java.lang.String: int hashCode()>();	lookupswitch($i0) {     case -1097386376: goto $z7 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j2");     case 105043: goto $z6 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jcl");     case 105073: goto $z5 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("jdk");     case 103147770: goto $z4 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("log4j");     case 109522083: goto $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>("slf4j");     default: goto tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; }; };	tableswitch(b1) {     case 0: goto $r7 = new org.apache.dubbo.common.logger.slf4j.Slf4jLoggerAdapter;     case 1: goto $r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;     case 2: goto $r5 = new org.apache.dubbo.common.logger.log4j.Log4jLoggerAdapter;     case 3: goto $r4 = new org.apache.dubbo.common.logger.jdk.JdkLoggerAdapter;     case 4: goto $r3 = new org.apache.dubbo.common.logger.log4j2.Log4j2LoggerAdapter;     default: goto $r8 = newarray (java.lang.Class)[5]; };	$r6 = new org.apache.dubbo.common.logger.jcl.JclLoggerAdapter;	specialinvoke $r6.<org.apache.dubbo.common.logger.jcl.JclLoggerAdapter: void <init>()>();	staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: void setLoggerAdapter(org.apache.dubbo.common.logger.LoggerAdapter)>($r6);	goto [?= return];	return
;block_num 4
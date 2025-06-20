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

(declare-sort var3956 0)
(declare-sort var1990 0)
(declare-sort var785 0)
(declare-sort var3911 0)
(declare-sort var1482 0)
(declare-sort var3402 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1990-init () var1990)
(declare-fun <init>/-201242697 (var1990) void)
(declare-fun var785_getLocalHost/-1653363627 () String)
(declare-fun var3911_put/1464166817 (var3911 var1482 var1482) var1482)
(declare-fun cast-from-var1990-to-var3911 (var1990) var3911)
(declare-fun cast-from-String-to-var1482 (String) var1482)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3402_getPid/-756941384 () Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var785_getLocalHostName/1693220298 () String)
(declare-fun applicationName/705620587 (var3956) String)
(declare-fun threadPoolName/705620587 (var3956) String)
(declare-const null-var3956 var3956)
(declare-const var733 var3956) ; Statement: r7 := @this: org.apache.dubbo.metrics.model.ThreadPoolRejectMetric 
(assert (not (= var733 null-var3956)))
(define-const var3202 var1990 var1990-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var3202)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var3202!1 var1990)
(define-const var2527 String var785_getLocalHost/-1653363627) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
;(assert (var3911_put/1464166817 (cast-from-var1990-to-var3911 var3202!1) (cast-from-String-to-var1482 "ip") (cast-from-String-to-var1482 var2527))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("ip", $r1) 

(declare-const var3202!2 var1990)
(declare-const var2342 String)
(declare-const var2527!1 String)
(define-const var1616 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1616)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1616!1 String)
(assert (= var1616!1 ""))
(define-const var855 Int var3402_getPid/-756941384) ; Statement: $i0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: int getPid()>() 
(assert true)
(define-const var2688 String (append/-1001720160 var1616!1 var855)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1616!2 String)
(assert (str.prefixof var1616!1 var1616!2))
(assert true)
(define-const var142 String (append/672562846 var2688 "")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("") 
(declare-const var2688!1 String)
(assert (= var2688!1 (str.++ var2688 "")))
(assert true)
(define-const var2782 String (toString/-2075883882 var142)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3911_put/1464166817 (cast-from-var1990-to-var3911 var3202!2) (cast-from-String-to-var1482 "pid") (cast-from-String-to-var1482 var2782))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("pid", $r5) 

(declare-const var3202!3 var1990)
(declare-const var1227 String)
(declare-const var2782!1 String)
(define-const var1383 String var785_getLocalHostName/1693220298) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostName()>() 
;(assert (var3911_put/1464166817 (cast-from-var1990-to-var3911 var3202!3) (cast-from-String-to-var1482 "hostname") (cast-from-String-to-var1482 var1383))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("hostname", $r6) 

(declare-const var3202!4 var1990)
(declare-const var930 String)
(declare-const var1383!1 String)
(define-const var1546 String (applicationName/705620587 var733)) ; Statement: $r8 = r7.<org.apache.dubbo.metrics.model.ThreadPoolRejectMetric: java.lang.String applicationName> 
;(assert (var3911_put/1464166817 (cast-from-var1990-to-var3911 var3202!4) (cast-from-String-to-var1482 "application.name") (cast-from-String-to-var1482 var1546))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("application.name", $r8) 

(declare-const var3202!5 var1990)
(declare-const var1432 String)
(declare-const var1546!1 String)
(define-const var2855 String (threadPoolName/705620587 var733)) ; Statement: $r9 = r7.<org.apache.dubbo.metrics.model.ThreadPoolRejectMetric: java.lang.String threadPoolName> 
;(assert (var3911_put/1464166817 (cast-from-var1990-to-var3911 var3202!5) (cast-from-String-to-var1482 "thread.pool.name") (cast-from-String-to-var1482 var2855))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("thread.pool.name", $r9) 

(declare-const var3202!6 var1990)
(declare-const var2101 String)
(declare-const var2855!1 String)
 ; Statement: return $r0 
(check-sat)
; {var1990-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var785_getLocalHost/-1653363627=([], java.lang.String), var3911_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var1990-to-var3911=([java.util.HashMap], java.util.Map), cast-from-String-to-var1482=([java.lang.String], java.lang.Object), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3402_getPid/-756941384=([], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var785_getLocalHostName/1693220298=([], java.lang.String), applicationName/705620587=([org.apache.dubbo.metrics.model.ThreadPoolRejectMetric], java.lang.String), threadPoolName/705620587=([org.apache.dubbo.metrics.model.ThreadPoolRejectMetric], java.lang.String)}
; {var3956=org.apache.dubbo.metrics.model.ThreadPoolRejectMetric, var733=r7, var1990=java.util.HashMap, var3202=$r0, var785=org.apache.dubbo.common.utils.NetUtils, var2527=$r1, var3911=java.util.Map, var1482=java.lang.Object, var2342="ip", var1616=$r2, var3402=org.apache.dubbo.common.utils.ConfigUtils, var855=$i0, var2688=$r3, var142=$r4, var2782=$r5, var1227="pid", var1383=$r6, var930="hostname", var1546=$r8, var1432="application.name", var2855=$r9, var2101="thread.pool.name"}
; {org.apache.dubbo.metrics.model.ThreadPoolRejectMetric=var3956, r7=var733, java.util.HashMap=var1990, $r0=var3202, org.apache.dubbo.common.utils.NetUtils=var785, $r1=var2527, java.util.Map=var3911, java.lang.Object=var1482, "ip"=var2342, $r2=var1616, org.apache.dubbo.common.utils.ConfigUtils=var3402, $i0=var855, $r3=var2688, $r4=var142, $r5=var2782, "pid"=var1227, $r6=var1383, "hostname"=var930, $r8=var1546, "application.name"=var1432, $r9=var2855, "thread.pool.name"=var2101}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.metrics.model.ThreadPoolRejectMetric;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$r1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("ip", $r1);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$i0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: int getPid()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("pid", $r5);	$r6 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostName()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("hostname", $r6);	$r8 = r7.<org.apache.dubbo.metrics.model.ThreadPoolRejectMetric: java.lang.String applicationName>;	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("application.name", $r8);	$r9 = r7.<org.apache.dubbo.metrics.model.ThreadPoolRejectMetric: java.lang.String threadPoolName>;	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("thread.pool.name", $r9);	return $r0
;block_num 1
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

(declare-sort var472 0)
(declare-sort var2663 0)
(declare-sort var1064 0)
(declare-sort var1584 0)
(declare-sort var2265 0)
(declare-sort var1868 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2663-init () var2663)
(declare-fun <init>/-201242697 (var2663) void)
(declare-fun var1064_getLocalHost/-1653363627 () String)
(declare-fun var1584_put/1464166817 (var1584 var2265 var2265) var2265)
(declare-fun cast-from-var2663-to-var1584 (var2663) var1584)
(declare-fun cast-from-String-to-var2265 (String) var2265)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1868_getPid/-756941384 () Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1064_getLocalHostName/1693220298 () String)
(declare-fun applicationName/1942870764 (var472) String)
(declare-fun threadPoolName/1942870764 (var472) String)
(declare-const null-var472 var472)
(declare-const var3793 var472) ; Statement: r7 := @this: org.apache.dubbo.metrics.model.ThreadPoolMetric 
(assert (not (= var3793 null-var472)))
(define-const var2222 var2663 var2663-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2222)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var2222!1 var2663)
(define-const var3491 String var1064_getLocalHost/-1653363627) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
;(assert (var1584_put/1464166817 (cast-from-var2663-to-var1584 var2222!1) (cast-from-String-to-var2265 "ip") (cast-from-String-to-var2265 var3491))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("ip", $r1) 

(declare-const var2222!2 var2663)
(declare-const var3236 String)
(declare-const var3491!1 String)
(define-const var383 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var383)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var383!1 String)
(assert (= var383!1 ""))
(define-const var116 Int var1868_getPid/-756941384) ; Statement: $i0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: int getPid()>() 
(assert true)
(define-const var9 String (append/-1001720160 var383!1 var116)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var383!2 String)
(assert (str.prefixof var383!1 var383!2))
(assert true)
(define-const var2608 String (append/672562846 var9 "")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("") 
(declare-const var9!1 String)
(assert (= var9!1 (str.++ var9 "")))
(assert true)
(define-const var3808 String (toString/-2075883882 var2608)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1584_put/1464166817 (cast-from-var2663-to-var1584 var2222!2) (cast-from-String-to-var2265 "pid") (cast-from-String-to-var2265 var3808))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("pid", $r5) 

(declare-const var2222!3 var2663)
(declare-const var1485 String)
(declare-const var3808!1 String)
(define-const var554 String var1064_getLocalHostName/1693220298) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostName()>() 
;(assert (var1584_put/1464166817 (cast-from-var2663-to-var1584 var2222!3) (cast-from-String-to-var2265 "hostname") (cast-from-String-to-var2265 var554))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("hostname", $r6) 

(declare-const var2222!4 var2663)
(declare-const var2661 String)
(declare-const var554!1 String)
(define-const var2532 String (applicationName/1942870764 var3793)) ; Statement: $r8 = r7.<org.apache.dubbo.metrics.model.ThreadPoolMetric: java.lang.String applicationName> 
;(assert (var1584_put/1464166817 (cast-from-var2663-to-var1584 var2222!4) (cast-from-String-to-var2265 "application.name") (cast-from-String-to-var2265 var2532))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("application.name", $r8) 

(declare-const var2222!5 var2663)
(declare-const var3051 String)
(declare-const var2532!1 String)
(define-const var2935 String (threadPoolName/1942870764 var3793)) ; Statement: $r9 = r7.<org.apache.dubbo.metrics.model.ThreadPoolMetric: java.lang.String threadPoolName> 
;(assert (var1584_put/1464166817 (cast-from-var2663-to-var1584 var2222!5) (cast-from-String-to-var2265 "thread.pool.name") (cast-from-String-to-var2265 var2935))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("thread.pool.name", $r9) 

(declare-const var2222!6 var2663)
(declare-const var3061 String)
(declare-const var2935!1 String)
 ; Statement: return $r0 
(check-sat)
; {var2663-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var1064_getLocalHost/-1653363627=([], java.lang.String), var1584_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var2663-to-var1584=([java.util.HashMap], java.util.Map), cast-from-String-to-var2265=([java.lang.String], java.lang.Object), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1868_getPid/-756941384=([], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1064_getLocalHostName/1693220298=([], java.lang.String), applicationName/1942870764=([org.apache.dubbo.metrics.model.ThreadPoolMetric], java.lang.String), threadPoolName/1942870764=([org.apache.dubbo.metrics.model.ThreadPoolMetric], java.lang.String)}
; {var472=org.apache.dubbo.metrics.model.ThreadPoolMetric, var3793=r7, var2663=java.util.HashMap, var2222=$r0, var1064=org.apache.dubbo.common.utils.NetUtils, var3491=$r1, var1584=java.util.Map, var2265=java.lang.Object, var3236="ip", var383=$r2, var1868=org.apache.dubbo.common.utils.ConfigUtils, var116=$i0, var9=$r3, var2608=$r4, var3808=$r5, var1485="pid", var554=$r6, var2661="hostname", var2532=$r8, var3051="application.name", var2935=$r9, var3061="thread.pool.name"}
; {org.apache.dubbo.metrics.model.ThreadPoolMetric=var472, r7=var3793, java.util.HashMap=var2663, $r0=var2222, org.apache.dubbo.common.utils.NetUtils=var1064, $r1=var3491, java.util.Map=var1584, java.lang.Object=var2265, "ip"=var3236, $r2=var383, org.apache.dubbo.common.utils.ConfigUtils=var1868, $i0=var116, $r3=var9, $r4=var2608, $r5=var3808, "pid"=var1485, $r6=var554, "hostname"=var2661, $r8=var2532, "application.name"=var3051, $r9=var2935, "thread.pool.name"=var3061}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.metrics.model.ThreadPoolMetric;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$r1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("ip", $r1);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$i0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: int getPid()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("pid", $r5);	$r6 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostName()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("hostname", $r6);	$r8 = r7.<org.apache.dubbo.metrics.model.ThreadPoolMetric: java.lang.String applicationName>;	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("application.name", $r8);	$r9 = r7.<org.apache.dubbo.metrics.model.ThreadPoolMetric: java.lang.String threadPoolName>;	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("thread.pool.name", $r9);	return $r0
;block_num 1
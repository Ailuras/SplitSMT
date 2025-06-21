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

(declare-sort var907 0)
(declare-sort var3020 0)
(declare-sort var3304 0)
(declare-sort var328 0)
(declare-sort var3474 0)
(declare-sort var738 0)
(declare-sort var3842 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3304_access$200/-994605894 () var3020)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun this$0/-34348607 (var907) var3304)
(declare-fun var3304_access$100/-493022508 (var3304) var328)
(declare-fun var328_size/-1594421051 (var328) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3474_info/484404803 (var3474 String) void)
(declare-fun cast-from-var3020-to-var3474 (var3020) var3474)
(declare-fun var3304_access$400/-1536288438 (var3304) var3842)
(declare-fun release/1172908979 (var3842) void)
(declare-const null-var907 var907)
(declare-const null-var738 var738)
(declare-const var1531 var907) ; Statement: r1 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry$RemovalTask 
(assert (not (= var1531 null-var907)))
(define-const var3543 var3020 var3304_access$200/-994605894) ; Statement: $r7 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$200()>() 
(define-const var2109 String String-init) ; Statement: $r53 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2109)) ; Statement: specialinvoke $r53.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2109!1 String)
(assert (= var2109!1 ""))
(assert true)
(define-const var1609 String (append/672562846 var2109!1 "Clearing cached URLs, waiting to clear size ")) ; Statement: $r4 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Clearing cached URLs, waiting to clear size ") 
(declare-const var2109!2 String)
(assert (= var2109!2 (str.++ var2109!1 "Clearing cached URLs, waiting to clear size ")))
(define-const var195 var3304 (this$0/-34348607 var1531)) ; Statement: $r2 = r1.<org.apache.dubbo.registry.support.CacheableFailbackRegistry$RemovalTask: org.apache.dubbo.registry.support.CacheableFailbackRegistry this$0> 
(define-const var1072 var328 (var3304_access$100/-493022508 var195)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map access$100(org.apache.dubbo.registry.support.CacheableFailbackRegistry)>($r2) 
(define-const var2521 Int (var328_size/-1594421051 var1072)) ; Statement: $i0 = interfaceinvoke $r3.<java.util.Map: int size()>() 
(assert true)
(define-const var632 String (append/-1001720160 var1609 var2521)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1609!1 String)
(assert (str.prefixof var1609 var1609!1))
(assert true)
(define-const var1029 String (toString/-2075883882 var632)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3474_info/484404803 (cast-from-var3020-to-var3474 var3543) var1029)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r6) 

(declare-const var3543!1 var3020)
(declare-const var1029!1 String)
(define-const var743 Int 0) ; Statement: i19 = 0 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var125 var738) ; Statement: $r45 := @caughtexception 
(assert (not (= var125 null-var738)))
(assert true) ; Non Conditional
(define-const var679 var3304 (this$0/-34348607 var1531)) ; Statement: $r46 = r1.<org.apache.dubbo.registry.support.CacheableFailbackRegistry$RemovalTask: org.apache.dubbo.registry.support.CacheableFailbackRegistry this$0> 
(define-const var3645 var3842 (var3304_access$400/-1536288438 var679)) ; Statement: $r47 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.Semaphore access$400(org.apache.dubbo.registry.support.CacheableFailbackRegistry)>($r46) 
(assert true)
;(assert (release/1172908979 var3645)) ; Statement: virtualinvoke $r47.<java.util.concurrent.Semaphore: void release()>() 

(declare-const var3645!1 var3842)
 ; Statement: throw $r45 
(check-sat)
; {var3304_access$200/-994605894=([], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), this$0/-34348607=([org.apache.dubbo.registry.support.CacheableFailbackRegistry$RemovalTask], org.apache.dubbo.registry.support.CacheableFailbackRegistry), var3304_access$100/-493022508=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.Map), var328_size/-1594421051=([java.util.Map], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3474_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var3020-to-var3474=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var3304_access$400/-1536288438=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.concurrent.Semaphore), release/1172908979=([java.util.concurrent.Semaphore], void)}
; {var907=org.apache.dubbo.registry.support.CacheableFailbackRegistry$RemovalTask, var1531=r1, var3020=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3304=org.apache.dubbo.registry.support.CacheableFailbackRegistry, var3543=$r7, var2109=$r53, var1609=$r4, var195=$r2, var328=java.util.Map, var1072=$r3, var2521=$i0, var632=$r5, var1029=$r6, var3474=org.apache.dubbo.common.logger.Logger, var743=i19, var738=java.lang.Throwable, var125=$r45, var679=$r46, var3842=java.util.concurrent.Semaphore, var3645=$r47}
; {org.apache.dubbo.registry.support.CacheableFailbackRegistry$RemovalTask=var907, r1=var1531, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3020, org.apache.dubbo.registry.support.CacheableFailbackRegistry=var3304, $r7=var3543, $r53=var2109, $r4=var1609, $r2=var195, java.util.Map=var328, $r3=var1072, $i0=var2521, $r5=var632, $r6=var1029, org.apache.dubbo.common.logger.Logger=var3474, i19=var743, java.lang.Throwable=var738, $r45=var125, $r46=var679, java.util.concurrent.Semaphore=var3842, $r47=var3645}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry$RemovalTask;	$r7 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$200()>();	$r53 = new java.lang.StringBuilder;	specialinvoke $r53.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Clearing cached URLs, waiting to clear size ");	$r2 = r1.<org.apache.dubbo.registry.support.CacheableFailbackRegistry$RemovalTask: org.apache.dubbo.registry.support.CacheableFailbackRegistry this$0>;	$r3 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map access$100(org.apache.dubbo.registry.support.CacheableFailbackRegistry)>($r2);	$i0 = interfaceinvoke $r3.<java.util.Map: int size()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r6);	i19 = 0;	$r45 := @caughtexception;	$r46 = r1.<org.apache.dubbo.registry.support.CacheableFailbackRegistry$RemovalTask: org.apache.dubbo.registry.support.CacheableFailbackRegistry this$0>;	$r47 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.Semaphore access$400(org.apache.dubbo.registry.support.CacheableFailbackRegistry)>($r46);	virtualinvoke $r47.<java.util.concurrent.Semaphore: void release()>();	throw $r45
;block_num 3
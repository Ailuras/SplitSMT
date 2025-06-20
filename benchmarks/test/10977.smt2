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

(declare-sort var100 0)
(declare-sort var1018 0)
(declare-sort var147 0)
(declare-sort var3912 0)
(declare-sort var1958 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1018-init () var1018)
(declare-fun <init>/-201242697 (var1018) void)
(declare-fun var147_getLocalHost/-1653363627 () String)
(declare-fun var3912_put/1464166817 (var3912 var1958 var1958) var1958)
(declare-fun cast-from-var1018-to-var3912 (var1018) var3912)
(declare-fun cast-from-String-to-var1958 (String) var1958)
(declare-fun var147_getLocalHostName/1693220298 () String)
(declare-fun applicationName/792142237 (var100) String)
(declare-fun key/792142237 (var100) String)
(declare-fun group/792142237 (var100) String)
(declare-fun configCenter/792142237 (var100) String)
(declare-fun changeType/792142237 (var100) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-const null-var100 var100)
(declare-const var3406 var100) ; Statement: r3 := @this: org.apache.dubbo.metrics.model.ConfigCenterMetric 
(assert (not (= var3406 null-var100)))
(define-const var2018 var1018 var1018-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2018)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var2018!1 var1018)
(define-const var2133 String var147_getLocalHost/-1653363627) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
;(assert (var3912_put/1464166817 (cast-from-var1018-to-var3912 var2018!1) (cast-from-String-to-var1958 "ip") (cast-from-String-to-var1958 var2133))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("ip", $r1) 

(declare-const var2018!2 var1018)
(declare-const var1714 String)
(declare-const var2133!1 String)
(define-const var1774 String var147_getLocalHostName/1693220298) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostName()>() 
;(assert (var3912_put/1464166817 (cast-from-var1018-to-var3912 var2018!2) (cast-from-String-to-var1958 "hostname") (cast-from-String-to-var1958 var1774))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("hostname", $r2) 

(declare-const var2018!3 var1018)
(declare-const var1225 String)
(declare-const var1774!1 String)
(define-const var2479 String (applicationName/792142237 var3406)) ; Statement: $r4 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String applicationName> 
;(assert (var3912_put/1464166817 (cast-from-var1018-to-var3912 var2018!3) (cast-from-String-to-var1958 "application.name") (cast-from-String-to-var1958 var2479))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("application.name", $r4) 

(declare-const var2018!4 var1018)
(declare-const var2469 String)
(declare-const var2479!1 String)
(define-const var752 String (key/792142237 var3406)) ; Statement: $r5 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String key> 
;(assert (var3912_put/1464166817 (cast-from-var1018-to-var3912 var2018!4) (cast-from-String-to-var1958 "key") (cast-from-String-to-var1958 var752))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("key", $r5) 

(declare-const var2018!5 var1018)
(declare-const var2107 String)
(declare-const var752!1 String)
(define-const var3525 String (group/792142237 var3406)) ; Statement: $r6 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String group> 
;(assert (var3912_put/1464166817 (cast-from-var1018-to-var3912 var2018!5) (cast-from-String-to-var1958 "group") (cast-from-String-to-var1958 var3525))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("group", $r6) 

(declare-const var2018!6 var1018)
(declare-const var3524 String)
(declare-const var3525!1 String)
(define-const var1544 String (configCenter/792142237 var3406)) ; Statement: $r7 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String configCenter> 
;(assert (var3912_put/1464166817 (cast-from-var1018-to-var3912 var2018!6) (cast-from-String-to-var1958 "config.center") (cast-from-String-to-var1958 var1544))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("config.center", $r7) 

(declare-const var2018!7 var1018)
(declare-const var2470 String)
(declare-const var1544!1 String)
(define-const var1604 String (changeType/792142237 var3406)) ; Statement: $r8 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String changeType> 
(assert true)
(define-const var2095 String (toLowerCase/415700667 var1604)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.String: java.lang.String toLowerCase()>() 
;(assert (var3912_put/1464166817 (cast-from-var1018-to-var3912 var2018!7) (cast-from-String-to-var1958 "change.type") (cast-from-String-to-var1958 var2095))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("change.type", $r9) 

(declare-const var2018!8 var1018)
(declare-const var3625 String)
(declare-const var2095!1 String)
 ; Statement: return $r0 
(check-sat)
; {var1018-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var147_getLocalHost/-1653363627=([], java.lang.String), var3912_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var1018-to-var3912=([java.util.HashMap], java.util.Map), cast-from-String-to-var1958=([java.lang.String], java.lang.Object), var147_getLocalHostName/1693220298=([], java.lang.String), applicationName/792142237=([org.apache.dubbo.metrics.model.ConfigCenterMetric], java.lang.String), key/792142237=([org.apache.dubbo.metrics.model.ConfigCenterMetric], java.lang.String), group/792142237=([org.apache.dubbo.metrics.model.ConfigCenterMetric], java.lang.String), configCenter/792142237=([org.apache.dubbo.metrics.model.ConfigCenterMetric], java.lang.String), changeType/792142237=([org.apache.dubbo.metrics.model.ConfigCenterMetric], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String)}
; {var100=org.apache.dubbo.metrics.model.ConfigCenterMetric, var3406=r3, var1018=java.util.HashMap, var2018=$r0, var147=org.apache.dubbo.common.utils.NetUtils, var2133=$r1, var3912=java.util.Map, var1958=java.lang.Object, var1714="ip", var1774=$r2, var1225="hostname", var2479=$r4, var2469="application.name", var752=$r5, var2107="key", var3525=$r6, var3524="group", var1544=$r7, var2470="config.center", var1604=$r8, var2095=$r9, var3625="change.type"}
; {org.apache.dubbo.metrics.model.ConfigCenterMetric=var100, r3=var3406, java.util.HashMap=var1018, $r0=var2018, org.apache.dubbo.common.utils.NetUtils=var147, $r1=var2133, java.util.Map=var3912, java.lang.Object=var1958, "ip"=var1714, $r2=var1774, "hostname"=var1225, $r4=var2479, "application.name"=var2469, $r5=var752, "key"=var2107, $r6=var3525, "group"=var3524, $r7=var1544, "config.center"=var2470, $r8=var1604, $r9=var2095, "change.type"=var3625}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r3 := @this: org.apache.dubbo.metrics.model.ConfigCenterMetric;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$r1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("ip", $r1);	$r2 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostName()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("hostname", $r2);	$r4 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String applicationName>;	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("application.name", $r4);	$r5 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String key>;	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("key", $r5);	$r6 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String group>;	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("group", $r6);	$r7 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String configCenter>;	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("config.center", $r7);	$r8 = r3.<org.apache.dubbo.metrics.model.ConfigCenterMetric: java.lang.String changeType>;	$r9 = virtualinvoke $r8.<java.lang.String: java.lang.String toLowerCase()>();	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("change.type", $r9);	return $r0
;block_num 1
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

(declare-sort var3314 0)
(declare-sort var1297 0)
(declare-sort var875 0)
(declare-sort var3159 0)
(declare-sort var1303 0)
(declare-sort var1603 0)
(declare-sort var3571 0)
(declare-sort var3077 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun stats/-2020470243 (var1303) var3159)
(declare-fun cast-from-var3314-to-var1303 (var3314) var1303)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun var3571_singletonMap/2043092013 (var3077 var3077) var1603)
(declare-fun cast-from-String-to-var3077 (String) var3077)
(declare-fun incrementServiceKey/-369876059 (var3159 var1297 String var1603 Int) void)
(declare-const null-var3314 var3314)
(declare-const null-var1297 var1297)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var67 var3314) ; Statement: r0 := @this: org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector 
(assert (not (= var67 null-var3314)))
(declare-const var1953 var1297) ; Statement: r1 := @parameter0: org.apache.dubbo.metrics.model.key.MetricsKeyWrapper 
(assert (not (= var1953 null-var1297)))
(declare-const var708 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var708 null-String)))
(declare-const var1016 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var1016 null-Int)))
(declare-const var3847 String) ; Statement: r5 := @parameter3: java.lang.String 
(assert (not (= var3847 null-String)))
(define-const var1525 var3159 (stats/-2020470243 (cast-from-var3314-to-var1303 var67))) ; Statement: $r4 = r0.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.data.BaseStatComposite stats> 
(define-const var2426 String "REGISTRY_CLUSTER") ; Statement: $r3 = "REGISTRY_CLUSTER" 
(assert true)
(define-const var2720 String (toLowerCase/415700667 var2426)) ; Statement: $r6 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var728 var1603 (var3571_singletonMap/2043092013 (cast-from-String-to-var3077 var2720) (cast-from-String-to-var3077 var3847))) ; Statement: $r7 = staticinvoke <java.util.Collections: java.util.Map singletonMap(java.lang.Object,java.lang.Object)>($r6, r5) 
(assert true)
;(assert (incrementServiceKey/-369876059 var1525 var1953 var708 var728 var1016)) ; Statement: virtualinvoke $r4.<org.apache.dubbo.metrics.data.BaseStatComposite: void incrementServiceKey(org.apache.dubbo.metrics.model.key.MetricsKeyWrapper,java.lang.String,java.util.Map,int)>(r1, r2, $r7, i0) 

(declare-const var1525!1 var3159)
(declare-const var1953!1 var1297)
(declare-const var708!1 String)
(declare-const var728!1 var1603)
(declare-const var1016!1 Int)
 ; Statement: return 
(check-sat)
; {stats/-2020470243=([org.apache.dubbo.metrics.collector.CombMetricsCollector], org.apache.dubbo.metrics.data.BaseStatComposite), cast-from-var3314-to-var1303=([org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector], org.apache.dubbo.metrics.collector.CombMetricsCollector), toLowerCase/415700667=([java.lang.String], java.lang.String), var3571_singletonMap/2043092013=([java.lang.Object, java.lang.Object], java.util.Map), cast-from-String-to-var3077=([java.lang.String], java.lang.Object), incrementServiceKey/-369876059=([org.apache.dubbo.metrics.data.BaseStatComposite, org.apache.dubbo.metrics.model.key.MetricsKeyWrapper, java.lang.String, java.util.Map, int], void)}
; {var3314=org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector, var67=r0, var1297=org.apache.dubbo.metrics.model.key.MetricsKeyWrapper, var1953=r1, var708=r2, var875=null_type, var1016=i0, var3847=r5, var3159=org.apache.dubbo.metrics.data.BaseStatComposite, var1303=org.apache.dubbo.metrics.collector.CombMetricsCollector, var1525=$r4, var2426=$r3, var2720=$r6, var1603=java.util.Map, var3571=java.util.Collections, var3077=java.lang.Object, var728=$r7}
; {org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector=var3314, r0=var67, org.apache.dubbo.metrics.model.key.MetricsKeyWrapper=var1297, r1=var1953, r2=var708, null_type=var875, i0=var1016, r5=var3847, org.apache.dubbo.metrics.data.BaseStatComposite=var3159, org.apache.dubbo.metrics.collector.CombMetricsCollector=var1303, $r4=var1525, $r3=var2426, $r6=var2720, java.util.Map=var1603, java.util.Collections=var3571, java.lang.Object=var3077, $r7=var728}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector;	r1 := @parameter0: org.apache.dubbo.metrics.model.key.MetricsKeyWrapper;	r2 := @parameter1: java.lang.String;	i0 := @parameter2: int;	r5 := @parameter3: java.lang.String;	$r4 = r0.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.data.BaseStatComposite stats>;	$r3 = "REGISTRY_CLUSTER";	$r6 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	$r7 = staticinvoke <java.util.Collections: java.util.Map singletonMap(java.lang.Object,java.lang.Object)>($r6, r5);	virtualinvoke $r4.<org.apache.dubbo.metrics.data.BaseStatComposite: void incrementServiceKey(org.apache.dubbo.metrics.model.key.MetricsKeyWrapper,java.lang.String,java.util.Map,int)>(r1, r2, $r7, i0);	return
;block_num 1
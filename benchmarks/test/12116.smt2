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

(declare-sort var3056 0)
(declare-sort var2128 0)
(declare-sort var2804 0)
(declare-sort var1544 0)
(declare-sort var553 0)
(declare-sort var2520 0)
(declare-sort var2493 0)
(declare-sort var1106 0)
(declare-sort var3465 0)
(declare-sort var628 0)
(declare-sort var3180 0)
(declare-sort var3030 0)
(declare-sort var828 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1544-init () var1544)
(declare-fun applicationModel/-1752169560 (var3056) var553)
(declare-fun <init>/1439547020 (var1544 var553) void)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun var2493_singletonMap/2043092013 (var1106 var1106) var2520)
(declare-fun cast-from-String-to-var1106 (String) var1106)
(declare-fun setExtraInfo/141726821 (var1544 var2520) void)
(declare-fun internalStat/-1752169560 (var3056) var3465)
(declare-fun incrMetricsNum/279221545 (var3465 var2128 String) void)
(declare-fun getStats/2096174460 (var3180) var628)
(declare-fun cast-from-var3056-to-var3180 (var3056) var3180)
(declare-fun getRtStatComposite/576572359 (var628) var3030)
(declare-fun calcServiceKeyRt/1576133987 (var3030 String Int var828) void)
(declare-fun cast-from-var1544-to-var828 (var1544) var828)
(declare-const null-var3056 var3056)
(declare-const null-var2128 var2128)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3844 var3056) ; Statement: r1 := @this: org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector 
(assert (not (= var3844 null-var3056)))
(declare-const var3606 var2128) ; Statement: r7 := @parameter0: org.apache.dubbo.metrics.model.key.MetricsKey 
(assert (not (= var3606 null-var2128)))
(declare-const var2487 String) ; Statement: r10 := @parameter1: java.lang.String 
(assert (not (= var2487 null-String)))
(declare-const var397 Int) ; Statement: r11 := @parameter2: java.lang.Long 
(assert (not (= var397 null-Int)))
(declare-const var1136 String) ; Statement: r4 := @parameter3: java.lang.String 
(assert (not (= var1136 null-String)))
(define-const var2259 var1544 var1544-init) ; Statement: $r0 = new org.apache.dubbo.metrics.model.ApplicationMetric 
(define-const var2147 var553 (applicationModel/-1752169560 var3844)) ; Statement: $r2 = r1.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
;(assert (<init>/1439547020 var2259 var2147)) ; Statement: specialinvoke $r0.<org.apache.dubbo.metrics.model.ApplicationMetric: void <init>(org.apache.dubbo.rpc.model.ApplicationModel)>($r2) 

(declare-const var2259!1 var1544)
(declare-const var2147!1 var553)
(define-const var1727 String "REGISTRY_CLUSTER") ; Statement: $r3 = "REGISTRY_CLUSTER" 
(assert true)
(define-const var1407 String (toLowerCase/415700667 var1727)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var2970 var2520 (var2493_singletonMap/2043092013 (cast-from-String-to-var1106 var1407) (cast-from-String-to-var1106 var1136))) ; Statement: $r6 = staticinvoke <java.util.Collections: java.util.Map singletonMap(java.lang.Object,java.lang.Object)>($r5, r4) 
(assert true)
;(assert (setExtraInfo/141726821 var2259!1 var2970)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.metrics.model.ApplicationMetric: void setExtraInfo(java.util.Map)>($r6) 

(declare-const var2259!2 var1544)
(declare-const var2970!1 var2520)
(define-const var717 var3465 (internalStat/-1752169560 var3844)) ; Statement: $r8 = r1.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.registry.collector.RegistryStatComposite internalStat> 
(assert true)
;(assert (incrMetricsNum/279221545 var717 var3606 var1136)) ; Statement: virtualinvoke $r8.<org.apache.dubbo.metrics.registry.collector.RegistryStatComposite: void incrMetricsNum(org.apache.dubbo.metrics.model.key.MetricsKey,java.lang.String)>(r7, r4) 

(declare-const var717!1 var3465)
(declare-const var3606!1 var2128)
(declare-const var1136!1 String)
(assert true)
(define-const var1745 var628 (getStats/2096174460 (cast-from-var3056-to-var3180 var3844))) ; Statement: $r9 = virtualinvoke r1.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.data.BaseStatComposite getStats()>() 
(assert true)
(define-const var2634 var3030 (getRtStatComposite/576572359 var1745)) ; Statement: $r12 = virtualinvoke $r9.<org.apache.dubbo.metrics.data.BaseStatComposite: org.apache.dubbo.metrics.data.RtStatComposite getRtStatComposite()>() 
(assert true)
;(assert (calcServiceKeyRt/1576133987 var2634 var2487 var397 (cast-from-var1544-to-var828 var2259!2))) ; Statement: virtualinvoke $r12.<org.apache.dubbo.metrics.data.RtStatComposite: void calcServiceKeyRt(java.lang.String,java.lang.Long,org.apache.dubbo.metrics.model.Metric)>(r10, r11, $r0) 

(declare-const var2634!1 var3030)
(declare-const var2487!1 String)
(declare-const var397!1 Int)
(declare-const var2259!3 var1544)
 ; Statement: return 
(check-sat)
; {var1544-init=([], org.apache.dubbo.metrics.model.ApplicationMetric), applicationModel/-1752169560=([org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector], org.apache.dubbo.rpc.model.ApplicationModel), <init>/1439547020=([org.apache.dubbo.metrics.model.ApplicationMetric, org.apache.dubbo.rpc.model.ApplicationModel], void), toLowerCase/415700667=([java.lang.String], java.lang.String), var2493_singletonMap/2043092013=([java.lang.Object, java.lang.Object], java.util.Map), cast-from-String-to-var1106=([java.lang.String], java.lang.Object), setExtraInfo/141726821=([org.apache.dubbo.metrics.model.ApplicationMetric, java.util.Map], void), internalStat/-1752169560=([org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector], org.apache.dubbo.metrics.registry.collector.RegistryStatComposite), incrMetricsNum/279221545=([org.apache.dubbo.metrics.registry.collector.RegistryStatComposite, org.apache.dubbo.metrics.model.key.MetricsKey, java.lang.String], void), getStats/2096174460=([org.apache.dubbo.metrics.collector.CombMetricsCollector], org.apache.dubbo.metrics.data.BaseStatComposite), cast-from-var3056-to-var3180=([org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector], org.apache.dubbo.metrics.collector.CombMetricsCollector), getRtStatComposite/576572359=([org.apache.dubbo.metrics.data.BaseStatComposite], org.apache.dubbo.metrics.data.RtStatComposite), calcServiceKeyRt/1576133987=([org.apache.dubbo.metrics.data.RtStatComposite, java.lang.String, java.lang.Long, org.apache.dubbo.metrics.model.Metric], void), cast-from-var1544-to-var828=([org.apache.dubbo.metrics.model.ApplicationMetric], org.apache.dubbo.metrics.model.Metric)}
; {var3056=org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector, var3844=r1, var2128=org.apache.dubbo.metrics.model.key.MetricsKey, var3606=r7, var2487=r10, var2804=null_type, var397=r11, var1136=r4, var1544=org.apache.dubbo.metrics.model.ApplicationMetric, var2259=$r0, var553=org.apache.dubbo.rpc.model.ApplicationModel, var2147=$r2, var1727=$r3, var1407=$r5, var2520=java.util.Map, var2493=java.util.Collections, var1106=java.lang.Object, var2970=$r6, var3465=org.apache.dubbo.metrics.registry.collector.RegistryStatComposite, var717=$r8, var628=org.apache.dubbo.metrics.data.BaseStatComposite, var3180=org.apache.dubbo.metrics.collector.CombMetricsCollector, var1745=$r9, var3030=org.apache.dubbo.metrics.data.RtStatComposite, var2634=$r12, var828=org.apache.dubbo.metrics.model.Metric}
; {org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector=var3056, r1=var3844, org.apache.dubbo.metrics.model.key.MetricsKey=var2128, r7=var3606, r10=var2487, null_type=var2804, r11=var397, r4=var1136, org.apache.dubbo.metrics.model.ApplicationMetric=var1544, $r0=var2259, org.apache.dubbo.rpc.model.ApplicationModel=var553, $r2=var2147, $r3=var1727, $r5=var1407, java.util.Map=var2520, java.util.Collections=var2493, java.lang.Object=var1106, $r6=var2970, org.apache.dubbo.metrics.registry.collector.RegistryStatComposite=var3465, $r8=var717, org.apache.dubbo.metrics.data.BaseStatComposite=var628, org.apache.dubbo.metrics.collector.CombMetricsCollector=var3180, $r9=var1745, org.apache.dubbo.metrics.data.RtStatComposite=var3030, $r12=var2634, org.apache.dubbo.metrics.model.Metric=var828}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector;	r7 := @parameter0: org.apache.dubbo.metrics.model.key.MetricsKey;	r10 := @parameter1: java.lang.String;	r11 := @parameter2: java.lang.Long;	r4 := @parameter3: java.lang.String;	$r0 = new org.apache.dubbo.metrics.model.ApplicationMetric;	$r2 = r1.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	specialinvoke $r0.<org.apache.dubbo.metrics.model.ApplicationMetric: void <init>(org.apache.dubbo.rpc.model.ApplicationModel)>($r2);	$r3 = "REGISTRY_CLUSTER";	$r5 = virtualinvoke $r3.<java.lang.String: java.lang.String toLowerCase()>();	$r6 = staticinvoke <java.util.Collections: java.util.Map singletonMap(java.lang.Object,java.lang.Object)>($r5, r4);	virtualinvoke $r0.<org.apache.dubbo.metrics.model.ApplicationMetric: void setExtraInfo(java.util.Map)>($r6);	$r8 = r1.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.registry.collector.RegistryStatComposite internalStat>;	virtualinvoke $r8.<org.apache.dubbo.metrics.registry.collector.RegistryStatComposite: void incrMetricsNum(org.apache.dubbo.metrics.model.key.MetricsKey,java.lang.String)>(r7, r4);	$r9 = virtualinvoke r1.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.data.BaseStatComposite getStats()>();	$r12 = virtualinvoke $r9.<org.apache.dubbo.metrics.data.BaseStatComposite: org.apache.dubbo.metrics.data.RtStatComposite getRtStatComposite()>();	virtualinvoke $r12.<org.apache.dubbo.metrics.data.RtStatComposite: void calcServiceKeyRt(java.lang.String,java.lang.Long,org.apache.dubbo.metrics.model.Metric)>(r10, r11, $r0);	return
;block_num 1
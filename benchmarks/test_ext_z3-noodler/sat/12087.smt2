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

(declare-sort var201 0)
(declare-sort var2026 0)
(declare-sort var1912 0)
(declare-sort var3328 0)
(declare-sort var1258 0)
(declare-sort var3451 0)
(declare-sort var2744 0)
(declare-sort var3431 0)
(declare-sort var3958 0)
(declare-sort var3536 0)
(declare-sort var3589 0)
(declare-sort var746 0)
(declare-sort var822 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun var1258_singletonMap/2043092013 (var3451 var3451) var3328)
(declare-fun cast-from-String-to-var3451 (String) var3451)
(declare-fun var2744-init () var2744)
(declare-fun applicationModel/-1752169560 (var201) var3431)
(declare-fun <init>/700293789 (var2744 var3431 String) void)
(declare-fun setExtraInfo/141726821 (var3958 var3328) void)
(declare-fun cast-from-var2744-to-var3958 (var2744) var3958)
(declare-fun stats/-2020470243 (var3589) var3536)
(declare-fun cast-from-var201-to-var3589 (var201) var3589)
(declare-fun incrementServiceKey/-369876059 (var3536 var1912 String var3328 Int) void)
(declare-fun getStats/2096174460 (var3589) var3536)
(declare-fun getRtStatComposite/576572359 (var3536) var746)
(declare-fun getType/1339125236 (var1912) String)
(declare-fun calcServiceKeyRt/1576133987 (var746 String Int var822) void)
(declare-fun cast-from-var2744-to-var822 (var2744) var822)
(declare-const null-var201 var201)
(declare-const null-String String)
(declare-const null-var1912 var1912)
(declare-const null-Int Int)
(declare-const var3001 var201) ; Statement: r5 := @this: org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector 
(assert (not (= var3001 null-var201)))
(declare-const var3199 String) ; Statement: r6 := @parameter0: java.lang.String 
(assert (not (= var3199 null-String)))
(declare-const var1671 var1912) ; Statement: r8 := @parameter1: org.apache.dubbo.metrics.model.key.MetricsKeyWrapper 
(assert (not (= var1671 null-var1912)))
(declare-const var1141 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var1141 null-Int)))
(declare-const var3916 Int) ; Statement: r11 := @parameter3: java.lang.Long 
(assert (not (= var3916 null-Int)))
(declare-const var568 String) ; Statement: r1 := @parameter4: java.lang.String 
(assert (not (= var568 null-String)))
(define-const var3652 String "REGISTRY_CLUSTER") ; Statement: $r0 = "REGISTRY_CLUSTER" 
(assert true)
(define-const var2269 String (toLowerCase/415700667 var3652)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var1278 var3328 (var1258_singletonMap/2043092013 (cast-from-String-to-var3451 var2269) (cast-from-String-to-var3451 var568))) ; Statement: r3 = staticinvoke <java.util.Collections: java.util.Map singletonMap(java.lang.Object,java.lang.Object)>($r2, r1) 
(define-const var2242 var2744 var2744-init) ; Statement: $r4 = new org.apache.dubbo.metrics.model.ServiceKeyMetric 
(define-const var2434 var3431 (applicationModel/-1752169560 var3001)) ; Statement: $r7 = r5.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
;(assert (<init>/700293789 var2242 var2434 var3199)) ; Statement: specialinvoke $r4.<org.apache.dubbo.metrics.model.ServiceKeyMetric: void <init>(org.apache.dubbo.rpc.model.ApplicationModel,java.lang.String)>($r7, r6) 

(declare-const var2242!1 var2744)
(declare-const var2434!1 var3431)
(declare-const var3199!1 String)
(assert true)
;(assert (setExtraInfo/141726821 (cast-from-var2744-to-var3958 var2242!1) var1278)) ; Statement: virtualinvoke $r4.<org.apache.dubbo.metrics.model.ServiceKeyMetric: void setExtraInfo(java.util.Map)>(r3) 

(declare-const var2242!2 var2744)
(declare-const var1278!1 var3328)
(define-const var1737 var3536 (stats/-2020470243 (cast-from-var201-to-var3589 var3001))) ; Statement: $r9 = r5.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.data.BaseStatComposite stats> 
(assert true)
;(assert (incrementServiceKey/-369876059 var1737 var1671 var3199!1 var1278!1 var1141)) ; Statement: virtualinvoke $r9.<org.apache.dubbo.metrics.data.BaseStatComposite: void incrementServiceKey(org.apache.dubbo.metrics.model.key.MetricsKeyWrapper,java.lang.String,java.util.Map,int)>(r8, r6, r3, i0) 

(declare-const var1737!1 var3536)
(declare-const var1671!1 var1912)
(declare-const var3199!2 String)
(declare-const var1278!2 var3328)
(declare-const var1141!1 Int)
(assert true)
(define-const var1074 var3536 (getStats/2096174460 (cast-from-var201-to-var3589 var3001))) ; Statement: $r10 = virtualinvoke r5.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.data.BaseStatComposite getStats()>() 
(assert true)
(define-const var624 var746 (getRtStatComposite/576572359 var1074)) ; Statement: $r13 = virtualinvoke $r10.<org.apache.dubbo.metrics.data.BaseStatComposite: org.apache.dubbo.metrics.data.RtStatComposite getRtStatComposite()>() 
(assert true)
(define-const var589 String (getType/1339125236 var1671!1)) ; Statement: $r12 = virtualinvoke r8.<org.apache.dubbo.metrics.model.key.MetricsKeyWrapper: java.lang.String getType()>() 
(assert true)
;(assert (calcServiceKeyRt/1576133987 var624 var589 var3916 (cast-from-var2744-to-var822 var2242!2))) ; Statement: virtualinvoke $r13.<org.apache.dubbo.metrics.data.RtStatComposite: void calcServiceKeyRt(java.lang.String,java.lang.Long,org.apache.dubbo.metrics.model.Metric)>($r12, r11, $r4) 

(declare-const var624!1 var746)
(declare-const var589!1 String)
(declare-const var3916!1 Int)
(declare-const var2242!3 var2744)
 ; Statement: return 
(check-sat)
; {toLowerCase/415700667=([java.lang.String], java.lang.String), var1258_singletonMap/2043092013=([java.lang.Object, java.lang.Object], java.util.Map), cast-from-String-to-var3451=([java.lang.String], java.lang.Object), var2744-init=([], org.apache.dubbo.metrics.model.ServiceKeyMetric), applicationModel/-1752169560=([org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector], org.apache.dubbo.rpc.model.ApplicationModel), <init>/700293789=([org.apache.dubbo.metrics.model.ServiceKeyMetric, org.apache.dubbo.rpc.model.ApplicationModel, java.lang.String], void), setExtraInfo/141726821=([org.apache.dubbo.metrics.model.ApplicationMetric, java.util.Map], void), cast-from-var2744-to-var3958=([org.apache.dubbo.metrics.model.ServiceKeyMetric], org.apache.dubbo.metrics.model.ApplicationMetric), stats/-2020470243=([org.apache.dubbo.metrics.collector.CombMetricsCollector], org.apache.dubbo.metrics.data.BaseStatComposite), cast-from-var201-to-var3589=([org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector], org.apache.dubbo.metrics.collector.CombMetricsCollector), incrementServiceKey/-369876059=([org.apache.dubbo.metrics.data.BaseStatComposite, org.apache.dubbo.metrics.model.key.MetricsKeyWrapper, java.lang.String, java.util.Map, int], void), getStats/2096174460=([org.apache.dubbo.metrics.collector.CombMetricsCollector], org.apache.dubbo.metrics.data.BaseStatComposite), getRtStatComposite/576572359=([org.apache.dubbo.metrics.data.BaseStatComposite], org.apache.dubbo.metrics.data.RtStatComposite), getType/1339125236=([org.apache.dubbo.metrics.model.key.MetricsKeyWrapper], java.lang.String), calcServiceKeyRt/1576133987=([org.apache.dubbo.metrics.data.RtStatComposite, java.lang.String, java.lang.Long, org.apache.dubbo.metrics.model.Metric], void), cast-from-var2744-to-var822=([org.apache.dubbo.metrics.model.ServiceKeyMetric], org.apache.dubbo.metrics.model.Metric)}
; {var201=org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector, var3001=r5, var3199=r6, var2026=null_type, var1912=org.apache.dubbo.metrics.model.key.MetricsKeyWrapper, var1671=r8, var1141=i0, var3916=r11, var568=r1, var3652=$r0, var2269=$r2, var3328=java.util.Map, var1258=java.util.Collections, var3451=java.lang.Object, var1278=r3, var2744=org.apache.dubbo.metrics.model.ServiceKeyMetric, var2242=$r4, var3431=org.apache.dubbo.rpc.model.ApplicationModel, var2434=$r7, var3958=org.apache.dubbo.metrics.model.ApplicationMetric, var3536=org.apache.dubbo.metrics.data.BaseStatComposite, var3589=org.apache.dubbo.metrics.collector.CombMetricsCollector, var1737=$r9, var1074=$r10, var746=org.apache.dubbo.metrics.data.RtStatComposite, var624=$r13, var589=$r12, var822=org.apache.dubbo.metrics.model.Metric}
; {org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector=var201, r5=var3001, r6=var3199, null_type=var2026, org.apache.dubbo.metrics.model.key.MetricsKeyWrapper=var1912, r8=var1671, i0=var1141, r11=var3916, r1=var568, $r0=var3652, $r2=var2269, java.util.Map=var3328, java.util.Collections=var1258, java.lang.Object=var3451, r3=var1278, org.apache.dubbo.metrics.model.ServiceKeyMetric=var2744, $r4=var2242, org.apache.dubbo.rpc.model.ApplicationModel=var3431, $r7=var2434, org.apache.dubbo.metrics.model.ApplicationMetric=var3958, org.apache.dubbo.metrics.data.BaseStatComposite=var3536, org.apache.dubbo.metrics.collector.CombMetricsCollector=var3589, $r9=var1737, $r10=var1074, org.apache.dubbo.metrics.data.RtStatComposite=var746, $r13=var624, $r12=var589, org.apache.dubbo.metrics.model.Metric=var822}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r5 := @this: org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector;	r6 := @parameter0: java.lang.String;	r8 := @parameter1: org.apache.dubbo.metrics.model.key.MetricsKeyWrapper;	i0 := @parameter2: int;	r11 := @parameter3: java.lang.Long;	r1 := @parameter4: java.lang.String;	$r0 = "REGISTRY_CLUSTER";	$r2 = virtualinvoke $r0.<java.lang.String: java.lang.String toLowerCase()>();	r3 = staticinvoke <java.util.Collections: java.util.Map singletonMap(java.lang.Object,java.lang.Object)>($r2, r1);	$r4 = new org.apache.dubbo.metrics.model.ServiceKeyMetric;	$r7 = r5.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	specialinvoke $r4.<org.apache.dubbo.metrics.model.ServiceKeyMetric: void <init>(org.apache.dubbo.rpc.model.ApplicationModel,java.lang.String)>($r7, r6);	virtualinvoke $r4.<org.apache.dubbo.metrics.model.ServiceKeyMetric: void setExtraInfo(java.util.Map)>(r3);	$r9 = r5.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.data.BaseStatComposite stats>;	virtualinvoke $r9.<org.apache.dubbo.metrics.data.BaseStatComposite: void incrementServiceKey(org.apache.dubbo.metrics.model.key.MetricsKeyWrapper,java.lang.String,java.util.Map,int)>(r8, r6, r3, i0);	$r10 = virtualinvoke r5.<org.apache.dubbo.metrics.registry.collector.RegistryMetricsCollector: org.apache.dubbo.metrics.data.BaseStatComposite getStats()>();	$r13 = virtualinvoke $r10.<org.apache.dubbo.metrics.data.BaseStatComposite: org.apache.dubbo.metrics.data.RtStatComposite getRtStatComposite()>();	$r12 = virtualinvoke r8.<org.apache.dubbo.metrics.model.key.MetricsKeyWrapper: java.lang.String getType()>();	virtualinvoke $r13.<org.apache.dubbo.metrics.data.RtStatComposite: void calcServiceKeyRt(java.lang.String,java.lang.Long,org.apache.dubbo.metrics.model.Metric)>($r12, r11, $r4);	return
;block_num 1
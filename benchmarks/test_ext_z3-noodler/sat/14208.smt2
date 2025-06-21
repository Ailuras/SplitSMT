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

(declare-sort var2733 0)
(declare-sort var1388 0)
(declare-sort var1032 0)
(declare-sort var2200 0)
(declare-sort var1622 0)
(declare-sort var1803 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1388_getMetadata/1968437424 (var1388) var1032)
(declare-fun var2200_toJson/-637920053 (var1622) String)
(declare-fun cast-from-var1032-to-var1622 (var1032) var1622)
(declare-fun var1803_calRevision/2060062488 (String) String)
(declare-fun lastMetadataRevision/-1558756437 (var2733) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var2733 var2733)
(declare-const null-var1388 var1388)
(declare-const var1369 var2733) ; Statement: r4 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var1369 null-var2733)))
(declare-const var667 var1388) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var667 null-var1388)))
(define-const var1701 var1032 (var1388_getMetadata/1968437424 var667)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var869 String (var2200_toJson/-637920053 (cast-from-var1032-to-var1622 var1701))) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.String toJson(java.lang.Object)>($r1) 
(define-const var3735 String (var1803_calRevision/2060062488 var869)) ; Statement: r3 = staticinvoke <org.apache.dubbo.metadata.RevisionResolver: java.lang.String calRevision(java.lang.String)>(r2) 
(define-const var2030 String (lastMetadataRevision/-1558756437 var1369)) ; Statement: $r5 = r4.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.lang.String lastMetadataRevision> 
(assert true)
(define-const var1744 Bool (equalsIgnoreCase/-92311102 var3735 var2030)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r5) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var1744 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {var1388_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var2200_toJson/-637920053=([java.lang.Object], java.lang.String), cast-from-var1032-to-var1622=([java.util.Map], java.lang.Object), var1803_calRevision/2060062488=([java.lang.String], java.lang.String), lastMetadataRevision/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var2733=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var1369=r4, var1388=org.apache.dubbo.registry.client.ServiceInstance, var667=r0, var1032=java.util.Map, var1701=$r1, var2200=org.apache.dubbo.common.utils.JsonUtils, var1622=java.lang.Object, var869=r2, var1803=org.apache.dubbo.metadata.RevisionResolver, var3735=r3, var2030=$r5, var1744=$z0}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var2733, r4=var1369, org.apache.dubbo.registry.client.ServiceInstance=var1388, r0=var667, java.util.Map=var1032, $r1=var1701, org.apache.dubbo.common.utils.JsonUtils=var2200, java.lang.Object=var1622, r2=var869, org.apache.dubbo.metadata.RevisionResolver=var1803, r3=var3735, $r5=var2030, $z0=var1744}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	$r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	r2 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.String toJson(java.lang.Object)>($r1);	r3 = staticinvoke <org.apache.dubbo.metadata.RevisionResolver: java.lang.String calRevision(java.lang.String)>(r2);	$r5 = r4.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.lang.String lastMetadataRevision>;	$z0 = virtualinvoke r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r5);	if $z0 != 0 goto return;	return
;block_num 2
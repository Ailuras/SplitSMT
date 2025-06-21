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

(declare-sort var188 0)
(declare-sort var2161 0)
(declare-sort var2883 0)
(declare-sort var2272 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var188_getMetadata/1968437424 (var188) var2161)
(declare-fun var2161_get/1088891777 (var2161 var2883) var2883)
(declare-fun cast-from-String-to-var2883 (String) var2883)
(declare-fun cast-from-var2883-to-String (var2883) String)
(declare-fun var2272_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var188 var188)
(declare-const var3851 var188) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var3851 null-var188)))
(define-const var1945 var2161 (var188_getMetadata/1968437424 var3851)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var1381 var2883 (var2161_get/1088891777 var1945 (cast-from-String-to-var2883 "dubbo.endpoints"))) ; Statement: $r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.endpoints") 
(define-const var2960 String (cast-from-var2883-to-String var1381)) ; Statement: $r3 = (java.lang.String) $r2 
(define-const var3632 Bool (var2272_isNotEmpty/-1251449450 var2960)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3) 
 ; Statement: return $z0 
(check-sat)
; {var188_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var2161_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2883=([java.lang.String], java.lang.Object), cast-from-var2883-to-String=([java.lang.Object], java.lang.String), var2272_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var188=org.apache.dubbo.registry.client.ServiceInstance, var3851=r0, var2161=java.util.Map, var1945=$r1, var2883=java.lang.Object, var1381=$r2, var2960=$r3, var2272=org.apache.dubbo.common.utils.StringUtils, var3632=$z0}
; {org.apache.dubbo.registry.client.ServiceInstance=var188, r0=var3851, java.util.Map=var2161, $r1=var1945, java.lang.Object=var2883, $r2=var1381, $r3=var2960, org.apache.dubbo.common.utils.StringUtils=var2272, $z0=var3632}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	$r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.endpoints");	$r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3);	return $z0
;block_num 1
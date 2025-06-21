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

(declare-sort var3835 0)
(declare-sort var549 0)
(declare-sort var578 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var549_getOrDefault/-573460120 (var549 var578 var578) var578)
(declare-fun cast-from-String-to-var578 (String) var578)
(declare-fun var549_put/1464166817 (var549 var578 var578) var578)
(declare-const null-var3835 var3835)
(declare-const null-var549 var549)
(declare-const var1419 var3835) ; Statement: r3 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var1419 null-var3835)))
(declare-const var87 var549) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var87 null-var549)))
(define-const var3426 String "true") ; Statement: $r2 = "true" 
(define-const var2407 var578 (var549_getOrDefault/-573460120 var87 (cast-from-String-to-var578 "mesh-enable") (cast-from-String-to-var578 "false"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object getOrDefault(java.lang.Object,java.lang.Object)>("mesh-enable", "false") 
(assert true)
(define-const var3554 Bool false) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(assert (not (not (= (ite var3554 1 0) 0)))) ; Negate: Cond: $z0 != 0  
;(assert (var549_put/1464166817 var87 (cast-from-String-to-var578 "unloadClusterRelated") (cast-from-String-to-var578 "false"))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("unloadClusterRelated", "false") 

(declare-const var87!1 var549)
(declare-const var1242 String)
(declare-const var2149 String)
 ; Statement: return 0 
(check-sat)
; {var549_getOrDefault/-573460120=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var578=([java.lang.String], java.lang.Object), var549_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object)}
; {var3835=org.apache.dubbo.config.ReferenceConfig, var1419=r3, var549=java.util.Map, var87=r0, var3426=$r2, var578=java.lang.Object, var2407=$r1, var3554=$z0, var1242="unloadClusterRelated", var2149="false"}
; {org.apache.dubbo.config.ReferenceConfig=var3835, r3=var1419, java.util.Map=var549, r0=var87, $r2=var3426, java.lang.Object=var578, $r1=var2407, $z0=var3554, "unloadClusterRelated"=var1242, "false"=var2149}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.config.ReferenceConfig;	r0 := @parameter0: java.util.Map;	$r2 = "true";	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object getOrDefault(java.lang.Object,java.lang.Object)>("mesh-enable", "false");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("unloadClusterRelated", "false");	return 0
;block_num 2
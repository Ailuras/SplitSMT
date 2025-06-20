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

(declare-sort var143 0)
(declare-sort var1149 0)
(declare-sort var3313 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1149_isEmptyMap/212689853 (var143) Bool)
(declare-fun var143_get/1088891777 (var143 var3313) var3313)
(declare-fun cast-from-String-to-var3313 (String) var3313)
(declare-const null-var143 var143)
(declare-const var969 var143) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var969 null-var143)))
(define-const var1351 Bool (var1149_isEmptyMap/212689853 var969)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmptyMap(java.util.Map)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "service" 
(assert (= (ite var1351 1 0) 0)) ; Cond: $z0 == 0 
(define-const var926 String "service") ; Statement: $r2 = "service" 
(define-const var39 var3313 (var143_get/1088891777 var969 (cast-from-String-to-var3313 "registry-type"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry-type") 
(assert true)
(define-const var2172 Bool false) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: return $z1 
(check-sat)
; {var1149_isEmptyMap/212689853=([java.util.Map], boolean), var143_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3313=([java.lang.String], java.lang.Object)}
; {var143=java.util.Map, var969=r0, var1149=org.apache.dubbo.common.utils.CollectionUtils, var1351=$z0, var926=$r2, var3313=java.lang.Object, var39=$r1, var2172=$z1}
; {java.util.Map=var143, r0=var969, org.apache.dubbo.common.utils.CollectionUtils=var1149, $z0=var1351, $r2=var926, java.lang.Object=var3313, $r1=var39, $z1=var2172}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.util.Map;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmptyMap(java.util.Map)>(r0);	if $z0 == 0 goto $r2 = "service";	$r2 = "service";	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry-type");	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	return $z1
;block_num 2
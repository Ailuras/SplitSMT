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
    (str.split_end x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1815 0)
(declare-sort var1976 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var1815 var1815)
(declare-const null-String String)
(declare-const var856 var1815) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var856 null-var1815)))
(declare-const var3010 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3010 null-String)))
(define-const var2118 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var3020 = var3010.split(":", var2118) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2) 
(define-const var1498 Int (get_split_length var3010 ":" var2118)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 != 4 goto $z0 = 0 
(assert (not (= var1498 4))) ; Cond: $i0 != 4 
(define-const var3279 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; (get-model)
; (get-unsat-core)
; {cast-from-Int-to-Int=([int], int)}
; {var1815=org.apache.dubbo.registry.nacos.NacosRegistry, var856=r2, var3010=r0, var1976=null_type, var2118=$i2, var3020=$r1, var1498=$i0, var3279=$z0}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var1815, r2=var856, r0=var3010, null_type=var1976, $i2=var2118, $r1=var3020, $i0=var1498, $z0=var3279}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: java.lang.String;	$i2 = (int) -1;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2);	$i0 = lengthof $r1;	if $i0 != 4 goto $z0 = 0;	$z0 = 0;	return $z0
;block_num 3
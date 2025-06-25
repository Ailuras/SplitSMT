(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1244 0)
(declare-sort var2295 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var1244 var1244)
(declare-const null-String String)
(declare-const var3556 var1244) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var3556 null-var1244)))
(declare-const var3319 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3319 null-String)))
(define-const var2348 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var2222 = var3319.split(":", var2348) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2) 
(define-const var1705 Int (get_split_length var3319 ":" var2348)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 != 4 goto $z0 = 0 
(assert (not (= var1705 4))) ; Cond: $i0 != 4 
(define-const var1841 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var1244=org.apache.dubbo.registry.nacos.NacosRegistry, var3556=r2, var3319=r0, var2295=null_type, var2348=$i2, var2222=$r1, var1705=$i0, var1841=$z0}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var1244, r2=var3556, r0=var3319, null_type=var2295, $i2=var2348, $r1=var2222, $i0=var1705, $z0=var1841}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: java.lang.String;	$i2 = (int) -1;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2);	$i0 = lengthof $r1;	if $i0 != 4 goto $z0 = 0;	$z0 = 0;	return $z0
;block_num 3
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

(declare-sort var3941 0)
(declare-sort var3050 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var3941 var3941)
(declare-const null-String String)
(declare-const var2699 var3941) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2699 null-var3941)))
(declare-const var3496 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3496 null-String)))
(define-const var3056 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var1596 = var3496.split(":", var3056) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2) 
(define-const var503 Int (get_split_length var3496 ":" var3056)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 != 4 goto $z0 = 0 
(assert (not (not (= var503 4)))) ; Negate: Cond: $i0 != 4  
(define-const var939 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= return $z0] 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var3941=org.apache.dubbo.registry.nacos.NacosRegistry, var2699=r2, var3496=r0, var3050=null_type, var3056=$i2, var1596=$r1, var503=$i0, var939=$z0}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var3941, r2=var2699, r0=var3496, null_type=var3050, $i2=var3056, $r1=var1596, $i0=var503, $z0=var939}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: java.lang.String;	$i2 = (int) -1;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2);	$i0 = lengthof $r1;	if $i0 != 4 goto $z0 = 0;	$z0 = 1;	goto [?= return $z0];	return $z0
;block_num 3
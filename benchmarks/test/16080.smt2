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

(declare-sort var2472 0)
(declare-sort var381 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var2472 var2472)
(declare-const null-String String)
(declare-const var3422 var2472) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var3422 null-var2472)))
(declare-const var1065 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1065 null-String)))
(define-const var3150 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var245 = var1065.split(":", var3150) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2) 
(define-const var3455 Int (get_split_length var1065 ":" var3150)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 != 4 goto $z0 = 0 
(assert (not (not (= var3455 4)))) ; Negate: Cond: $i0 != 4  
(define-const var671 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= return $z0] 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var2472=org.apache.dubbo.registry.nacos.NacosRegistry, var3422=r2, var1065=r0, var381=null_type, var3150=$i2, var245=$r1, var3455=$i0, var671=$z0}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var2472, r2=var3422, r0=var1065, null_type=var381, $i2=var3150, $r1=var245, $i0=var3455, $z0=var671}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: java.lang.String;	$i2 = (int) -1;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2);	$i0 = lengthof $r1;	if $i0 != 4 goto $z0 = 0;	$z0 = 1;	goto [?= return $z0];	return $z0
;block_num 3
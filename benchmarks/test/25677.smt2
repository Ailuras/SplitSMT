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

(declare-sort var153 0)
(declare-sort var3913 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var153 var153)
(declare-const null-String String)
(declare-const var2716 var153) ; Statement: r5 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.ContentNegotiator 
(assert (not (= var2716 null-var153)))
(declare-const var1267 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1267 null-String)))
(assert true)
(define-const var360 Int (indexOf/-1037706067 var1267 47)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(47) 
(define-const var1571 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
 ; Statement: if i0 == $i7 goto return null 
(assert (= var360 var1571)) ; Cond: i0 == $i7 
 ; Statement: return null 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int)}
; {var153=org.apache.dubbo.rpc.protocol.tri.rest.mapping.ContentNegotiator, var2716=r5, var1267=r0, var3913=null_type, var360=i0, var1571=$i7}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.ContentNegotiator=var153, r5=var2716, r0=var1267, null_type=var3913, i0=var360, $i7=var1571}
;seq <java.lang.String: int indexOf(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 1}
;stmts r5 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.ContentNegotiator;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(47);	$i7 = (int) -1;	if i0 == $i7 goto return null;	return null
;block_num 2
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

(declare-sort var3062 0)
(declare-sort var861 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-fun var861_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var3163 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var3163 null-String)))
(assert true)
(define-const var3812 Int (indexOf/-1037706067 var3163 33)) ; Statement: $i0 = virtualinvoke r7.<java.lang.String: int indexOf(int)>(33) 
 ; Statement: if $i0 != 0 goto z4 = 0 
(assert (not (= var3812 0))) ; Cond: $i0 != 0 
(define-const var2006 Bool (ite (= 1 0) true false)) ; Statement: z4 = 0 
(assert true) ; Non Conditional
(define-const var1453 Bool (var861_isEmpty/-813097145 var3163)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7) 
 ; Statement: if $z0 == 0 goto i1 = virtualinvoke r7.<java.lang.String: int indexOf(int)>(59) 
(assert (not (= (ite var1453 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), var861_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3163=r7, var3062=null_type, var3812=$i0, var2006=z4, var861=org.apache.dubbo.common.utils.StringUtils, var1453=$z0}
; {r7=var3163, null_type=var3062, $i0=var3812, z4=var2006, org.apache.dubbo.common.utils.StringUtils=var861, $z0=var1453}
;seq <java.lang.String: int indexOf(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r7 := @parameter0: java.lang.String;	$i0 = virtualinvoke r7.<java.lang.String: int indexOf(int)>(33);	if $i0 != 0 goto z4 = 0;	z4 = 0;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r7);	if $z0 == 0 goto i1 = virtualinvoke r7.<java.lang.String: int indexOf(int)>(59);	return null
;block_num 4
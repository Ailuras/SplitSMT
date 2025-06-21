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

(declare-sort var271 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-const null-String String)
(declare-const var3801 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3801 null-String)))
(assert true)
(define-const var21 Int (lastIndexOf/-1292097097 var3801 47)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47) 
 ; Statement: if i0 >= 1 goto r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, i0) 
(assert (not (>= var21 1))) ; Negate: Cond: i0 >= 1  
 ; Statement: return null 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int)}
; {var3801=r0, var271=null_type, var21=i0}
; {r0=var3801, null_type=var271, i0=var21}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47);	if i0 >= 1 goto r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, i0);	return null
;block_num 2
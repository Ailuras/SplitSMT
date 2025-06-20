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

(declare-sort var1310 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var1248 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1248 null-String)))
(define-const var1028 Int 0) ; Statement: i5 = 0 
; split operation: var1254 = var1248.split("\u005c.") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var1429 Int (get_split_length var1248 "\u005c." -1)) ; Statement: i0 = lengthof r1 
(define-const var142 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
 ; Statement: if i6 >= i0 goto return i5 
(assert (>= var142 var1429)) ; Cond: i6 >= i0 
 ; Statement: return i5 
(check-sat)
; {}
; {var1248=r0, var1310=null_type, var1028=i5, var1254=r1, var1429=i0, var142=i6}
; {r0=var1248, null_type=var1310, i5=var1028, r1=var1254, i0=var1429, i6=var142}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i5 = 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	i0 = lengthof r1;	i6 = 0;	if i6 >= i0 goto return i5;	return i5
;block_num 3
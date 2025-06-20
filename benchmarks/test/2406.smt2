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

(declare-sort var28 0)
(declare-sort var51 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var28 var28)
(declare-const null-String String)
(declare-const var80 var28) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.model.FrameworkModel 
(assert (not (= var80 null-var28)))
(declare-const var123 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var123 null-String)))
 ; Statement: if r0 == null goto return 
(assert (not (= var123 null-String))) ; Negate: Cond: r0 == null  
(assert true)
(define-const var2483 Int (length/-134980193 var123)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto return 
(assert (<= var2483 0)) ; Cond: $i0 <= 0 
 ; Statement: return 
(check-sat)
; {length/-134980193=([java.lang.String], int)}
; {var28=org.apache.dubbo.rpc.model.FrameworkModel, var80=r1, var123=r0, var51=null_type, var2483=$i0}
; {org.apache.dubbo.rpc.model.FrameworkModel=var28, r1=var80, r0=var123, null_type=var51, $i0=var2483}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.rpc.model.FrameworkModel;	r0 := @parameter1: java.lang.String;	if r0 == null goto return;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 <= 0 goto return;	return
;block_num 3
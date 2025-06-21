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

(declare-sort var2466 0)
(declare-sort var242 0)
(declare-sort var2126 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var2126_emptyMap/401053835 () var242)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3572 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3572 null-String)))
(declare-const var117 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var117 null-Int)))
(assert true)
(define-const var2643 Int (length/-134980193 var3572)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if i1 < i0 goto $r1 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF> 
(assert (not (< var117 var2643))) ; Negate: Cond: i1 < i0  
(define-const var1578 var242 var2126_emptyMap/401053835) ; Statement: $r12 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>() 
 ; Statement: return $r12 
(check-sat)
; {length/-134980193=([java.lang.String], int), var2126_emptyMap/401053835=([], java.util.Map)}
; {var3572=r0, var2466=null_type, var117=i1, var2643=i0, var242=java.util.Map, var2126=java.util.Collections, var1578=$r12}
; {r0=var3572, null_type=var2466, i1=var117, i0=var2643, java.util.Map=var242, java.util.Collections=var2126, $r12=var1578}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	i1 := @parameter1: int;	i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i1 < i0 goto $r1 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF>;	$r12 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>();	return $r12
;block_num 2
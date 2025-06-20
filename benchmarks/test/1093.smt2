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

(declare-sort var2002 0)
(declare-sort var1988 0)
(declare-sort var1952 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var1952_emptyMap/401053835 () var1988)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2375 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2375 null-String)))
(declare-const var179 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var179 null-Int)))
(assert true)
(define-const var2727 Int (length/-134980193 var2375)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if i1 < i0 goto $r1 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF> 
(assert (not (< var179 var2727))) ; Negate: Cond: i1 < i0  
(define-const var3825 var1988 var1952_emptyMap/401053835) ; Statement: $r5 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>() 
 ; Statement: return $r5 
(check-sat)
; {length/-134980193=([java.lang.String], int), var1952_emptyMap/401053835=([], java.util.Map)}
; {var2375=r0, var2002=null_type, var179=i1, var2727=i0, var1988=java.util.Map, var1952=java.util.Collections, var3825=$r5}
; {r0=var2375, null_type=var2002, i1=var179, i0=var2727, java.util.Map=var1988, java.util.Collections=var1952, $r5=var3825}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	i1 := @parameter1: int;	i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i1 < i0 goto $r1 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF>;	$r5 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>();	return $r5
;block_num 2
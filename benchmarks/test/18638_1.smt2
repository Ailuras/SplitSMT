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

(declare-sort var218 0)
(declare-sort var2841 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun append/1560614132 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-String String)
(declare-const null-var218 var218)
(declare-const null-var2841 var2841)
(declare-const var2547 String) ; Statement: r2 := @parameter0: java.lang.StringBuffer 
(assert (not (= var2547 null-String)))
(declare-const var1887 var218) ; Statement: r0 := @parameter1: java.lang.Object 
(assert (not (= var1887 null-var218)))
(declare-const var1694 var2841) ; Statement: r3 := @parameter2: java.util.Map 
(assert (not (= var1694 null-var2841)))
 ; Statement: if r0 != null goto $r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert (not (not (= var1887 null-var218)))) ; Negate: Cond: r0 != null  
(assert true)
;(assert (append/1560614132 var2547 "null")) ; Statement: virtualinvoke r2.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("null") 
(declare-const var2547!1 String)
(assert (str.prefixof var2547 var2547!1))
 ; Statement: return 
(check-sat)
; {append/1560614132=([java.lang.StringBuffer, java.lang.String], java.lang.StringBuffer)}
; {var2547=r2, var218=java.lang.Object, var1887=r0, var2841=java.util.Map, var1694=r3}
; {r2=var2547, java.lang.Object=var218, r0=var1887, java.util.Map=var2841, r3=var1694}
;seq <java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>
;cnt {"<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>": 1}
;stmts r2 := @parameter0: java.lang.StringBuffer;	r0 := @parameter1: java.lang.Object;	r3 := @parameter2: java.util.Map;	if r0 != null goto $r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	virtualinvoke r2.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("null");	return
;block_num 2
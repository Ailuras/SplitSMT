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

(declare-sort var3274 0)
(declare-sort var1907 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-String String)
(declare-const null-var3274 var3274)
(declare-const null-var1907 var1907)
(declare-const var1973 String) ; Statement: r2 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1973 null-String)))
(declare-const var1949 var3274) ; Statement: r0 := @parameter1: java.lang.Object 
(assert (not (= var1949 null-var3274)))
(declare-const var3649 var1907) ; Statement: r3 := @parameter2: java.util.Map 
(assert (not (= var3649 null-var1907)))
 ; Statement: if r0 != null goto $r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert (not (not (= var1949 null-var3274)))) ; Negate: Cond: r0 != null  
(assert true)
;(assert (append/672562846 var1973 "null")) ; Statement: virtualinvoke r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("null") 
(declare-const var1973!1 String)
(assert (= var1973!1 (str.++ var1973 "null")))
 ; Statement: return 
(check-sat)
; {append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var1973=r2, var3274=java.lang.Object, var1949=r0, var1907=java.util.Map, var3649=r3}
; {r2=var1973, java.lang.Object=var3274, r0=var1949, java.util.Map=var1907, r3=var3649}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r2 := @parameter0: java.lang.StringBuilder;	r0 := @parameter1: java.lang.Object;	r3 := @parameter2: java.util.Map;	if r0 != null goto $r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	virtualinvoke r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("null");	return
;block_num 2
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

(declare-sort var907 0)
(declare-sort var2441 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getIntervals/202183075 (var907) var2441)
(declare-fun var2441_iterator/-912451715 (var2441) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var907 var907)
(declare-const var443 var907) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.misc.IntervalSet 
(assert (not (= var443 null-var907)))
(define-const var699 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var699)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var699!1 String)
(assert (= var699!1 ""))
(assert true)
(define-const var3763 var2441 (getIntervals/202183075 var443)) ; Statement: $r2 = virtualinvoke r1.<org.antlr.v4.runtime.misc.IntervalSet: java.util.List getIntervals()>() 
(define-const var736 Iterator (var2441_iterator/-912451715 var3763)) ; Statement: r3 = interfaceinvoke $r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1516 Bool (Iterator_hasNext/-1669924200 var736)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var1516 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3025 String (toString/-2075883882 var699!1)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getIntervals/202183075=([org.antlr.v4.runtime.misc.IntervalSet], java.util.List), var2441_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var907=org.antlr.v4.runtime.misc.IntervalSet, var443=r1, var699=$r0, var2441=java.util.List, var3763=$r2, var736=r3, var1516=$z0, var3025=$r4}
; {org.antlr.v4.runtime.misc.IntervalSet=var907, r1=var443, $r0=var699, java.util.List=var2441, $r2=var3763, r3=var736, $z0=var1516, $r4=var3025}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: org.antlr.v4.runtime.misc.IntervalSet;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.antlr.v4.runtime.misc.IntervalSet: java.util.List getIntervals()>();	r3 = interfaceinvoke $r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3
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

(declare-sort var3348 0)
(declare-sort var117 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun items/2106485160 (var3348) var117)
(declare-fun var117_iterator/-912451715 (var117) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3348 var3348)
(declare-const var2472 var3348) ; Statement: r1 := @this: org.apache.dubbo.qos.textui.TLadder 
(assert (not (= var2472 null-var3348)))
(define-const var50 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var50)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var50!1 String)
(assert (= var50!1 ""))
(define-const var2648 Int 0) ; Statement: i1 = 0 
(define-const var3482 var117 (items/2106485160 var2472)) ; Statement: $r2 = r1.<org.apache.dubbo.qos.textui.TLadder: java.util.List items> 
(define-const var3662 Iterator (var117_iterator/-912451715 var3482)) ; Statement: r3 = interfaceinvoke $r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1195 Bool (Iterator_hasNext/-1669924200 var3662)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var1195 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3931 String (toString/-2075883882 var50!1)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), items/2106485160=([org.apache.dubbo.qos.textui.TLadder], java.util.List), var117_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3348=org.apache.dubbo.qos.textui.TLadder, var2472=r1, var50=$r0, var2648=i1, var117=java.util.List, var3482=$r2, var3662=r3, var1195=$z0, var3931=$r4}
; {org.apache.dubbo.qos.textui.TLadder=var3348, r1=var2472, $r0=var50, i1=var2648, java.util.List=var117, $r2=var3482, r3=var3662, $z0=var1195, $r4=var3931}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.qos.textui.TLadder;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	i1 = 0;	$r2 = r1.<org.apache.dubbo.qos.textui.TLadder: java.util.List items>;	r3 = interfaceinvoke $r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3
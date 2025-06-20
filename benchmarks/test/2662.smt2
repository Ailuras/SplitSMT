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

(declare-sort var37 0)
(declare-sort var3002 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var37_iterator/-1617794947 (var37) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var37 var37)
(declare-const null-String String)
(declare-const var3583 var37) ; Statement: r0 := @parameter0: java.util.Collection 
(assert (not (= var3583 null-var37)))
(declare-const var261 String) ; Statement: r7 := @parameter1: java.lang.String 
(assert (not (= var261 null-String)))
(assert true)
(define-const var3812 Bool (endsWith/985337093 var261 ".")) ; Statement: $z0 = virtualinvoke r7.<java.lang.String: boolean endsWith(java.lang.String)>(".") 
 ; Statement: if $z0 != 0 goto $r6 = interfaceinvoke r0.<java.util.Collection: java.util.Iterator iterator()>() 
(assert (not (= (ite var3812 1 0) 0))) ; Cond: $z0 != 0 
(define-const var744 Iterator (var37_iterator/-1617794947 var3583)) ; Statement: $r6 = interfaceinvoke r0.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1708 Bool (Iterator_hasNext/-1669924200 var744)) ; Statement: $z2 = interfaceinvoke $r6.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z2 == 0 goto return 0 
(assert (= (ite var1708 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return 0 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), var37_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var37=java.util.Collection, var3583=r0, var261=r7, var3002=null_type, var3812=$z0, var744=$r6, var1708=$z2}
; {java.util.Collection=var37, r0=var3583, r7=var261, null_type=var3002, $z0=var3812, $r6=var744, $z2=var1708}
;seq <java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Collection;	r7 := @parameter1: java.lang.String;	$z0 = virtualinvoke r7.<java.lang.String: boolean endsWith(java.lang.String)>(".");	if $z0 != 0 goto $r6 = interfaceinvoke r0.<java.util.Collection: java.util.Iterator iterator()>();	$r6 = interfaceinvoke r0.<java.util.Collection: java.util.Iterator iterator()>();	$z2 = interfaceinvoke $r6.<java.util.Iterator: boolean hasNext()>();	if $z2 == 0 goto return 0;	return 0
;block_num 4
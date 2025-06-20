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

(declare-sort var3293 0)
(declare-sort var1342 0)
(declare-sort var3756 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var3756-init () var3756)
(declare-fun <init>/-808729244 (var3756) void)
(declare-fun var3293_iterator/-1617794947 (var3293) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var3293 var3293)
(declare-const null-String String)
(declare-const var2403 var3293) ; Statement: r1 := @parameter0: java.util.Collection 
(assert (not (= var2403 null-var3293)))
(declare-const var2717 String) ; Statement: r17 := @parameter1: java.lang.String 
(assert (not (= var2717 null-String)))
(assert true)
(define-const var190 Bool (endsWith/985337093 var2717 ".")) ; Statement: $z0 = virtualinvoke r17.<java.lang.String: boolean endsWith(java.lang.String)>(".") 
 ; Statement: if $z0 != 0 goto $r0 = new java.util.LinkedHashSet 
(assert (not (= (ite var190 1 0) 0))) ; Cond: $z0 != 0 
(define-const var156 var3756 var3756-init) ; Statement: $r0 = new java.util.LinkedHashSet 
(assert true)
;(assert (<init>/-808729244 var156)) ; Statement: specialinvoke $r0.<java.util.LinkedHashSet: void <init>()>() 

(declare-const var156!1 var3756)
(define-const var3026 Iterator (var3293_iterator/-1617794947 var2403)) ; Statement: $r15 = interfaceinvoke r1.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2643 Bool (Iterator_hasNext/-1669924200 var3026)) ; Statement: $z4 = interfaceinvoke $r15.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z4 == 0 goto return $r0 
(assert (= (ite var2643 1 0) 0)) ; Cond: $z4 == 0 
 ; Statement: return $r0 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), var3756-init=([], java.util.LinkedHashSet), <init>/-808729244=([java.util.LinkedHashSet], void), var3293_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var3293=java.util.Collection, var2403=r1, var2717=r17, var1342=null_type, var190=$z0, var3756=java.util.LinkedHashSet, var156=$r0, var3026=$r15, var2643=$z4}
; {java.util.Collection=var3293, r1=var2403, r17=var2717, null_type=var1342, $z0=var190, java.util.LinkedHashSet=var3756, $r0=var156, $r15=var3026, $z4=var2643}
;seq <java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.util.Collection;	r17 := @parameter1: java.lang.String;	$z0 = virtualinvoke r17.<java.lang.String: boolean endsWith(java.lang.String)>(".");	if $z0 != 0 goto $r0 = new java.util.LinkedHashSet;	$r0 = new java.util.LinkedHashSet;	specialinvoke $r0.<java.util.LinkedHashSet: void <init>()>();	$r15 = interfaceinvoke r1.<java.util.Collection: java.util.Iterator iterator()>();	$z4 = interfaceinvoke $r15.<java.util.Iterator: boolean hasNext()>();	if $z4 == 0 goto return $r0;	return $r0
;block_num 4
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

(declare-sort var293 0)
(declare-sort var3476 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var293_get/-1216255739 (var293 Int) var3476)
(declare-fun cast-from-var3476-to-var293 (var3476) var293)
(declare-fun var293_size/-959786421 (var293) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var293_iterator/-912451715 (var293) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var293 var293)
(declare-const var3392 var293) ; Statement: r0 := @parameter0: java.util.List 
(assert (not (= var3392 null-var293)))
(define-const var2116 var3476 (var293_get/-1216255739 var3392 0)) ; Statement: $r1 = interfaceinvoke r0.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var1884 var293 (cast-from-var3476-to-var293 var2116)) ; Statement: $r2 = (java.util.List) $r1 
(define-const var1441 Int (var293_size/-959786421 var1884)) ; Statement: $i0 = interfaceinvoke $r2.<java.util.List: int size()>() 
(define-const var3152 (Array Int Int) arr-Int-init) ; Statement: r3 = newarray (int)[$i0] 
(define-const var1128 Int 0) ; Statement: i11 = 0 
(assert true) ; Non Conditional
(define-const var577 Int (getLength-Arr-Int-1 var3152)) ; Statement: $i1 = lengthof r3 
 ; Statement: if i11 >= $i1 goto $r4 = new java.lang.StringBuilder 
(assert (>= var1128 var577)) ; Cond: i11 >= $i1 
(define-const var3635 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3635)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3635!1 String)
(assert (= var3635!1 ""))
(define-const var2669 Iterator (var293_iterator/-912451715 var3392)) ; Statement: r14 = interfaceinvoke r0.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2129 Bool (Iterator_hasNext/-1669924200 var2669)) ; Statement: $z0 = interfaceinvoke r14.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2129 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2484 String (toString/-2075883882 var3635!1)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {var293_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var3476-to-var293=([java.lang.Object], java.util.List), var293_size/-959786421=([java.util.List], int), arr-Int-init=([], int[]), getLength-Arr-Int-1=([int[]], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var293_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var293=java.util.List, var3392=r0, var3476=java.lang.Object, var2116=$r1, var1884=$r2, var1441=$i0, var3152=r3, var1128=i11, var577=$i1, var3635=$r4, var2669=r14, var2129=$z0, var2484=$r5}
; {java.util.List=var293, r0=var3392, java.lang.Object=var3476, $r1=var2116, $r2=var1884, $i0=var1441, r3=var3152, i11=var1128, $i1=var577, $r4=var3635, r14=var2669, $z0=var2129, $r5=var2484}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.util.List;	$r1 = interfaceinvoke r0.<java.util.List: java.lang.Object get(int)>(0);	$r2 = (java.util.List) $r1;	$i0 = interfaceinvoke $r2.<java.util.List: int size()>();	r3 = newarray (int)[$i0];	i11 = 0;	$i1 = lengthof r3;	if i11 >= $i1 goto $r4 = new java.lang.StringBuilder;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	r14 = interfaceinvoke r0.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r14.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 5
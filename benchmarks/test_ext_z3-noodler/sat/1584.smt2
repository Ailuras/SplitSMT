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

(declare-sort var143 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun isInterface/-352192428 (ClassObject) Bool)
(declare-fun var143-init () var143)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var143 String) void)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const var1161 (Array Int ClassObject)) ; Statement: r0 := @parameter0: java.lang.Class[] 
(assert (not (= var1161 null-__Array__Int__ClassObject__)))
(define-const var3242 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var155 Int (getLength-Arr-ClassObject-1 var1161)) ; Statement: $i0 = lengthof r0 
 ; Statement: if i1 >= $i0 goto return 
(assert (not (>= var3242 var155))) ; Negate: Cond: i1 >= $i0  
(define-const var3534 ClassObject (select var1161 var3242)) ; Statement: $r1 = r0[i1] 
(assert true)
(define-const var3436 Bool (isInterface/-352192428 var3534)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.Class: boolean isInterface()>() 
 ; Statement: if $z0 != 0 goto i1 = i1 + 1 
(assert (not (not (= (ite var3436 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1345 var143 var143-init) ; Statement: $r2 = new java.lang.RuntimeException 
(define-const var468 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var468)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var468!1 String)
(assert (= var468!1 ""))
(assert true)
(define-const var3947 String (append/672562846 var468!1 "Class ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Class ") 
(declare-const var468!2 String)
(assert (= var468!2 (str.++ var468!1 "Class ")))
(define-const var1907 ClassObject (select var1161 var3242)) ; Statement: $r4 = r0[i1] 
(assert true)
(define-const var1468 String (getName/-1958580599 var1907)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2016 String (append/672562846 var3947 var1468)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3947!1 String)
(assert (= var3947!1 (str.++ var3947 var1468)))
(assert true)
(define-const var3410 String (append/672562846 var2016 " is not a interface.")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is not a interface.") 
(declare-const var2016!1 String)
(assert (= var2016!1 (str.++ var2016 " is not a interface.")))
(assert true)
(define-const var3878 String (toString/-2075883882 var3410)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var1345 var3878)) ; Statement: specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r9) 

(declare-const var1345!1 var143)
(declare-const var3878!1 String)
 ; Statement: throw $r2 
(check-sat)
; {getLength-Arr-ClassObject-1=([java.lang.Class[]], int), isInterface/-352192428=([java.lang.Class], boolean), var143-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var1161=r0, var3242=i1, var155=$i0, var3534=$r1, var3436=$z0, var143=java.lang.RuntimeException, var1345=$r2, var468=$r3, var3947=$r6, var1907=$r4, var1468=$r5, var2016=$r7, var3410=$r8, var3878=$r9}
; {r0=var1161, i1=var3242, $i0=var155, $r1=var3534, $z0=var3436, java.lang.RuntimeException=var143, $r2=var1345, $r3=var468, $r6=var3947, $r4=var1907, $r5=var1468, $r7=var2016, $r8=var3410, $r9=var3878}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class[];	i1 = 0;	$i0 = lengthof r0;	if i1 >= $i0 goto return;	$r1 = r0[i1];	$z0 = virtualinvoke $r1.<java.lang.Class: boolean isInterface()>();	if $z0 != 0 goto i1 = i1 + 1;	$r2 = new java.lang.RuntimeException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Class ");	$r4 = r0[i1];	$r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is not a interface.");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r9);	throw $r2
;block_num 4
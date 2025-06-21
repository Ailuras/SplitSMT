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

(declare-sort var3917 0)
(declare-sort var190 0)
(declare-sort var3287 0)
(declare-sort var676 0)
(declare-sort var1684 0)
(declare-sort var1227 0)
(declare-sort var1685 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun var676-init () var676)
(declare-fun <init>/-325640736 (var676) void)
(declare-fun getConstructors/-1160885883 (ClassObject) (Array Int var190))
(declare-fun getLength-Arr-var190-1 ((Array Int var190)) Int)
(declare-fun var1684_size/-959786421 (var1684) Int)
(declare-fun cast-from-var676-to-var1684 (var676) var1684)
(declare-fun var1227-init () var1227)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun append/-1031950772 (String var1685) String)
(declare-fun cast-from-var676-to-var1685 (var676) var1685)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1227 String) void)
(declare-const null-var3917 var3917)
(declare-const null-ClassObject ClassObject)
(declare-const null-var190 var190)
(declare-const null-var3287 var3287)
(declare-const var3338 var3917) ; Statement: r10 := @this: org.apache.dubbo.common.beans.support.InstantiationStrategy 
(assert (not (= var3338 null-var3917)))
(declare-const var64 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var64 null-ClassObject)))
(define-const var1492 var190 null-var190) ; Statement: r28 = null 
(define-const var2869 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r1 = newarray (java.lang.Class)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var290 var3287) ; Statement: $r26 := @caughtexception 
(assert (not (= var290 null-var3287)))
(assert true) ; Non Conditional
(define-const var733 var676 var676-init) ; Statement: $r2 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var733)) ; Statement: specialinvoke $r2.<java.util.ArrayList: void <init>()>() 

(declare-const var733!1 var676)
(assert true)
(define-const var1823 (Array Int var190) (getConstructors/-1160885883 var64)) ; Statement: $r27 = virtualinvoke r0.<java.lang.Class: java.lang.reflect.Constructor[] getConstructors()>() 
(define-const var1702 Int (getLength-Arr-var190-1 var1823)) ; Statement: $i4 = lengthof $r27 
(define-const var1018 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
 ; Statement: if i5 >= $i4 goto (branch) 
(assert (>= var1018 var1702)) ; Cond: i5 >= $i4 
 ; Statement: if r28 == null goto $i0 = interfaceinvoke $r2.<java.util.List: int size()>() 
(assert (= var1492 null-var190)) ; Cond: r28 == null 
(define-const var2715 Int (var1684_size/-959786421 (cast-from-var676-to-var1684 var733!1))) ; Statement: $i0 = interfaceinvoke $r2.<java.util.List: int size()>() 
 ; Statement: if $i0 <= 1 goto $i1 = interfaceinvoke $r2.<java.util.List: int size()>() 
(assert (not (<= var2715 1))) ; Negate: Cond: $i0 <= 1  
(define-const var48 var1227 var1227-init) ; Statement: $r16 = new java.lang.IllegalArgumentException 
(define-const var2449 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2449)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2449!1 String)
(assert (= var2449!1 ""))
(assert true)
(define-const var303 String (append/672562846 var2449!1 "Expect only one but found ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Expect only one but found ") 
(declare-const var2449!2 String)
(assert (= var2449!2 (str.++ var2449!1 "Expect only one but found ")))
(define-const var1941 Int (var1684_size/-959786421 (cast-from-var676-to-var1684 var733!1))) ; Statement: $i3 = interfaceinvoke $r2.<java.util.List: int size()>() 
(assert true)
(define-const var583 String (append/-1001720160 var303 var1941)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i3) 
(declare-const var303!1 String)
(assert (str.prefixof var303 var303!1))
(assert true)
(define-const var856 String (append/672562846 var583 " matched constructors for type: ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" matched constructors for type: ") 
(declare-const var583!1 String)
(assert (= var583!1 (str.++ var583 " matched constructors for type: ")))
(assert true)
(define-const var1573 String (getName/-1958580599 var64)) ; Statement: $r20 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var542 String (append/672562846 var856 var1573)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20) 
(declare-const var856!1 String)
(assert (= var856!1 (str.++ var856 var1573)))
(assert true)
(define-const var880 String (append/672562846 var542 ", matched constructors: ")) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", matched constructors: ") 
(declare-const var542!1 String)
(assert (= var542!1 (str.++ var542 ", matched constructors: ")))
(assert true)
(define-const var3790 String (append/-1031950772 var880 (cast-from-var676-to-var1685 var733!1))) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var880!1 String)
(assert (str.prefixof var880 var880!1))
(assert true)
(define-const var1191 String (toString/-2075883882 var3790)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var48 var1191)) ; Statement: specialinvoke $r16.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r25) 

(declare-const var48!1 var1227)
(declare-const var1191!1 String)
 ; Statement: throw $r16 
(check-sat)
; {arr-ClassObject-init=([], java.lang.Class[]), var676-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), getConstructors/-1160885883=([java.lang.Class], java.lang.reflect.Constructor[]), getLength-Arr-var190-1=([java.lang.reflect.Constructor[]], int), var1684_size/-959786421=([java.util.List], int), cast-from-var676-to-var1684=([java.util.ArrayList], java.util.List), var1227-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var676-to-var1685=([java.util.ArrayList], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3917=org.apache.dubbo.common.beans.support.InstantiationStrategy, var3338=r10, var64=r0, var190=java.lang.reflect.Constructor, var1492=r28, var2869=$r1, var3287=java.lang.NoSuchMethodException, var290=$r26, var676=java.util.ArrayList, var733=$r2, var1823=$r27, var1702=$i4, var1018=i5, var1684=java.util.List, var2715=$i0, var1227=java.lang.IllegalArgumentException, var48=$r16, var2449=$r17, var303=$r18, var1941=$i3, var583=$r19, var856=$r21, var1573=$r20, var542=$r22, var880=$r23, var1685=java.lang.Object, var3790=$r24, var1191=$r25}
; {org.apache.dubbo.common.beans.support.InstantiationStrategy=var3917, r10=var3338, r0=var64, java.lang.reflect.Constructor=var190, r28=var1492, $r1=var2869, java.lang.NoSuchMethodException=var3287, $r26=var290, java.util.ArrayList=var676, $r2=var733, $r27=var1823, $i4=var1702, i5=var1018, java.util.List=var1684, $i0=var2715, java.lang.IllegalArgumentException=var1227, $r16=var48, $r17=var2449, $r18=var303, $i3=var1941, $r19=var583, $r21=var856, $r20=var1573, $r22=var542, $r23=var880, java.lang.Object=var1685, $r24=var3790, $r25=var1191}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.common.beans.support.InstantiationStrategy;	r0 := @parameter0: java.lang.Class;	r28 = null;	$r1 = newarray (java.lang.Class)[0];	$r26 := @caughtexception;	$r2 = new java.util.ArrayList;	specialinvoke $r2.<java.util.ArrayList: void <init>()>();	$r27 = virtualinvoke r0.<java.lang.Class: java.lang.reflect.Constructor[] getConstructors()>();	$i4 = lengthof $r27;	i5 = 0;	if i5 >= $i4 goto (branch);	if r28 == null goto $i0 = interfaceinvoke $r2.<java.util.List: int size()>();	$i0 = interfaceinvoke $r2.<java.util.List: int size()>();	if $i0 <= 1 goto $i1 = interfaceinvoke $r2.<java.util.List: int size()>();	$r16 = new java.lang.IllegalArgumentException;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Expect only one but found ");	$i3 = interfaceinvoke $r2.<java.util.List: int size()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i3);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" matched constructors for type: ");	$r20 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", matched constructors: ");	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r16.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r25);	throw $r16
;block_num 7
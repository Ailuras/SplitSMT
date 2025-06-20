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

(declare-sort var2432 0)
(declare-sort var679 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getName/1227988463 (var2432) String)
(declare-fun var679_toUpperMethodName/-1477839737 (String) String)
(declare-fun getParameterTypes/827748249 (var2432) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2432 var2432)
(declare-const var879 ClassObject) ; Statement: r1 := @parameter0: java.lang.Class 
(assert (not (= var879 null-ClassObject)))
(declare-const var14 var2432) ; Statement: r4 := @parameter1: java.lang.reflect.Method 
(assert (not (= var14 null-var2432)))
(define-const var1824 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1824)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1824!1 String)
(assert (= var1824!1 ""))
(assert true)
(define-const var1909 String (getName/-1958580599 var879)) ; Statement: $r2 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1297 String (append/672562846 var1824!1 var1909)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1824!2 String)
(assert (= var1824!2 (str.++ var1824!1 var1909)))
(assert true)
(define-const var953 String (append/-1166366385 var1297 95)) ; Statement: $r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(95) 
(declare-const var1297!1 String)
(assert (str.prefixof var1297 var1297!1))
(assert true)
(define-const var2043 String (getName/1227988463 var14)) ; Statement: $r5 = virtualinvoke r4.<java.lang.reflect.Method: java.lang.String getName()>() 
(define-const var2670 String (var679_toUpperMethodName/-1477839737 var2043)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.String toUpperMethodName(java.lang.String)>($r5) 
(assert true)
(define-const var563 String (append/672562846 var953 var2670)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var953!1 String)
(assert (= var953!1 (str.++ var953 var2670)))
(assert true)
(define-const var3102 String (append/672562846 var563 "Parameter")) ; Statement: r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Parameter") 
(declare-const var563!1 String)
(assert (= var563!1 (str.++ var563 "Parameter")))
(assert true)
(define-const var1469 (Array Int ClassObject) (getParameterTypes/827748249 var14)) ; Statement: r10 = virtualinvoke r4.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var2285 Int (getLength-Arr-ClassObject-1 var1469)) ; Statement: i0 = lengthof r10 
(define-const var801 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r11 = virtualinvoke r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var801 var2285)) ; Cond: i1 >= i0 
(assert true)
(define-const var1511 String (toString/-2075883882 var3102)) ; Statement: $r11 = virtualinvoke r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getName/1227988463=([java.lang.reflect.Method], java.lang.String), var679_toUpperMethodName/-1477839737=([java.lang.String], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var879=r1, var2432=java.lang.reflect.Method, var14=r4, var1824=$r0, var1909=$r2, var1297=$r3, var953=$r7, var2043=$r5, var679=org.apache.dubbo.validation.support.jvalidation.JValidator, var2670=$r6, var563=$r8, var3102=r9, var1469=r10, var2285=i0, var801=i1, var1511=$r11}
; {r1=var879, java.lang.reflect.Method=var2432, r4=var14, $r0=var1824, $r2=var1909, $r3=var1297, $r7=var953, $r5=var2043, org.apache.dubbo.validation.support.jvalidation.JValidator=var679, $r6=var2670, $r8=var563, r9=var3102, r10=var1469, i0=var2285, i1=var801, $r11=var1511}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.Class;	r4 := @parameter1: java.lang.reflect.Method;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(95);	$r5 = virtualinvoke r4.<java.lang.reflect.Method: java.lang.String getName()>();	$r6 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.String toUpperMethodName(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Parameter");	r10 = virtualinvoke r4.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	i0 = lengthof r10;	i1 = 0;	if i1 >= i0 goto $r11 = virtualinvoke r9.<java.lang.StringBuilder: java.lang.String toString()>();	$r11 = virtualinvoke r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 3
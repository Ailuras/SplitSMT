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

(declare-sort var2458 0)
(declare-sort var2877 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getName/1227988463 (var2458) String)
(declare-fun var2877_toUpperMethodName/555655841 (String) String)
(declare-fun getParameterTypes/827748249 (var2458) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2458 var2458)
(declare-const var380 ClassObject) ; Statement: r1 := @parameter0: java.lang.Class 
(assert (not (= var380 null-ClassObject)))
(declare-const var2571 var2458) ; Statement: r4 := @parameter1: java.lang.reflect.Method 
(assert (not (= var2571 null-var2458)))
(define-const var1629 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1629)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1629!1 String)
(assert (= var1629!1 ""))
(assert true)
(define-const var1867 String (getName/-1958580599 var380)) ; Statement: $r2 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2876 String (append/672562846 var1629!1 var1867)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1629!2 String)
(assert (= var1629!2 (str.++ var1629!1 var1867)))
(assert true)
(define-const var2070 String (append/-1166366385 var2876 95)) ; Statement: $r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(95) 
(declare-const var2876!1 String)
(assert (str.prefixof var2876 var2876!1))
(assert true)
(define-const var1283 String (getName/1227988463 var2571)) ; Statement: $r5 = virtualinvoke r4.<java.lang.reflect.Method: java.lang.String getName()>() 
(define-const var137 String (var2877_toUpperMethodName/555655841 var1283)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.String toUpperMethodName(java.lang.String)>($r5) 
(assert true)
(define-const var556 String (append/672562846 var2070 var137)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2070!1 String)
(assert (= var2070!1 (str.++ var2070 var137)))
(assert true)
(define-const var3074 String (append/672562846 var556 "Parameter")) ; Statement: r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Parameter") 
(declare-const var556!1 String)
(assert (= var556!1 (str.++ var556 "Parameter")))
(assert true)
(define-const var2880 (Array Int ClassObject) (getParameterTypes/827748249 var2571)) ; Statement: r10 = virtualinvoke r4.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var495 Int (getLength-Arr-ClassObject-1 var2880)) ; Statement: i0 = lengthof r10 
(define-const var3383 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r11 = virtualinvoke r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var3383 var495)) ; Cond: i1 >= i0 
(assert true)
(define-const var1861 String (toString/-2075883882 var3074)) ; Statement: $r11 = virtualinvoke r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getName/1227988463=([java.lang.reflect.Method], java.lang.String), var2877_toUpperMethodName/555655841=([java.lang.String], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var380=r1, var2458=java.lang.reflect.Method, var2571=r4, var1629=$r0, var1867=$r2, var2876=$r3, var2070=$r7, var1283=$r5, var2877=org.apache.dubbo.validation.support.jvalidation.JValidatorNew, var137=$r6, var556=$r8, var3074=r9, var2880=r10, var495=i0, var3383=i1, var1861=$r11}
; {r1=var380, java.lang.reflect.Method=var2458, r4=var2571, $r0=var1629, $r2=var1867, $r3=var2876, $r7=var2070, $r5=var1283, org.apache.dubbo.validation.support.jvalidation.JValidatorNew=var2877, $r6=var137, $r8=var556, r9=var3074, r10=var2880, i0=var495, i1=var3383, $r11=var1861}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.Class;	r4 := @parameter1: java.lang.reflect.Method;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(95);	$r5 = virtualinvoke r4.<java.lang.reflect.Method: java.lang.String getName()>();	$r6 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.String toUpperMethodName(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Parameter");	r10 = virtualinvoke r4.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	i0 = lengthof r10;	i1 = 0;	if i1 >= i0 goto $r11 = virtualinvoke r9.<java.lang.StringBuilder: java.lang.String toString()>();	$r11 = virtualinvoke r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 3
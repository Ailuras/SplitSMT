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

(declare-sort var3864 0)
(declare-sort var3470 0)
(declare-sort var1386 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun getParameterTypes/827748249 (var3864) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/1227988463 (var3864) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1386) String)
(declare-fun cast-from-String-to-var1386 (String) var1386)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3864 var3864)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-String String)
(declare-const var2654 var3864) ; Statement: r2 := @parameter0: java.lang.reflect.Method 
(assert (not (= var2654 null-var3864)))
(declare-const var3840 (Array Int ClassObject)) ; Statement: r4 := @parameter1: java.lang.Class[] 
(assert (not (= var3840 null-__Array__Int__ClassObject__)))
(declare-const var1484 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var1484 null-String)))
(define-const var1990 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var1990 var1484)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>(r1) 
(declare-const var1990!1 String)
(assert (= var1990!1 var1484))
(assert true)
(define-const var753 (Array Int ClassObject) (getParameterTypes/827748249 var2654)) ; Statement: $r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var1960 Int (getLength-Arr-ClassObject-1 var753)) ; Statement: $i1 = lengthof $r3 
(define-const var3879 Int (getLength-Arr-ClassObject-1 var3840)) ; Statement: $i0 = lengthof r4 
 ; Statement: if $i1 <= $i0 goto $r5 = new java.lang.StringBuilder 
(assert (<= var1960 var3879)) ; Cond: $i1 <= $i0 
(define-const var1635 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1635)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1635!1 String)
(assert (= var1635!1 ""))
(assert true)
(define-const var3032 String (getName/1227988463 var2654)) ; Statement: $r6 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var2656 String (append/672562846 var1635!1 var3032)) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1635!2 String)
(assert (= var1635!2 (str.++ var1635!1 var3032)))
(assert true)
(define-const var1303 String (append/672562846 var2656 "(")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(") 
(declare-const var2656!1 String)
(assert (= var2656!1 (str.++ var2656 "(")))
(assert true)
(define-const var1932 String (append/-1031950772 var1303 (cast-from-String-to-var1386 var1990!1))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r0) 
(declare-const var1303!1 String)
(assert (str.prefixof var1303 var1303!1))
(assert true)
(define-const var2814 String (append/672562846 var1932 ")")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")") 
(declare-const var1932!1 String)
(assert (= var1932!1 (str.++ var1932 ")")))
(assert true)
(define-const var150 String (toString/-2075883882 var2814)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), <init>/1968657023=([java.lang.StringBuilder], void), getName/1227988463=([java.lang.reflect.Method], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-String-to-var1386=([java.lang.StringBuilder], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3864=java.lang.reflect.Method, var2654=r2, var3840=r4, var1484=r1, var3470=null_type, var1990=$r0, var753=$r3, var1960=$i1, var3879=$i0, var1635=$r5, var3032=$r6, var2656=$r7, var1303=$r8, var1386=java.lang.Object, var1932=$r9, var2814=$r10, var150=$r11}
; {java.lang.reflect.Method=var3864, r2=var2654, r4=var3840, r1=var1484, null_type=var3470, $r0=var1990, $r3=var753, $i1=var1960, $i0=var3879, $r5=var1635, $r6=var3032, $r7=var2656, $r8=var1303, java.lang.Object=var1386, $r9=var1932, $r10=var2814, $r11=var150}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @parameter0: java.lang.reflect.Method;	r4 := @parameter1: java.lang.Class[];	r1 := @parameter2: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>(r1);	$r3 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$i1 = lengthof $r3;	$i0 = lengthof r4;	if $i1 <= $i0 goto $r5 = new java.lang.StringBuilder;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke r2.<java.lang.reflect.Method: java.lang.String getName()>();	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r0);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 2
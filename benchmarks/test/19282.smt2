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

(declare-sort var3275 0)
(declare-sort var1749 0)
(declare-sort var3501 0)
(declare-sort var3205 0)
(declare-sort var1256 0)
(declare-sort var1116 0)
(declare-sort var2248 0)
(declare-sort var308 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3205-init () var3205)
(declare-fun <init>/-325640736 (var3205) void)
(declare-fun getMethods/-297347657 (ClassObject) (Array Int var1256))
(declare-fun getLength-Arr-var1256-1 ((Array Int var1256)) Int)
(declare-fun var1116_isEmpty/-153543822 (var1116) Bool)
(declare-fun cast-from-var3205-to-var1116 (var3205) var1116)
(declare-fun var2248-init () var2248)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var308) String)
(declare-fun cast-from-ClassObject-to-var308 (ClassObject) var308)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-966825728 (var2248 String) void)
(declare-const null-var3275 var3275)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-var3501 var3501)
(declare-const var3862 var3275) ; Statement: r12 := @this: org.apache.dubbo.rpc.filter.GenericFilter 
(assert (not (= var3862 null-var3275)))
(declare-const var3340 ClassObject) ; Statement: r2 := @parameter0: java.lang.Class 
(assert (not (= var3340 null-ClassObject)))
(declare-const var2792 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2792 null-String)))
(declare-const var3598 (Array Int String)) ; Statement: r0 := @parameter2: java.lang.String[] 
(assert (not (= var3598 null-__Array__Int__String__)))
(declare-const var548 var3501) ; Statement: r1 := @parameter3: org.apache.dubbo.rpc.model.ServiceModel 
(assert (not (= var548 null-var3501)))
 ; Statement: if r0 != null goto $i0 = lengthof r0 
(assert (not (not (= var3598 null-__Array__Int__String__)))) ; Negate: Cond: r0 != null  
(define-const var2499 var3205 var3205-init) ; Statement: $r27 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2499)) ; Statement: specialinvoke $r27.<java.util.ArrayList: void <init>()>() 

(declare-const var2499!1 var3205)
(assert true)
(define-const var1958 (Array Int var1256) (getMethods/-297347657 var3340)) ; Statement: r42 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>() 
(define-const var81 Int (getLength-Arr-var1256-1 var1958)) ; Statement: i4 = lengthof r42 
(define-const var2376 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
 ; Statement: if i5 >= i4 goto $z0 = interfaceinvoke $r27.<java.util.List: boolean isEmpty()>() 
(assert (>= var2376 var81)) ; Cond: i5 >= i4 
(define-const var1601 Bool (var1116_isEmpty/-153543822 (cast-from-var3205-to-var1116 var2499!1))) ; Statement: $z0 = interfaceinvoke $r27.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $i2 = interfaceinvoke $r27.<java.util.List: int size()>() 
(assert (not (= (ite var1601 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1803 var2248 var2248-init) ; Statement: $r33 = new java.lang.NoSuchMethodException 
(define-const var1254 String String-init) ; Statement: $r34 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1254)) ; Statement: specialinvoke $r34.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1254!1 String)
(assert (= var1254!1 ""))
(assert true)
(define-const var1482 String (append/672562846 var1254!1 "No such method ")) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such method ") 
(declare-const var1254!2 String)
(assert (= var1254!2 (str.++ var1254!1 "No such method ")))
(assert true)
(define-const var1200 String (append/672562846 var1482 var2792)) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var1482!1 String)
(assert (= var1482!1 (str.++ var1482 var2792)))
(assert true)
(define-const var1949 String (append/672562846 var1200 " in class ")) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in class ") 
(declare-const var1200!1 String)
(assert (= var1200!1 (str.++ var1200 " in class ")))
(assert true)
(define-const var3587 String (append/-1031950772 var1949 (cast-from-ClassObject-to-var308 var3340))) ; Statement: $r38 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var1949!1 String)
(assert (str.prefixof var1949 var1949!1))
(assert true)
(define-const var1442 String (toString/-2075883882 var3587)) ; Statement: $r39 = virtualinvoke $r38.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-966825728 var1803 var1442)) ; Statement: specialinvoke $r33.<java.lang.NoSuchMethodException: void <init>(java.lang.String)>($r39) 

(declare-const var1803!1 var2248)
(declare-const var1442!1 String)
 ; Statement: throw $r33 
(check-sat)
; {var3205-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), getMethods/-297347657=([java.lang.Class], java.lang.reflect.Method[]), getLength-Arr-var1256-1=([java.lang.reflect.Method[]], int), var1116_isEmpty/-153543822=([java.util.List], boolean), cast-from-var3205-to-var1116=([java.util.ArrayList], java.util.List), var2248-init=([], java.lang.NoSuchMethodException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var308=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-966825728=([java.lang.NoSuchMethodException, java.lang.String], void)}
; {var3275=org.apache.dubbo.rpc.filter.GenericFilter, var3862=r12, var3340=r2, var2792=r3, var1749=null_type, var3598=r0, var3501=org.apache.dubbo.rpc.model.ServiceModel, var548=r1, var3205=java.util.ArrayList, var2499=$r27, var1256=java.lang.reflect.Method, var1958=r42, var81=i4, var2376=i5, var1116=java.util.List, var1601=$z0, var2248=java.lang.NoSuchMethodException, var1803=$r33, var1254=$r34, var1482=$r35, var1200=$r36, var1949=$r37, var308=java.lang.Object, var3587=$r38, var1442=$r39}
; {org.apache.dubbo.rpc.filter.GenericFilter=var3275, r12=var3862, r2=var3340, r3=var2792, null_type=var1749, r0=var3598, org.apache.dubbo.rpc.model.ServiceModel=var3501, r1=var548, java.util.ArrayList=var3205, $r27=var2499, java.lang.reflect.Method=var1256, r42=var1958, i4=var81, i5=var2376, java.util.List=var1116, $z0=var1601, java.lang.NoSuchMethodException=var2248, $r33=var1803, $r34=var1254, $r35=var1482, $r36=var1200, $r37=var1949, java.lang.Object=var308, $r38=var3587, $r39=var1442}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.filter.GenericFilter;	r2 := @parameter0: java.lang.Class;	r3 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.String[];	r1 := @parameter3: org.apache.dubbo.rpc.model.ServiceModel;	if r0 != null goto $i0 = lengthof r0;	$r27 = new java.util.ArrayList;	specialinvoke $r27.<java.util.ArrayList: void <init>()>();	r42 = virtualinvoke r2.<java.lang.Class: java.lang.reflect.Method[] getMethods()>();	i4 = lengthof r42;	i5 = 0;	if i5 >= i4 goto $z0 = interfaceinvoke $r27.<java.util.List: boolean isEmpty()>();	$z0 = interfaceinvoke $r27.<java.util.List: boolean isEmpty()>();	if $z0 == 0 goto $i2 = interfaceinvoke $r27.<java.util.List: int size()>();	$r33 = new java.lang.NoSuchMethodException;	$r34 = new java.lang.StringBuilder;	specialinvoke $r34.<java.lang.StringBuilder: void <init>()>();	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such method ");	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in class ");	$r38 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r39 = virtualinvoke $r38.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r33.<java.lang.NoSuchMethodException: void <init>(java.lang.String)>($r39);	throw $r33
;block_num 5
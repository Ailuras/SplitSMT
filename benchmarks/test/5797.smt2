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

(declare-sort var2543 0)
(declare-sort var814 0)
(declare-sort var3961 0)
(declare-sort var910 0)
(declare-sort var3189 0)
(declare-sort var743 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var814-init () var814)
(declare-fun <init>/-325640736 (var814) void)
(declare-fun getMethods/-297347657 (ClassObject) (Array Int var3961))
(declare-fun getLength-Arr-var3961-1 ((Array Int var3961)) Int)
(declare-fun var910_isEmpty/-153543822 (var910) Bool)
(declare-fun cast-from-var814-to-var910 (var814) var910)
(declare-fun var3189-init () var3189)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var743) String)
(declare-fun cast-from-ClassObject-to-var743 (ClassObject) var743)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-966825728 (var3189 String) void)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1463 ClassObject) ; Statement: r1 := @parameter0: java.lang.Class 
(assert (not (= var1463 null-ClassObject)))
(declare-const var1887 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1887 null-String)))
(declare-const var407 (Array Int String)) ; Statement: r0 := @parameter2: java.lang.String[] 
(assert (not (= var407 null-__Array__Int__String__)))
 ; Statement: if r0 != null goto $i0 = lengthof r0 
(assert (not (not (= var407 null-__Array__Int__String__)))) ; Negate: Cond: r0 != null  
(define-const var3614 var814 var814-init) ; Statement: $r5 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3614)) ; Statement: specialinvoke $r5.<java.util.ArrayList: void <init>()>() 

(declare-const var3614!1 var814)
(assert true)
(define-const var334 (Array Int var3961) (getMethods/-297347657 var1463)) ; Statement: r20 = virtualinvoke r1.<java.lang.Class: java.lang.reflect.Method[] getMethods()>() 
(define-const var901 Int (getLength-Arr-var3961-1 var334)) ; Statement: i2 = lengthof r20 
(define-const var313 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
 ; Statement: if i5 >= i2 goto $z0 = interfaceinvoke $r5.<java.util.List: boolean isEmpty()>() 
(assert (>= var313 var901)) ; Cond: i5 >= i2 
(define-const var854 Bool (var910_isEmpty/-153543822 (cast-from-var814-to-var910 var3614!1))) ; Statement: $z0 = interfaceinvoke $r5.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $i3 = interfaceinvoke $r5.<java.util.List: int size()>() 
(assert (not (= (ite var854 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3986 var3189 var3189-init) ; Statement: $r11 = new java.lang.NoSuchMethodException 
(define-const var675 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var675)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var675!1 String)
(assert (= var675!1 ""))
(assert true)
(define-const var2275 String (append/672562846 var675!1 "No such method ")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such method ") 
(declare-const var675!2 String)
(assert (= var675!2 (str.++ var675!1 "No such method ")))
(assert true)
(define-const var2422 String (append/672562846 var2275 var1887)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2275!1 String)
(assert (= var2275!1 (str.++ var2275 var1887)))
(assert true)
(define-const var2805 String (append/672562846 var2422 " in class ")) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in class ") 
(declare-const var2422!1 String)
(assert (= var2422!1 (str.++ var2422 " in class ")))
(assert true)
(define-const var3482 String (append/-1031950772 var2805 (cast-from-ClassObject-to-var743 var1463))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var2805!1 String)
(assert (str.prefixof var2805 var2805!1))
(assert true)
(define-const var1521 String (toString/-2075883882 var3482)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-966825728 var3986 var1521)) ; Statement: specialinvoke $r11.<java.lang.NoSuchMethodException: void <init>(java.lang.String)>($r17) 

(declare-const var3986!1 var3189)
(declare-const var1521!1 String)
 ; Statement: throw $r11 
(check-sat)
; {var814-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), getMethods/-297347657=([java.lang.Class], java.lang.reflect.Method[]), getLength-Arr-var3961-1=([java.lang.reflect.Method[]], int), var910_isEmpty/-153543822=([java.util.List], boolean), cast-from-var814-to-var910=([java.util.ArrayList], java.util.List), var3189-init=([], java.lang.NoSuchMethodException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var743=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-966825728=([java.lang.NoSuchMethodException, java.lang.String], void)}
; {var1463=r1, var1887=r2, var2543=null_type, var407=r0, var814=java.util.ArrayList, var3614=$r5, var3961=java.lang.reflect.Method, var334=r20, var901=i2, var313=i5, var910=java.util.List, var854=$z0, var3189=java.lang.NoSuchMethodException, var3986=$r11, var675=$r12, var2275=$r13, var2422=$r14, var2805=$r15, var743=java.lang.Object, var3482=$r16, var1521=$r17}
; {r1=var1463, r2=var1887, null_type=var2543, r0=var407, java.util.ArrayList=var814, $r5=var3614, java.lang.reflect.Method=var3961, r20=var334, i2=var901, i5=var313, java.util.List=var910, $z0=var854, java.lang.NoSuchMethodException=var3189, $r11=var3986, $r12=var675, $r13=var2275, $r14=var2422, $r15=var2805, java.lang.Object=var743, $r16=var3482, $r17=var1521}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.Class;	r2 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.String[];	if r0 != null goto $i0 = lengthof r0;	$r5 = new java.util.ArrayList;	specialinvoke $r5.<java.util.ArrayList: void <init>()>();	r20 = virtualinvoke r1.<java.lang.Class: java.lang.reflect.Method[] getMethods()>();	i2 = lengthof r20;	i5 = 0;	if i5 >= i2 goto $z0 = interfaceinvoke $r5.<java.util.List: boolean isEmpty()>();	$z0 = interfaceinvoke $r5.<java.util.List: boolean isEmpty()>();	if $z0 == 0 goto $i3 = interfaceinvoke $r5.<java.util.List: int size()>();	$r11 = new java.lang.NoSuchMethodException;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such method ");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in class ");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<java.lang.NoSuchMethodException: void <init>(java.lang.String)>($r17);	throw $r11
;block_num 5
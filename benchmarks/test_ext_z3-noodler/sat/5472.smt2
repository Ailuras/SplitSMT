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

(declare-sort var424 0)
(declare-sort var2858 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isAssignableFrom/-1028998700 (ClassObject ClassObject) Bool)
(declare-fun var2858-init () var2858)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var2858 String) void)
(declare-const null-var424 var424)
(declare-const null-ClassObject ClassObject)
(declare-const var2442 var424) ; Statement: r24 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var2442 null-var424)))
(declare-const var2261 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2261 null-ClassObject)))
(declare-const var2176 ClassObject) ; Statement: r1 := @parameter1: java.lang.Class 
(assert (not (= var2176 null-ClassObject)))
(assert true)
(define-const var673 Bool (isAssignableFrom/-1028998700 var2261 var2176)) ; Statement: $z0 = virtualinvoke r0.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1) 
 ; Statement: if $z0 != 0 goto staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.reflect.Constructor findConstructor(java.lang.Class,java.lang.Class)>(r1, r0) 
(assert (not (not (= (ite var673 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3349 var2858 var2858-init) ; Statement: $r2 = new java.lang.IllegalStateException 
(define-const var47 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var47)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var47!1 String)
(assert (= var47!1 ""))
(assert true)
(define-const var509 String (append/672562846 var47!1 "The local implementation class ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The local implementation class ") 
(declare-const var47!2 String)
(assert (= var47!2 (str.++ var47!1 "The local implementation class ")))
(assert true)
(define-const var3782 String (getName/-1958580599 var2176)) ; Statement: $r4 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1222 String (append/672562846 var509 var3782)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var509!1 String)
(assert (= var509!1 (str.++ var509 var3782)))
(assert true)
(define-const var2145 String (append/672562846 var1222 " not implement interface ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" not implement interface ") 
(declare-const var1222!1 String)
(assert (= var1222!1 (str.++ var1222 " not implement interface ")))
(assert true)
(define-const var1327 String (getName/-1958580599 var2261)) ; Statement: $r7 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3735 String (append/672562846 var2145 var1327)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var2145!1 String)
(assert (= var2145!1 (str.++ var2145 var1327)))
(assert true)
(define-const var2509 String (toString/-2075883882 var3735)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var3349 var2509)) ; Statement: specialinvoke $r2.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r10) 

(declare-const var3349!1 var2858)
(declare-const var2509!1 String)
 ; Statement: throw $r2 
(check-sat)
; {isAssignableFrom/-1028998700=([java.lang.Class, java.lang.Class], boolean), var2858-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var424=org.apache.dubbo.config.AbstractInterfaceConfig, var2442=r24, var2261=r0, var2176=r1, var673=$z0, var2858=java.lang.IllegalStateException, var3349=$r2, var47=$r3, var509=$r5, var3782=$r4, var1222=$r6, var2145=$r8, var1327=$r7, var3735=$r9, var2509=$r10}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var424, r24=var2442, r0=var2261, r1=var2176, $z0=var673, java.lang.IllegalStateException=var2858, $r2=var3349, $r3=var47, $r5=var509, $r4=var3782, $r6=var1222, $r8=var2145, $r7=var1327, $r9=var3735, $r10=var2509}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r24 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	r0 := @parameter0: java.lang.Class;	r1 := @parameter1: java.lang.Class;	$z0 = virtualinvoke r0.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1);	if $z0 != 0 goto staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.reflect.Constructor findConstructor(java.lang.Class,java.lang.Class)>(r1, r0);	$r2 = new java.lang.IllegalStateException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The local implementation class ");	$r4 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" not implement interface ");	$r7 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r10);	throw $r2
;block_num 2
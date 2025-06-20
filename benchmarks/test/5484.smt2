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

(declare-sort var3943 0)
(declare-sort var2688 0)
(declare-sort var1668 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isAssignableFrom/-1028998700 (ClassObject ClassObject) Bool)
(declare-fun var1668-init () var1668)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var1668 String) void)
(declare-const null-var3943 var3943)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2688 var2688)
(declare-const var832 var3943) ; Statement: r24 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var832 null-var3943)))
(declare-const var2230 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2230 null-ClassObject)))
(declare-const var3146 ClassObject) ; Statement: r1 := @parameter1: java.lang.Class 
(assert (not (= var3146 null-ClassObject)))
(assert true)
(define-const var1204 Bool (isAssignableFrom/-1028998700 var2230 var3146)) ; Statement: $z0 = virtualinvoke r0.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1) 
 ; Statement: if $z0 != 0 goto staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.reflect.Constructor findConstructor(java.lang.Class,java.lang.Class)>(r1, r0) 
(assert (not (not (= (ite var1204 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(declare-const var916 var2688) ; Statement: $r11 := @caughtexception 
(assert (not (= var916 null-var2688)))
(define-const var217 var1668 var1668-init) ; Statement: $r12 = new java.lang.IllegalStateException 
(define-const var1348 String String-init) ; Statement: $r13 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1348)) ; Statement: specialinvoke $r13.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1348!1 String)
(assert (= var1348!1 ""))
(assert true)
(define-const var2584 String (append/672562846 var1348!1 "No such constructor \u0022public ")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such constructor \"public ") 
(declare-const var1348!2 String)
(assert (= var1348!2 (str.++ var1348!1 "No such constructor \u0022public ")))
(assert true)
(define-const var2391 String (getSimpleName/-390194377 var3146)) ; Statement: $r14 = virtualinvoke r1.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var1562 String (append/672562846 var2584 var2391)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var2584!1 String)
(assert (= var2584!1 (str.++ var2584 var2391)))
(assert true)
(define-const var3091 String (append/672562846 var1562 "(")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(") 
(declare-const var1562!1 String)
(assert (= var1562!1 (str.++ var1562 "(")))
(assert true)
(define-const var3980 String (getName/-1958580599 var2230)) ; Statement: $r17 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3855 String (append/672562846 var3091 var3980)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var3091!1 String)
(assert (= var3091!1 (str.++ var3091 var3980)))
(assert true)
(define-const var1980 String (append/672562846 var3855 ")\u0022 in local implementation class ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")\" in local implementation class ") 
(declare-const var3855!1 String)
(assert (= var3855!1 (str.++ var3855 ")\u0022 in local implementation class ")))
(assert true)
(define-const var989 String (getName/-1958580599 var3146)) ; Statement: $r20 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3256 String (append/672562846 var1980 var989)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20) 
(declare-const var1980!1 String)
(assert (= var1980!1 (str.++ var1980 var989)))
(assert true)
(define-const var2147 String (toString/-2075883882 var3256)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var217 var2147)) ; Statement: specialinvoke $r12.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r23) 

(declare-const var217!1 var1668)
(declare-const var2147!1 String)
 ; Statement: throw $r12 
(check-sat)
; {isAssignableFrom/-1028998700=([java.lang.Class, java.lang.Class], boolean), var1668-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getSimpleName/-390194377=([java.lang.Class], java.lang.String), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3943=org.apache.dubbo.config.AbstractInterfaceConfig, var832=r24, var2230=r0, var3146=r1, var1204=$z0, var2688=java.lang.NoSuchMethodException, var916=$r11, var1668=java.lang.IllegalStateException, var217=$r12, var1348=$r13, var2584=$r15, var2391=$r14, var1562=$r16, var3091=$r18, var3980=$r17, var3855=$r19, var1980=$r21, var989=$r20, var3256=$r22, var2147=$r23}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var3943, r24=var832, r0=var2230, r1=var3146, $z0=var1204, java.lang.NoSuchMethodException=var2688, $r11=var916, java.lang.IllegalStateException=var1668, $r12=var217, $r13=var1348, $r15=var2584, $r14=var2391, $r16=var1562, $r18=var3091, $r17=var3980, $r19=var3855, $r21=var1980, $r20=var989, $r22=var3256, $r23=var2147}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r24 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	r0 := @parameter0: java.lang.Class;	r1 := @parameter1: java.lang.Class;	$z0 = virtualinvoke r0.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1);	if $z0 != 0 goto staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.reflect.Constructor findConstructor(java.lang.Class,java.lang.Class)>(r1, r0);	$r11 := @caughtexception;	$r12 = new java.lang.IllegalStateException;	$r13 = new java.lang.StringBuilder;	specialinvoke $r13.<java.lang.StringBuilder: void <init>()>();	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No such constructor \"public ");	$r14 = virtualinvoke r1.<java.lang.Class: java.lang.String getSimpleName()>();	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(");	$r17 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")\" in local implementation class ");	$r20 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r12.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r23);	throw $r12
;block_num 2
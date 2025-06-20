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

(declare-sort var1237 0)
(declare-sort var3716 0)
(declare-sort var3180 0)
(declare-sort var3571 0)
(declare-sort var3334 0)
(declare-sort var2096 0)
(declare-sort var2376 0)
(declare-sort var1763 0)
(declare-sort var3826 0)
(declare-sort var67 0)
(declare-sort var1571 0)
(declare-sort var210 0)
(declare-sort var3641 0)
(declare-sort var3507 0)
(declare-sort var2389 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2096!class ClassObject)
(declare-const var3826!class ClassObject)
(declare-fun var3571-init () var3571)
(declare-fun <init>/-325640736 (var3571) void)
(declare-fun methodClass/-1467360182 (var1237 String) ClassObject)
(declare-fun clazz/1671654241 (var1237) ClassObject)
(declare-fun getMethod/1303228849 (ClassObject String (Array Int ClassObject)) var3334)
(declare-fun isAnnotationPresent/-773395105 (var2376 ClassObject) Bool)
(declare-fun cast-from-var3334-to-var2376 (var3334) var2376)
(declare-fun var1763_add/1157925656 (var1763 Int var3180) void)
(declare-fun cast-from-var3571-to-var1763 (var3571) var1763)
(declare-fun cast-from-ClassObject-to-var3180 (ClassObject) var3180)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun var1763_toArray/-775711681 (var1763 (Array Int var3180)) (Array Int var3180))
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3180__ ((Array Int ClassObject)) (Array Int var3180))
(declare-fun cast-from-__Array__Int__var3180__-to-__Array__Int__ClassObject__ ((Array Int var3180)) (Array Int ClassObject))
(declare-fun var67-init () var67)
(declare-fun <init>/451842749 (var67) void)
(declare-fun var1237_getMethodParameterBean/781353740 (ClassObject var3334 (Array Int var3180)) var3180)
(declare-fun getLength-Arr-var3180-1 ((Array Int var3180)) Int)
(declare-fun var1571_isEmpty/-1493248066 (var1571) Bool)
(declare-fun cast-from-var67-to-var1571 (var67) var1571)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun append/-1031950772 (String var3180) String)
(declare-fun cast-from-var67-to-var3180 (var67) var3180)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3641_info/484404803 (var3641 String) void)
(declare-fun cast-from-var210-to-var3641 (var210) var3641)
(declare-fun var3507-init () var3507)
(declare-fun <init>/-612372376 (var3507 String var1571) void)
(declare-fun cast-from-var3507-to-var2389 (var3507) var2389)
(declare-const null-var1237 var1237)
(declare-const null-String String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-__Array__Int__var3180__ (Array Int var3180))
(declare-const null-ClassObject ClassObject)
(declare-const null-var3180 var3180)
(declare-const var1237-logger var210)
(declare-const var460 var1237) ; Statement: r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidator 
(assert (not (= var460 null-var1237)))
(declare-const var387 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var387 null-String)))
(declare-const var1517 (Array Int ClassObject)) ; Statement: r4 := @parameter1: java.lang.Class[] 
(assert (not (= var1517 null-__Array__Int__ClassObject__)))
(declare-const var610 (Array Int var3180)) ; Statement: r10 := @parameter2: java.lang.Object[] 
(assert (not (= var610 null-__Array__Int__var3180__)))
(define-const var3871 var3571 var3571-init) ; Statement: $r44 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3871)) ; Statement: specialinvoke $r44.<java.util.ArrayList: void <init>()>() 

(declare-const var3871!1 var3571)
(assert true)
(define-const var3352 ClassObject (methodClass/-1467360182 var460 var387)) ; Statement: r3 = specialinvoke r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class methodClass(java.lang.String)>(r2) 
 ; Statement: if r3 == null goto $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
(assert (= var3352 null-ClassObject)) ; Cond: r3 == null 
(define-const var1497 ClassObject (clazz/1671654241 var460)) ; Statement: $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
(assert true)
(define-const var3166 var3334 (getMethod/1303228849 var1497 var387 var1517)) ; Statement: $r43 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r4) 
(assert true)
(define-const var2101 Bool (isAnnotationPresent/-773395105 (cast-from-var3334-to-var2376 var3166) var2096!class)) ; Statement: $z0 = virtualinvoke $r43.<java.lang.reflect.Method: boolean isAnnotationPresent(java.lang.Class)>(class "Lorg/apache/dubbo/validation/MethodValidated;") 
 ; Statement: if $z0 == 0 goto interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljavax/validation/groups/Default;") 
(assert (= (ite var2101 1 0) 0)) ; Cond: $z0 == 0 
;(assert (var1763_add/1157925656 (cast-from-var3571-to-var1763 var3871!1) 0 (cast-from-ClassObject-to-var3180 var3826!class))) ; Statement: interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljavax/validation/groups/Default;") 

(declare-const var3871!2 var3571)
(declare-const var2797 Int)
(declare-const var529 ClassObject)
(define-const var3530 ClassObject (clazz/1671654241 var460)) ; Statement: $r6 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
;(assert (var1763_add/1157925656 (cast-from-var3571-to-var1763 var3871!2) 1 (cast-from-ClassObject-to-var3180 var3530))) ; Statement: interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(1, $r6) 

(declare-const var3871!3 var3571)
(declare-const var3903 Int)
(declare-const var3530!1 ClassObject)
(define-const var2072 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r7 = newarray (java.lang.Class)[0] 
(define-const var221 (Array Int var3180) (var1763_toArray/-775711681 (cast-from-var3571-to-var1763 var3871!3) (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3180__ var2072))) ; Statement: $r8 = interfaceinvoke $r44.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r7) 
(define-const var3057 (Array Int ClassObject) (cast-from-__Array__Int__var3180__-to-__Array__Int__ClassObject__ var221)) ; Statement: $r41 = (java.lang.Class[]) $r8 
(define-const var1357 var67 var67-init) ; Statement: $r45 = new java.util.HashSet 
(assert true)
;(assert (<init>/451842749 var1357)) ; Statement: specialinvoke $r45.<java.util.HashSet: void <init>()>() 

(declare-const var1357!1 var67)
(define-const var3974 ClassObject (clazz/1671654241 var460)) ; Statement: $r11 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
(define-const var694 var3180 (var1237_getMethodParameterBean/781353740 var3974 var3166 var610)) ; Statement: $r42 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Object getMethodParameterBean(java.lang.Class,java.lang.reflect.Method,java.lang.Object[])>($r11, $r43, r10) 
 ; Statement: if $r42 == null goto $i0 = lengthof r10 
(assert (= var694 null-var3180)) ; Cond: $r42 == null 
(define-const var1857 Int (getLength-Arr-var3180-1 var610)) ; Statement: $i0 = lengthof r10 
(define-const var1570 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>() 
(assert (>= var1570 var1857)) ; Cond: i1 >= $i0 
(define-const var1155 Bool (var1571_isEmpty/-1493248066 (cast-from-var67-to-var1571 var1357!1))) ; Statement: $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>() 
 ; Statement: if $z1 != 0 goto return 
(assert (not (not (= (ite var1155 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(define-const var1573 var210 var1237-logger) ; Statement: $r13 = <org.apache.dubbo.validation.support.jvalidation.JValidator: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var350 String String-init) ; Statement: $r46 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var350)) ; Statement: specialinvoke $r46.<java.lang.StringBuilder: void <init>()>() 
(declare-const var350!1 String)
(assert (= var350!1 ""))
(assert true)
(define-const var1586 String (append/672562846 var350!1 "Failed to validate service: ")) ; Statement: $r16 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to validate service: ") 
(declare-const var350!2 String)
(assert (= var350!2 (str.++ var350!1 "Failed to validate service: ")))
(define-const var1529 ClassObject (clazz/1671654241 var460)) ; Statement: $r14 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
(assert true)
(define-const var3286 String (getName/-1958580599 var1529)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2429 String (append/672562846 var1586 var3286)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var1586!1 String)
(assert (= var1586!1 (str.++ var1586 var3286)))
(assert true)
(define-const var315 String (append/672562846 var2429 ", method: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ") 
(declare-const var2429!1 String)
(assert (= var2429!1 (str.++ var2429 ", method: ")))
(assert true)
(define-const var2732 String (append/672562846 var315 var387)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var315!1 String)
(assert (= var315!1 (str.++ var315 var387)))
(assert true)
(define-const var3797 String (append/672562846 var2732 ", cause: ")) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var2732!1 String)
(assert (= var2732!1 (str.++ var2732 ", cause: ")))
(assert true)
(define-const var1263 String (append/-1031950772 var3797 (cast-from-var67-to-var3180 var1357!1))) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45) 
(declare-const var3797!1 String)
(assert (str.prefixof var3797 var3797!1))
(assert true)
(define-const var2141 String (toString/-2075883882 var1263)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3641_info/484404803 (cast-from-var210-to-var3641 var1573) var2141)) ; Statement: interfaceinvoke $r13.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r22) 

(declare-const var1573!1 var210)
(declare-const var2141!1 String)
(define-const var3437 var3507 var3507-init) ; Statement: $r48 = new javax.validation.ConstraintViolationException 
(define-const var2816 String String-init) ; Statement: $r47 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2816)) ; Statement: specialinvoke $r47.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2816!1 String)
(assert (= var2816!1 ""))
(assert true)
(define-const var2548 String (append/672562846 var2816!1 "Failed to validate service: ")) ; Statement: $r27 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to validate service: ") 
(declare-const var2816!2 String)
(assert (= var2816!2 (str.++ var2816!1 "Failed to validate service: ")))
(define-const var2591 ClassObject (clazz/1671654241 var460)) ; Statement: $r25 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
(assert true)
(define-const var3581 String (getName/-1958580599 var2591)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1225 String (append/672562846 var2548 var3581)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r26) 
(declare-const var2548!1 String)
(assert (= var2548!1 (str.++ var2548 var3581)))
(assert true)
(define-const var558 String (append/672562846 var1225 ", method: ")) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ") 
(declare-const var1225!1 String)
(assert (= var1225!1 (str.++ var1225 ", method: ")))
(assert true)
(define-const var1209 String (append/672562846 var558 var387)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var558!1 String)
(assert (= var558!1 (str.++ var558 var387)))
(assert true)
(define-const var3049 String (append/672562846 var1209 ", cause: ")) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var1209!1 String)
(assert (= var1209!1 (str.++ var1209 ", cause: ")))
(assert true)
(define-const var3294 String (append/-1031950772 var3049 (cast-from-var67-to-var3180 var1357!1))) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45) 
(declare-const var3049!1 String)
(assert (str.prefixof var3049 var3049!1))
(assert true)
(define-const var3330 String (toString/-2075883882 var3294)) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-612372376 var3437 var3330 (cast-from-var67-to-var1571 var1357!1))) ; Statement: specialinvoke $r48.<javax.validation.ConstraintViolationException: void <init>(java.lang.String,java.util.Set)>($r33, $r45) 

(declare-const var3437!1 var3507)
(declare-const var3330!1 String)
(declare-const var1357!2 var67)
(define-const var427 var2389 (cast-from-var3507-to-var2389 var3437!1)) ; Statement: $r49 = (java.lang.Throwable) $r48 
 ; Statement: throw $r49 
(check-sat)
; {var3571-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), methodClass/-1467360182=([org.apache.dubbo.validation.support.jvalidation.JValidator, java.lang.String], java.lang.Class), clazz/1671654241=([org.apache.dubbo.validation.support.jvalidation.JValidator], java.lang.Class), getMethod/1303228849=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method), isAnnotationPresent/-773395105=([java.lang.reflect.AccessibleObject, java.lang.Class], boolean), cast-from-var3334-to-var2376=([java.lang.reflect.Method], java.lang.reflect.AccessibleObject), var1763_add/1157925656=([java.util.List, int, java.lang.Object], void), cast-from-var3571-to-var1763=([java.util.ArrayList], java.util.List), cast-from-ClassObject-to-var3180=([java.lang.Class], java.lang.Object), arr-ClassObject-init=([], java.lang.Class[]), var1763_toArray/-775711681=([java.util.List, java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3180__=([java.lang.Class[]], java.lang.Object[]), cast-from-__Array__Int__var3180__-to-__Array__Int__ClassObject__=([java.lang.Object[]], java.lang.Class[]), var67-init=([], java.util.HashSet), <init>/451842749=([java.util.HashSet], void), var1237_getMethodParameterBean/781353740=([java.lang.Class, java.lang.reflect.Method, java.lang.Object[]], java.lang.Object), getLength-Arr-var3180-1=([java.lang.Object[]], int), var1571_isEmpty/-1493248066=([java.util.Set], boolean), cast-from-var67-to-var1571=([java.util.HashSet], java.util.Set), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var67-to-var3180=([java.util.HashSet], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3641_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var210-to-var3641=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var3507-init=([], javax.validation.ConstraintViolationException), <init>/-612372376=([javax.validation.ConstraintViolationException, java.lang.String, java.util.Set], void), cast-from-var3507-to-var2389=([javax.validation.ConstraintViolationException], java.lang.Throwable)}
; {var1237=org.apache.dubbo.validation.support.jvalidation.JValidator, var460=r1, var387=r2, var3716=null_type, var1517=r4, var3180=java.lang.Object, var610=r10, var3571=java.util.ArrayList, var3871=$r44, var3352=r3, var1497=$r5, var3334=java.lang.reflect.Method, var3166=$r43, var2096=org.apache.dubbo.validation.MethodValidated, var2376=java.lang.reflect.AccessibleObject, var2101=$z0, var1763=java.util.List, var3826=javax.validation.groups.Default, var2797=0, var529=class "Ljavax/validation/groups/Default;", var3530=$r6, var3903=1, var2072=$r7, var221=$r8, var3057=$r41, var67=java.util.HashSet, var1357=$r45, var3974=$r11, var694=$r42, var1857=$i0, var1570=i1, var1571=java.util.Set, var1155=$z1, var210=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1573=$r13, var350=$r46, var1586=$r16, var1529=$r14, var3286=$r15, var2429=$r17, var315=$r18, var2732=$r19, var3797=$r20, var1263=$r21, var2141=$r22, var3641=org.apache.dubbo.common.logger.Logger, var3507=javax.validation.ConstraintViolationException, var3437=$r48, var2816=$r47, var2548=$r27, var2591=$r25, var3581=$r26, var1225=$r28, var558=$r29, var1209=$r30, var3049=$r31, var3294=$r32, var3330=$r33, var2389=java.lang.Throwable, var427=$r49}
; {org.apache.dubbo.validation.support.jvalidation.JValidator=var1237, r1=var460, r2=var387, null_type=var3716, r4=var1517, java.lang.Object=var3180, r10=var610, java.util.ArrayList=var3571, $r44=var3871, r3=var3352, $r5=var1497, java.lang.reflect.Method=var3334, $r43=var3166, org.apache.dubbo.validation.MethodValidated=var2096, java.lang.reflect.AccessibleObject=var2376, $z0=var2101, java.util.List=var1763, javax.validation.groups.Default=var3826, 0=var2797, class "Ljavax/validation/groups/Default;"=var529, $r6=var3530, 1=var3903, $r7=var2072, $r8=var221, $r41=var3057, java.util.HashSet=var67, $r45=var1357, $r11=var3974, $r42=var694, $i0=var1857, i1=var1570, java.util.Set=var1571, $z1=var1155, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var210, $r13=var1573, $r46=var350, $r16=var1586, $r14=var1529, $r15=var3286, $r17=var2429, $r18=var315, $r19=var2732, $r20=var3797, $r21=var1263, $r22=var2141, org.apache.dubbo.common.logger.Logger=var3641, javax.validation.ConstraintViolationException=var3507, $r48=var3437, $r47=var2816, $r27=var2548, $r25=var2591, $r26=var3581, $r28=var1225, $r29=var558, $r30=var1209, $r31=var3049, $r32=var3294, $r33=var3330, java.lang.Throwable=var2389, $r49=var427}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidator;	r2 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.Class[];	r10 := @parameter2: java.lang.Object[];	$r44 = new java.util.ArrayList;	specialinvoke $r44.<java.util.ArrayList: void <init>()>();	r3 = specialinvoke r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class methodClass(java.lang.String)>(r2);	if r3 == null goto $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	$r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	$r43 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r4);	$z0 = virtualinvoke $r43.<java.lang.reflect.Method: boolean isAnnotationPresent(java.lang.Class)>(class "Lorg/apache/dubbo/validation/MethodValidated;");	if $z0 == 0 goto interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljavax/validation/groups/Default;");	interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljavax/validation/groups/Default;");	$r6 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(1, $r6);	$r7 = newarray (java.lang.Class)[0];	$r8 = interfaceinvoke $r44.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r7);	$r41 = (java.lang.Class[]) $r8;	$r45 = new java.util.HashSet;	specialinvoke $r45.<java.util.HashSet: void <init>()>();	$r11 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	$r42 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Object getMethodParameterBean(java.lang.Class,java.lang.reflect.Method,java.lang.Object[])>($r11, $r43, r10);	if $r42 == null goto $i0 = lengthof r10;	$i0 = lengthof r10;	i1 = 0;	if i1 >= $i0 goto $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>();	$z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>();	if $z1 != 0 goto return;	$r13 = <org.apache.dubbo.validation.support.jvalidation.JValidator: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r46 = new java.lang.StringBuilder;	specialinvoke $r46.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to validate service: ");	$r14 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	$r15 = virtualinvoke $r14.<java.lang.Class: java.lang.String getName()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r13.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r22);	$r48 = new javax.validation.ConstraintViolationException;	$r47 = new java.lang.StringBuilder;	specialinvoke $r47.<java.lang.StringBuilder: void <init>()>();	$r27 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to validate service: ");	$r25 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	$r26 = virtualinvoke $r25.<java.lang.Class: java.lang.String getName()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r26);	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ");	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r48.<javax.validation.ConstraintViolationException: void <init>(java.lang.String,java.util.Set)>($r33, $r45);	$r49 = (java.lang.Throwable) $r48;	throw $r49
;block_num 7
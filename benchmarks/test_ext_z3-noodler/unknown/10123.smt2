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

(declare-sort var3097 0)
(declare-sort var3033 0)
(declare-sort var3101 0)
(declare-sort var1913 0)
(declare-sort var362 0)
(declare-sort var3951 0)
(declare-sort var258 0)
(declare-sort var1958 0)
(declare-sort var809 0)
(declare-sort var2984 0)
(declare-sort var1554 0)
(declare-sort var1939 0)
(declare-sort var3502 0)
(declare-sort var1045 0)
(declare-sort var2862 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3951!class ClassObject)
(declare-const var809!class ClassObject)
(declare-fun var1913-init () var1913)
(declare-fun <init>/-325640736 (var1913) void)
(declare-fun methodClass/-1752336528 (var3097 String) ClassObject)
(declare-fun clazz/105774719 (var3097) ClassObject)
(declare-fun getMethod/1303228849 (ClassObject String (Array Int ClassObject)) var362)
(declare-fun isAnnotationPresent/-773395105 (var258 ClassObject) Bool)
(declare-fun cast-from-var362-to-var258 (var362) var258)
(declare-fun var1958_add/1157925656 (var1958 Int var3101) void)
(declare-fun cast-from-var1913-to-var1958 (var1913) var1958)
(declare-fun cast-from-ClassObject-to-var3101 (ClassObject) var3101)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun var1958_toArray/-775711681 (var1958 (Array Int var3101)) (Array Int var3101))
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3101__ ((Array Int ClassObject)) (Array Int var3101))
(declare-fun cast-from-__Array__Int__var3101__-to-__Array__Int__ClassObject__ ((Array Int var3101)) (Array Int ClassObject))
(declare-fun var2984-init () var2984)
(declare-fun <init>/451842749 (var2984) void)
(declare-fun var3097_getMethodParameterBean/1785517350 (ClassObject var362 (Array Int var3101)) var3101)
(declare-fun getLength-Arr-var3101-1 ((Array Int var3101)) Int)
(declare-fun var1554_isEmpty/-1493248066 (var1554) Bool)
(declare-fun cast-from-var2984-to-var1554 (var2984) var1554)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun append/-1031950772 (String var3101) String)
(declare-fun cast-from-var2984-to-var3101 (var2984) var3101)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3502_info/484404803 (var3502 String) void)
(declare-fun cast-from-var1939-to-var3502 (var1939) var3502)
(declare-fun var1045-init () var1045)
(declare-fun <init>/113158724 (var1045 String var1554) void)
(declare-fun cast-from-var1045-to-var2862 (var1045) var2862)
(declare-const null-var3097 var3097)
(declare-const null-String String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-__Array__Int__var3101__ (Array Int var3101))
(declare-const null-ClassObject ClassObject)
(declare-const null-var3101 var3101)
(declare-const var3097-logger var1939)
(declare-const var1166 var3097) ; Statement: r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew 
(assert (not (= var1166 null-var3097)))
(declare-const var2839 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2839 null-String)))
(declare-const var3540 (Array Int ClassObject)) ; Statement: r4 := @parameter1: java.lang.Class[] 
(assert (not (= var3540 null-__Array__Int__ClassObject__)))
(declare-const var1919 (Array Int var3101)) ; Statement: r10 := @parameter2: java.lang.Object[] 
(assert (not (= var1919 null-__Array__Int__var3101__)))
(define-const var2945 var1913 var1913-init) ; Statement: $r44 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2945)) ; Statement: specialinvoke $r44.<java.util.ArrayList: void <init>()>() 

(declare-const var2945!1 var1913)
(assert true)
(define-const var584 ClassObject (methodClass/-1752336528 var1166 var2839)) ; Statement: r3 = specialinvoke r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class methodClass(java.lang.String)>(r2) 
 ; Statement: if r3 == null goto $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
(assert (= var584 null-ClassObject)) ; Cond: r3 == null 
(define-const var3239 ClassObject (clazz/105774719 var1166)) ; Statement: $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
(assert true)
(define-const var1531 var362 (getMethod/1303228849 var3239 var2839 var3540)) ; Statement: $r43 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r4) 
(assert true)
(define-const var321 Bool (isAnnotationPresent/-773395105 (cast-from-var362-to-var258 var1531) var3951!class)) ; Statement: $z0 = virtualinvoke $r43.<java.lang.reflect.Method: boolean isAnnotationPresent(java.lang.Class)>(class "Lorg/apache/dubbo/validation/MethodValidated;") 
 ; Statement: if $z0 == 0 goto interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljakarta/validation/groups/Default;") 
(assert (= (ite var321 1 0) 0)) ; Cond: $z0 == 0 
;(assert (var1958_add/1157925656 (cast-from-var1913-to-var1958 var2945!1) 0 (cast-from-ClassObject-to-var3101 var809!class))) ; Statement: interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljakarta/validation/groups/Default;") 

(declare-const var2945!2 var1913)
(declare-const var3334 Int)
(declare-const var1561 ClassObject)
(define-const var1983 ClassObject (clazz/105774719 var1166)) ; Statement: $r6 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
;(assert (var1958_add/1157925656 (cast-from-var1913-to-var1958 var2945!2) 1 (cast-from-ClassObject-to-var3101 var1983))) ; Statement: interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(1, $r6) 

(declare-const var2945!3 var1913)
(declare-const var1418 Int)
(declare-const var1983!1 ClassObject)
(define-const var1200 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r7 = newarray (java.lang.Class)[0] 
(define-const var2471 (Array Int var3101) (var1958_toArray/-775711681 (cast-from-var1913-to-var1958 var2945!3) (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3101__ var1200))) ; Statement: $r8 = interfaceinvoke $r44.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r7) 
(define-const var3937 (Array Int ClassObject) (cast-from-__Array__Int__var3101__-to-__Array__Int__ClassObject__ var2471)) ; Statement: $r41 = (java.lang.Class[]) $r8 
(define-const var369 var2984 var2984-init) ; Statement: $r45 = new java.util.HashSet 
(assert true)
;(assert (<init>/451842749 var369)) ; Statement: specialinvoke $r45.<java.util.HashSet: void <init>()>() 

(declare-const var369!1 var2984)
(define-const var3426 ClassObject (clazz/105774719 var1166)) ; Statement: $r11 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
(define-const var3663 var3101 (var3097_getMethodParameterBean/1785517350 var3426 var1531 var1919)) ; Statement: $r42 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Object getMethodParameterBean(java.lang.Class,java.lang.reflect.Method,java.lang.Object[])>($r11, $r43, r10) 
 ; Statement: if $r42 == null goto $i0 = lengthof r10 
(assert (= var3663 null-var3101)) ; Cond: $r42 == null 
(define-const var3378 Int (getLength-Arr-var3101-1 var1919)) ; Statement: $i0 = lengthof r10 
(define-const var685 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>() 
(assert (>= var685 var3378)) ; Cond: i1 >= $i0 
(define-const var538 Bool (var1554_isEmpty/-1493248066 (cast-from-var2984-to-var1554 var369!1))) ; Statement: $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>() 
 ; Statement: if $z1 != 0 goto return 
(assert (not (not (= (ite var538 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(define-const var3421 var1939 var3097-logger) ; Statement: $r13 = <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2043 String String-init) ; Statement: $r46 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2043)) ; Statement: specialinvoke $r46.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2043!1 String)
(assert (= var2043!1 ""))
(assert true)
(define-const var3144 String (append/672562846 var2043!1 "Failed to validate service: ")) ; Statement: $r16 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to validate service: ") 
(declare-const var2043!2 String)
(assert (= var2043!2 (str.++ var2043!1 "Failed to validate service: ")))
(define-const var2158 ClassObject (clazz/105774719 var1166)) ; Statement: $r14 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
(assert true)
(define-const var3185 String (getName/-1958580599 var2158)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3580 String (append/672562846 var3144 var3185)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var3144!1 String)
(assert (= var3144!1 (str.++ var3144 var3185)))
(assert true)
(define-const var1979 String (append/672562846 var3580 ", method: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ") 
(declare-const var3580!1 String)
(assert (= var3580!1 (str.++ var3580 ", method: ")))
(assert true)
(define-const var2451 String (append/672562846 var1979 var2839)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1979!1 String)
(assert (= var1979!1 (str.++ var1979 var2839)))
(assert true)
(define-const var1944 String (append/672562846 var2451 ", cause: ")) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var2451!1 String)
(assert (= var2451!1 (str.++ var2451 ", cause: ")))
(assert true)
(define-const var2362 String (append/-1031950772 var1944 (cast-from-var2984-to-var3101 var369!1))) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45) 
(declare-const var1944!1 String)
(assert (str.prefixof var1944 var1944!1))
(assert true)
(define-const var3509 String (toString/-2075883882 var2362)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3502_info/484404803 (cast-from-var1939-to-var3502 var3421) var3509)) ; Statement: interfaceinvoke $r13.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r22) 

(declare-const var3421!1 var1939)
(declare-const var3509!1 String)
(define-const var2755 var1045 var1045-init) ; Statement: $r48 = new jakarta.validation.ConstraintViolationException 
(define-const var1673 String String-init) ; Statement: $r47 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1673)) ; Statement: specialinvoke $r47.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1673!1 String)
(assert (= var1673!1 ""))
(assert true)
(define-const var1708 String (append/672562846 var1673!1 "Failed to validate service: ")) ; Statement: $r27 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to validate service: ") 
(declare-const var1673!2 String)
(assert (= var1673!2 (str.++ var1673!1 "Failed to validate service: ")))
(define-const var2883 ClassObject (clazz/105774719 var1166)) ; Statement: $r25 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
(assert true)
(define-const var1510 String (getName/-1958580599 var2883)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1144 String (append/672562846 var1708 var1510)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r26) 
(declare-const var1708!1 String)
(assert (= var1708!1 (str.++ var1708 var1510)))
(assert true)
(define-const var3474 String (append/672562846 var1144 ", method: ")) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ") 
(declare-const var1144!1 String)
(assert (= var1144!1 (str.++ var1144 ", method: ")))
(assert true)
(define-const var2407 String (append/672562846 var3474 var2839)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var3474!1 String)
(assert (= var3474!1 (str.++ var3474 var2839)))
(assert true)
(define-const var3083 String (append/672562846 var2407 ", cause: ")) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var2407!1 String)
(assert (= var2407!1 (str.++ var2407 ", cause: ")))
(assert true)
(define-const var2044 String (append/-1031950772 var3083 (cast-from-var2984-to-var3101 var369!1))) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45) 
(declare-const var3083!1 String)
(assert (str.prefixof var3083 var3083!1))
(assert true)
(define-const var1352 String (toString/-2075883882 var2044)) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/113158724 var2755 var1352 (cast-from-var2984-to-var1554 var369!1))) ; Statement: specialinvoke $r48.<jakarta.validation.ConstraintViolationException: void <init>(java.lang.String,java.util.Set)>($r33, $r45) 

(declare-const var2755!1 var1045)
(declare-const var1352!1 String)
(declare-const var369!2 var2984)
(define-const var539 var2862 (cast-from-var1045-to-var2862 var2755!1)) ; Statement: $r49 = (java.lang.Throwable) $r48 
 ; Statement: throw $r49 
(check-sat)
; {var1913-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), methodClass/-1752336528=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew, java.lang.String], java.lang.Class), clazz/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.lang.Class), getMethod/1303228849=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method), isAnnotationPresent/-773395105=([java.lang.reflect.AccessibleObject, java.lang.Class], boolean), cast-from-var362-to-var258=([java.lang.reflect.Method], java.lang.reflect.AccessibleObject), var1958_add/1157925656=([java.util.List, int, java.lang.Object], void), cast-from-var1913-to-var1958=([java.util.ArrayList], java.util.List), cast-from-ClassObject-to-var3101=([java.lang.Class], java.lang.Object), arr-ClassObject-init=([], java.lang.Class[]), var1958_toArray/-775711681=([java.util.List, java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3101__=([java.lang.Class[]], java.lang.Object[]), cast-from-__Array__Int__var3101__-to-__Array__Int__ClassObject__=([java.lang.Object[]], java.lang.Class[]), var2984-init=([], java.util.HashSet), <init>/451842749=([java.util.HashSet], void), var3097_getMethodParameterBean/1785517350=([java.lang.Class, java.lang.reflect.Method, java.lang.Object[]], java.lang.Object), getLength-Arr-var3101-1=([java.lang.Object[]], int), var1554_isEmpty/-1493248066=([java.util.Set], boolean), cast-from-var2984-to-var1554=([java.util.HashSet], java.util.Set), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2984-to-var3101=([java.util.HashSet], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3502_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var1939-to-var3502=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var1045-init=([], jakarta.validation.ConstraintViolationException), <init>/113158724=([jakarta.validation.ConstraintViolationException, java.lang.String, java.util.Set], void), cast-from-var1045-to-var2862=([jakarta.validation.ConstraintViolationException], java.lang.Throwable)}
; {var3097=org.apache.dubbo.validation.support.jvalidation.JValidatorNew, var1166=r1, var2839=r2, var3033=null_type, var3540=r4, var3101=java.lang.Object, var1919=r10, var1913=java.util.ArrayList, var2945=$r44, var584=r3, var3239=$r5, var362=java.lang.reflect.Method, var1531=$r43, var3951=org.apache.dubbo.validation.MethodValidated, var258=java.lang.reflect.AccessibleObject, var321=$z0, var1958=java.util.List, var809=jakarta.validation.groups.Default, var3334=0, var1561=class "Ljakarta/validation/groups/Default;", var1983=$r6, var1418=1, var1200=$r7, var2471=$r8, var3937=$r41, var2984=java.util.HashSet, var369=$r45, var3426=$r11, var3663=$r42, var3378=$i0, var685=i1, var1554=java.util.Set, var538=$z1, var1939=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3421=$r13, var2043=$r46, var3144=$r16, var2158=$r14, var3185=$r15, var3580=$r17, var1979=$r18, var2451=$r19, var1944=$r20, var2362=$r21, var3509=$r22, var3502=org.apache.dubbo.common.logger.Logger, var1045=jakarta.validation.ConstraintViolationException, var2755=$r48, var1673=$r47, var1708=$r27, var2883=$r25, var1510=$r26, var1144=$r28, var3474=$r29, var2407=$r30, var3083=$r31, var2044=$r32, var1352=$r33, var2862=java.lang.Throwable, var539=$r49}
; {org.apache.dubbo.validation.support.jvalidation.JValidatorNew=var3097, r1=var1166, r2=var2839, null_type=var3033, r4=var3540, java.lang.Object=var3101, r10=var1919, java.util.ArrayList=var1913, $r44=var2945, r3=var584, $r5=var3239, java.lang.reflect.Method=var362, $r43=var1531, org.apache.dubbo.validation.MethodValidated=var3951, java.lang.reflect.AccessibleObject=var258, $z0=var321, java.util.List=var1958, jakarta.validation.groups.Default=var809, 0=var3334, class "Ljakarta/validation/groups/Default;"=var1561, $r6=var1983, 1=var1418, $r7=var1200, $r8=var2471, $r41=var3937, java.util.HashSet=var2984, $r45=var369, $r11=var3426, $r42=var3663, $i0=var3378, i1=var685, java.util.Set=var1554, $z1=var538, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1939, $r13=var3421, $r46=var2043, $r16=var3144, $r14=var2158, $r15=var3185, $r17=var3580, $r18=var1979, $r19=var2451, $r20=var1944, $r21=var2362, $r22=var3509, org.apache.dubbo.common.logger.Logger=var3502, jakarta.validation.ConstraintViolationException=var1045, $r48=var2755, $r47=var1673, $r27=var1708, $r25=var2883, $r26=var1510, $r28=var1144, $r29=var3474, $r30=var2407, $r31=var3083, $r32=var2044, $r33=var1352, java.lang.Throwable=var2862, $r49=var539}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew;	r2 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.Class[];	r10 := @parameter2: java.lang.Object[];	$r44 = new java.util.ArrayList;	specialinvoke $r44.<java.util.ArrayList: void <init>()>();	r3 = specialinvoke r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class methodClass(java.lang.String)>(r2);	if r3 == null goto $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	$r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	$r43 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r4);	$z0 = virtualinvoke $r43.<java.lang.reflect.Method: boolean isAnnotationPresent(java.lang.Class)>(class "Lorg/apache/dubbo/validation/MethodValidated;");	if $z0 == 0 goto interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljakarta/validation/groups/Default;");	interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljakarta/validation/groups/Default;");	$r6 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(1, $r6);	$r7 = newarray (java.lang.Class)[0];	$r8 = interfaceinvoke $r44.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r7);	$r41 = (java.lang.Class[]) $r8;	$r45 = new java.util.HashSet;	specialinvoke $r45.<java.util.HashSet: void <init>()>();	$r11 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	$r42 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Object getMethodParameterBean(java.lang.Class,java.lang.reflect.Method,java.lang.Object[])>($r11, $r43, r10);	if $r42 == null goto $i0 = lengthof r10;	$i0 = lengthof r10;	i1 = 0;	if i1 >= $i0 goto $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>();	$z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>();	if $z1 != 0 goto return;	$r13 = <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r46 = new java.lang.StringBuilder;	specialinvoke $r46.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to validate service: ");	$r14 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	$r15 = virtualinvoke $r14.<java.lang.Class: java.lang.String getName()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r13.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r22);	$r48 = new jakarta.validation.ConstraintViolationException;	$r47 = new java.lang.StringBuilder;	specialinvoke $r47.<java.lang.StringBuilder: void <init>()>();	$r27 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to validate service: ");	$r25 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	$r26 = virtualinvoke $r25.<java.lang.Class: java.lang.String getName()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r26);	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ");	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r48.<jakarta.validation.ConstraintViolationException: void <init>(java.lang.String,java.util.Set)>($r33, $r45);	$r49 = (java.lang.Throwable) $r48;	throw $r49
;block_num 7
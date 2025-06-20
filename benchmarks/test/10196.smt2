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

(declare-sort var3185 0)
(declare-sort var2159 0)
(declare-sort var2723 0)
(declare-sort var3573 0)
(declare-sort var3676 0)
(declare-sort var2014 0)
(declare-sort var811 0)
(declare-sort var1197 0)
(declare-sort var2470 0)
(declare-sort var1486 0)
(declare-sort var3248 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2014!class ClassObject)
(declare-const var2470!class ClassObject)
(declare-fun var3573-init () var3573)
(declare-fun <init>/-325640736 (var3573) void)
(declare-fun methodClass/-1752336528 (var3185 String) ClassObject)
(declare-fun clazz/105774719 (var3185) ClassObject)
(declare-fun getMethod/1303228849 (ClassObject String (Array Int ClassObject)) var3676)
(declare-fun isAnnotationPresent/-773395105 (var811 ClassObject) Bool)
(declare-fun cast-from-var3676-to-var811 (var3676) var811)
(declare-fun var1197_add/1157925656 (var1197 Int var2723) void)
(declare-fun cast-from-var3573-to-var1197 (var3573) var1197)
(declare-fun cast-from-ClassObject-to-var2723 (ClassObject) var2723)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun var1197_toArray/-775711681 (var1197 (Array Int var2723)) (Array Int var2723))
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2723__ ((Array Int ClassObject)) (Array Int var2723))
(declare-fun cast-from-__Array__Int__var2723__-to-__Array__Int__ClassObject__ ((Array Int var2723)) (Array Int ClassObject))
(declare-fun var1486-init () var1486)
(declare-fun <init>/451842749 (var1486) void)
(declare-fun var3185_getMethodParameterBean/1785517350 (ClassObject var3676 (Array Int var2723)) var2723)
(declare-fun getLength-Arr-var2723-1 ((Array Int var2723)) Int)
(declare-fun var3248_isEmpty/-1493248066 (var3248) Bool)
(declare-fun cast-from-var1486-to-var3248 (var1486) var3248)
(declare-const null-var3185 var3185)
(declare-const null-String String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-__Array__Int__var2723__ (Array Int var2723))
(declare-const null-ClassObject ClassObject)
(declare-const null-var2723 var2723)
(declare-const var1346 var3185) ; Statement: r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew 
(assert (not (= var1346 null-var3185)))
(declare-const var1063 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1063 null-String)))
(declare-const var1678 (Array Int ClassObject)) ; Statement: r4 := @parameter1: java.lang.Class[] 
(assert (not (= var1678 null-__Array__Int__ClassObject__)))
(declare-const var601 (Array Int var2723)) ; Statement: r10 := @parameter2: java.lang.Object[] 
(assert (not (= var601 null-__Array__Int__var2723__)))
(define-const var3870 var3573 var3573-init) ; Statement: $r44 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3870)) ; Statement: specialinvoke $r44.<java.util.ArrayList: void <init>()>() 

(declare-const var3870!1 var3573)
(assert true)
(define-const var2981 ClassObject (methodClass/-1752336528 var1346 var1063)) ; Statement: r3 = specialinvoke r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class methodClass(java.lang.String)>(r2) 
 ; Statement: if r3 == null goto $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
(assert (= var2981 null-ClassObject)) ; Cond: r3 == null 
(define-const var1749 ClassObject (clazz/105774719 var1346)) ; Statement: $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
(assert true)
(define-const var2239 var3676 (getMethod/1303228849 var1749 var1063 var1678)) ; Statement: $r43 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r4) 
(assert true)
(define-const var2538 Bool (isAnnotationPresent/-773395105 (cast-from-var3676-to-var811 var2239) var2014!class)) ; Statement: $z0 = virtualinvoke $r43.<java.lang.reflect.Method: boolean isAnnotationPresent(java.lang.Class)>(class "Lorg/apache/dubbo/validation/MethodValidated;") 
 ; Statement: if $z0 == 0 goto interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljakarta/validation/groups/Default;") 
(assert (= (ite var2538 1 0) 0)) ; Cond: $z0 == 0 
;(assert (var1197_add/1157925656 (cast-from-var3573-to-var1197 var3870!1) 0 (cast-from-ClassObject-to-var2723 var2470!class))) ; Statement: interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljakarta/validation/groups/Default;") 

(declare-const var3870!2 var3573)
(declare-const var3553 Int)
(declare-const var1754 ClassObject)
(define-const var932 ClassObject (clazz/105774719 var1346)) ; Statement: $r6 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
;(assert (var1197_add/1157925656 (cast-from-var3573-to-var1197 var3870!2) 1 (cast-from-ClassObject-to-var2723 var932))) ; Statement: interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(1, $r6) 

(declare-const var3870!3 var3573)
(declare-const var2271 Int)
(declare-const var932!1 ClassObject)
(define-const var2045 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r7 = newarray (java.lang.Class)[0] 
(define-const var3965 (Array Int var2723) (var1197_toArray/-775711681 (cast-from-var3573-to-var1197 var3870!3) (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2723__ var2045))) ; Statement: $r8 = interfaceinvoke $r44.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r7) 
(define-const var3008 (Array Int ClassObject) (cast-from-__Array__Int__var2723__-to-__Array__Int__ClassObject__ var3965)) ; Statement: $r41 = (java.lang.Class[]) $r8 
(define-const var1414 var1486 var1486-init) ; Statement: $r45 = new java.util.HashSet 
(assert true)
;(assert (<init>/451842749 var1414)) ; Statement: specialinvoke $r45.<java.util.HashSet: void <init>()>() 

(declare-const var1414!1 var1486)
(define-const var1702 ClassObject (clazz/105774719 var1346)) ; Statement: $r11 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
(define-const var1061 var2723 (var3185_getMethodParameterBean/1785517350 var1702 var2239 var601)) ; Statement: $r42 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Object getMethodParameterBean(java.lang.Class,java.lang.reflect.Method,java.lang.Object[])>($r11, $r43, r10) 
 ; Statement: if $r42 == null goto $i0 = lengthof r10 
(assert (= var1061 null-var2723)) ; Cond: $r42 == null 
(define-const var46 Int (getLength-Arr-var2723-1 var601)) ; Statement: $i0 = lengthof r10 
(define-const var2483 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>() 
(assert (>= var2483 var46)) ; Cond: i1 >= $i0 
(define-const var2487 Bool (var3248_isEmpty/-1493248066 (cast-from-var1486-to-var3248 var1414!1))) ; Statement: $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>() 
 ; Statement: if $z1 != 0 goto return 
(assert (not (= (ite var2487 1 0) 0))) ; Cond: $z1 != 0 
 ; Statement: return 
(check-sat)
; {var3573-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), methodClass/-1752336528=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew, java.lang.String], java.lang.Class), clazz/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.lang.Class), getMethod/1303228849=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method), isAnnotationPresent/-773395105=([java.lang.reflect.AccessibleObject, java.lang.Class], boolean), cast-from-var3676-to-var811=([java.lang.reflect.Method], java.lang.reflect.AccessibleObject), var1197_add/1157925656=([java.util.List, int, java.lang.Object], void), cast-from-var3573-to-var1197=([java.util.ArrayList], java.util.List), cast-from-ClassObject-to-var2723=([java.lang.Class], java.lang.Object), arr-ClassObject-init=([], java.lang.Class[]), var1197_toArray/-775711681=([java.util.List, java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2723__=([java.lang.Class[]], java.lang.Object[]), cast-from-__Array__Int__var2723__-to-__Array__Int__ClassObject__=([java.lang.Object[]], java.lang.Class[]), var1486-init=([], java.util.HashSet), <init>/451842749=([java.util.HashSet], void), var3185_getMethodParameterBean/1785517350=([java.lang.Class, java.lang.reflect.Method, java.lang.Object[]], java.lang.Object), getLength-Arr-var2723-1=([java.lang.Object[]], int), var3248_isEmpty/-1493248066=([java.util.Set], boolean), cast-from-var1486-to-var3248=([java.util.HashSet], java.util.Set)}
; {var3185=org.apache.dubbo.validation.support.jvalidation.JValidatorNew, var1346=r1, var1063=r2, var2159=null_type, var1678=r4, var2723=java.lang.Object, var601=r10, var3573=java.util.ArrayList, var3870=$r44, var2981=r3, var1749=$r5, var3676=java.lang.reflect.Method, var2239=$r43, var2014=org.apache.dubbo.validation.MethodValidated, var811=java.lang.reflect.AccessibleObject, var2538=$z0, var1197=java.util.List, var2470=jakarta.validation.groups.Default, var3553=0, var1754=class "Ljakarta/validation/groups/Default;", var932=$r6, var2271=1, var2045=$r7, var3965=$r8, var3008=$r41, var1486=java.util.HashSet, var1414=$r45, var1702=$r11, var1061=$r42, var46=$i0, var2483=i1, var3248=java.util.Set, var2487=$z1}
; {org.apache.dubbo.validation.support.jvalidation.JValidatorNew=var3185, r1=var1346, r2=var1063, null_type=var2159, r4=var1678, java.lang.Object=var2723, r10=var601, java.util.ArrayList=var3573, $r44=var3870, r3=var2981, $r5=var1749, java.lang.reflect.Method=var3676, $r43=var2239, org.apache.dubbo.validation.MethodValidated=var2014, java.lang.reflect.AccessibleObject=var811, $z0=var2538, java.util.List=var1197, jakarta.validation.groups.Default=var2470, 0=var3553, class "Ljakarta/validation/groups/Default;"=var1754, $r6=var932, 1=var2271, $r7=var2045, $r8=var3965, $r41=var3008, java.util.HashSet=var1486, $r45=var1414, $r11=var1702, $r42=var1061, $i0=var46, i1=var2483, java.util.Set=var3248, $z1=var2487}
;seq 
;cnt {}
;stmts r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew;	r2 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.Class[];	r10 := @parameter2: java.lang.Object[];	$r44 = new java.util.ArrayList;	specialinvoke $r44.<java.util.ArrayList: void <init>()>();	r3 = specialinvoke r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class methodClass(java.lang.String)>(r2);	if r3 == null goto $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	$r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	$r43 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r4);	$z0 = virtualinvoke $r43.<java.lang.reflect.Method: boolean isAnnotationPresent(java.lang.Class)>(class "Lorg/apache/dubbo/validation/MethodValidated;");	if $z0 == 0 goto interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljakarta/validation/groups/Default;");	interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljakarta/validation/groups/Default;");	$r6 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(1, $r6);	$r7 = newarray (java.lang.Class)[0];	$r8 = interfaceinvoke $r44.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r7);	$r41 = (java.lang.Class[]) $r8;	$r45 = new java.util.HashSet;	specialinvoke $r45.<java.util.HashSet: void <init>()>();	$r11 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	$r42 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Object getMethodParameterBean(java.lang.Class,java.lang.reflect.Method,java.lang.Object[])>($r11, $r43, r10);	if $r42 == null goto $i0 = lengthof r10;	$i0 = lengthof r10;	i1 = 0;	if i1 >= $i0 goto $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>();	$z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>();	if $z1 != 0 goto return;	return
;block_num 7
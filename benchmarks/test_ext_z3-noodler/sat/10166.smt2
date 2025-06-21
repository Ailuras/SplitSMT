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

(declare-sort var215 0)
(declare-sort var3003 0)
(declare-sort var3875 0)
(declare-sort var3027 0)
(declare-sort var3495 0)
(declare-sort var1313 0)
(declare-sort var3986 0)
(declare-sort var2785 0)
(declare-sort var2106 0)
(declare-sort var2564 0)
(declare-sort var3802 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1313!class ClassObject)
(declare-const var2106!class ClassObject)
(declare-fun var3027-init () var3027)
(declare-fun <init>/-325640736 (var3027) void)
(declare-fun methodClass/-1467360182 (var215 String) ClassObject)
(declare-fun clazz/1671654241 (var215) ClassObject)
(declare-fun getMethod/1303228849 (ClassObject String (Array Int ClassObject)) var3495)
(declare-fun isAnnotationPresent/-773395105 (var3986 ClassObject) Bool)
(declare-fun cast-from-var3495-to-var3986 (var3495) var3986)
(declare-fun var2785_add/1157925656 (var2785 Int var3875) void)
(declare-fun cast-from-var3027-to-var2785 (var3027) var2785)
(declare-fun cast-from-ClassObject-to-var3875 (ClassObject) var3875)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun var2785_toArray/-775711681 (var2785 (Array Int var3875)) (Array Int var3875))
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3875__ ((Array Int ClassObject)) (Array Int var3875))
(declare-fun cast-from-__Array__Int__var3875__-to-__Array__Int__ClassObject__ ((Array Int var3875)) (Array Int ClassObject))
(declare-fun var2564-init () var2564)
(declare-fun <init>/451842749 (var2564) void)
(declare-fun var215_getMethodParameterBean/781353740 (ClassObject var3495 (Array Int var3875)) var3875)
(declare-fun getLength-Arr-var3875-1 ((Array Int var3875)) Int)
(declare-fun var3802_isEmpty/-1493248066 (var3802) Bool)
(declare-fun cast-from-var2564-to-var3802 (var2564) var3802)
(declare-const null-var215 var215)
(declare-const null-String String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-__Array__Int__var3875__ (Array Int var3875))
(declare-const null-ClassObject ClassObject)
(declare-const null-var3875 var3875)
(declare-const var1583 var215) ; Statement: r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidator 
(assert (not (= var1583 null-var215)))
(declare-const var2164 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2164 null-String)))
(declare-const var463 (Array Int ClassObject)) ; Statement: r4 := @parameter1: java.lang.Class[] 
(assert (not (= var463 null-__Array__Int__ClassObject__)))
(declare-const var1599 (Array Int var3875)) ; Statement: r10 := @parameter2: java.lang.Object[] 
(assert (not (= var1599 null-__Array__Int__var3875__)))
(define-const var570 var3027 var3027-init) ; Statement: $r44 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var570)) ; Statement: specialinvoke $r44.<java.util.ArrayList: void <init>()>() 

(declare-const var570!1 var3027)
(assert true)
(define-const var255 ClassObject (methodClass/-1467360182 var1583 var2164)) ; Statement: r3 = specialinvoke r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class methodClass(java.lang.String)>(r2) 
 ; Statement: if r3 == null goto $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
(assert (= var255 null-ClassObject)) ; Cond: r3 == null 
(define-const var3167 ClassObject (clazz/1671654241 var1583)) ; Statement: $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
(assert true)
(define-const var3812 var3495 (getMethod/1303228849 var3167 var2164 var463)) ; Statement: $r43 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r4) 
(assert true)
(define-const var2273 Bool (isAnnotationPresent/-773395105 (cast-from-var3495-to-var3986 var3812) var1313!class)) ; Statement: $z0 = virtualinvoke $r43.<java.lang.reflect.Method: boolean isAnnotationPresent(java.lang.Class)>(class "Lorg/apache/dubbo/validation/MethodValidated;") 
 ; Statement: if $z0 == 0 goto interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljavax/validation/groups/Default;") 
(assert (= (ite var2273 1 0) 0)) ; Cond: $z0 == 0 
;(assert (var2785_add/1157925656 (cast-from-var3027-to-var2785 var570!1) 0 (cast-from-ClassObject-to-var3875 var2106!class))) ; Statement: interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljavax/validation/groups/Default;") 

(declare-const var570!2 var3027)
(declare-const var1928 Int)
(declare-const var1845 ClassObject)
(define-const var1818 ClassObject (clazz/1671654241 var1583)) ; Statement: $r6 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
;(assert (var2785_add/1157925656 (cast-from-var3027-to-var2785 var570!2) 1 (cast-from-ClassObject-to-var3875 var1818))) ; Statement: interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(1, $r6) 

(declare-const var570!3 var3027)
(declare-const var1158 Int)
(declare-const var1818!1 ClassObject)
(define-const var1182 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r7 = newarray (java.lang.Class)[0] 
(define-const var3644 (Array Int var3875) (var2785_toArray/-775711681 (cast-from-var3027-to-var2785 var570!3) (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3875__ var1182))) ; Statement: $r8 = interfaceinvoke $r44.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r7) 
(define-const var2738 (Array Int ClassObject) (cast-from-__Array__Int__var3875__-to-__Array__Int__ClassObject__ var3644)) ; Statement: $r41 = (java.lang.Class[]) $r8 
(define-const var3678 var2564 var2564-init) ; Statement: $r45 = new java.util.HashSet 
(assert true)
;(assert (<init>/451842749 var3678)) ; Statement: specialinvoke $r45.<java.util.HashSet: void <init>()>() 

(declare-const var3678!1 var2564)
(define-const var508 ClassObject (clazz/1671654241 var1583)) ; Statement: $r11 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> 
(define-const var2637 var3875 (var215_getMethodParameterBean/781353740 var508 var3812 var1599)) ; Statement: $r42 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Object getMethodParameterBean(java.lang.Class,java.lang.reflect.Method,java.lang.Object[])>($r11, $r43, r10) 
 ; Statement: if $r42 == null goto $i0 = lengthof r10 
(assert (= var2637 null-var3875)) ; Cond: $r42 == null 
(define-const var1753 Int (getLength-Arr-var3875-1 var1599)) ; Statement: $i0 = lengthof r10 
(define-const var3855 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>() 
(assert (>= var3855 var1753)) ; Cond: i1 >= $i0 
(define-const var3388 Bool (var3802_isEmpty/-1493248066 (cast-from-var2564-to-var3802 var3678!1))) ; Statement: $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>() 
 ; Statement: if $z1 != 0 goto return 
(assert (not (= (ite var3388 1 0) 0))) ; Cond: $z1 != 0 
 ; Statement: return 
(check-sat)
; {var3027-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), methodClass/-1467360182=([org.apache.dubbo.validation.support.jvalidation.JValidator, java.lang.String], java.lang.Class), clazz/1671654241=([org.apache.dubbo.validation.support.jvalidation.JValidator], java.lang.Class), getMethod/1303228849=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method), isAnnotationPresent/-773395105=([java.lang.reflect.AccessibleObject, java.lang.Class], boolean), cast-from-var3495-to-var3986=([java.lang.reflect.Method], java.lang.reflect.AccessibleObject), var2785_add/1157925656=([java.util.List, int, java.lang.Object], void), cast-from-var3027-to-var2785=([java.util.ArrayList], java.util.List), cast-from-ClassObject-to-var3875=([java.lang.Class], java.lang.Object), arr-ClassObject-init=([], java.lang.Class[]), var2785_toArray/-775711681=([java.util.List, java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3875__=([java.lang.Class[]], java.lang.Object[]), cast-from-__Array__Int__var3875__-to-__Array__Int__ClassObject__=([java.lang.Object[]], java.lang.Class[]), var2564-init=([], java.util.HashSet), <init>/451842749=([java.util.HashSet], void), var215_getMethodParameterBean/781353740=([java.lang.Class, java.lang.reflect.Method, java.lang.Object[]], java.lang.Object), getLength-Arr-var3875-1=([java.lang.Object[]], int), var3802_isEmpty/-1493248066=([java.util.Set], boolean), cast-from-var2564-to-var3802=([java.util.HashSet], java.util.Set)}
; {var215=org.apache.dubbo.validation.support.jvalidation.JValidator, var1583=r1, var2164=r2, var3003=null_type, var463=r4, var3875=java.lang.Object, var1599=r10, var3027=java.util.ArrayList, var570=$r44, var255=r3, var3167=$r5, var3495=java.lang.reflect.Method, var3812=$r43, var1313=org.apache.dubbo.validation.MethodValidated, var3986=java.lang.reflect.AccessibleObject, var2273=$z0, var2785=java.util.List, var2106=javax.validation.groups.Default, var1928=0, var1845=class "Ljavax/validation/groups/Default;", var1818=$r6, var1158=1, var1182=$r7, var3644=$r8, var2738=$r41, var2564=java.util.HashSet, var3678=$r45, var508=$r11, var2637=$r42, var1753=$i0, var3855=i1, var3802=java.util.Set, var3388=$z1}
; {org.apache.dubbo.validation.support.jvalidation.JValidator=var215, r1=var1583, r2=var2164, null_type=var3003, r4=var463, java.lang.Object=var3875, r10=var1599, java.util.ArrayList=var3027, $r44=var570, r3=var255, $r5=var3167, java.lang.reflect.Method=var3495, $r43=var3812, org.apache.dubbo.validation.MethodValidated=var1313, java.lang.reflect.AccessibleObject=var3986, $z0=var2273, java.util.List=var2785, javax.validation.groups.Default=var2106, 0=var1928, class "Ljavax/validation/groups/Default;"=var1845, $r6=var1818, 1=var1158, $r7=var1182, $r8=var3644, $r41=var2738, java.util.HashSet=var2564, $r45=var3678, $r11=var508, $r42=var2637, $i0=var1753, i1=var3855, java.util.Set=var3802, $z1=var3388}
;seq 
;cnt {}
;stmts r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidator;	r2 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.Class[];	r10 := @parameter2: java.lang.Object[];	$r44 = new java.util.ArrayList;	specialinvoke $r44.<java.util.ArrayList: void <init>()>();	r3 = specialinvoke r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class methodClass(java.lang.String)>(r2);	if r3 == null goto $r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	$r5 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	$r43 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r4);	$z0 = virtualinvoke $r43.<java.lang.reflect.Method: boolean isAnnotationPresent(java.lang.Class)>(class "Lorg/apache/dubbo/validation/MethodValidated;");	if $z0 == 0 goto interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljavax/validation/groups/Default;");	interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(0, class "Ljavax/validation/groups/Default;");	$r6 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	interfaceinvoke $r44.<java.util.List: void add(int,java.lang.Object)>(1, $r6);	$r7 = newarray (java.lang.Class)[0];	$r8 = interfaceinvoke $r44.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r7);	$r41 = (java.lang.Class[]) $r8;	$r45 = new java.util.HashSet;	specialinvoke $r45.<java.util.HashSet: void <init>()>();	$r11 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz>;	$r42 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Object getMethodParameterBean(java.lang.Class,java.lang.reflect.Method,java.lang.Object[])>($r11, $r43, r10);	if $r42 == null goto $i0 = lengthof r10;	$i0 = lengthof r10;	i1 = 0;	if i1 >= $i0 goto $z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>();	$z1 = interfaceinvoke $r45.<java.util.Set: boolean isEmpty()>();	if $z1 != 0 goto return;	return
;block_num 7
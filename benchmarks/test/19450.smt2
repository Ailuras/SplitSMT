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

(declare-sort var3455 0)
(declare-sort var419 0)
(declare-sort var2870 0)
(declare-sort var1405 0)
(declare-sort var1304 0)
(declare-sort var2498 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun methods/2091696613 (var3455) (Array Int var1405))
(declare-fun getLength-Arr-var1405-1 ((Array Int var1405)) Int)
(declare-fun var1304-init () var1304)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var419) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2498_toString/-575966009 ((Array Int var419)) String)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var419__ ((Array Int ClassObject)) (Array Int var419))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-966825728 (var1304 String) void)
(declare-const null-var3455 var3455)
(declare-const null-var419 var419)
(declare-const null-String String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-__Array__Int__var419__ (Array Int var419))
(declare-const var529 var3455) ; Statement: r0 := @this: org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker 
(assert (not (= var529 null-var3455)))
(declare-const var104 var419) ; Statement: r4 := @parameter0: java.lang.Object 
(assert (not (= var104 null-var419)))
(declare-const var981 String) ; Statement: r8 := @parameter1: java.lang.String 
(assert (not (= var981 null-String)))
(declare-const var1780 (Array Int ClassObject)) ; Statement: r10 := @parameter2: java.lang.Class[] 
(assert (not (= var1780 null-__Array__Int__ClassObject__)))
(declare-const var690 (Array Int var419)) ; Statement: r17 := @parameter3: java.lang.Object[] 
(assert (not (= var690 null-__Array__Int__var419__)))
(define-const var3400 (Array Int var1405) (methods/2091696613 var529)) ; Statement: r1 = r0.<org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker: org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker$MethodMeta[] methods> 
(define-const var1499 Int (getLength-Arr-var1405-1 var3400)) ; Statement: i0 = lengthof r1 
(define-const var619 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r2 = new java.lang.NoSuchMethodException 
(assert (>= var619 var1499)) ; Cond: i1 >= i0 
(define-const var1968 var1304 var1304-init) ; Statement: $r2 = new java.lang.NoSuchMethodException 
(define-const var1618 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1618)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1618!1 String)
(assert (= var1618!1 ""))
(assert true)
(define-const var1347 ClassObject (getClass/1258963082 var104)) ; Statement: $r5 = virtualinvoke r4.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1723 String (getName/-1958580599 var1347)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var465 String (append/672562846 var1618!1 var1723)) ; Statement: $r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1618!2 String)
(assert (= var1618!2 (str.++ var1618!1 var1723)))
(assert true)
(define-const var1083 String (append/672562846 var465 ".")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var465!1 String)
(assert (= var465!1 (str.++ var465 ".")))
(assert true)
(define-const var3133 String (append/672562846 var1083 var981)) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var1083!1 String)
(assert (= var1083!1 (str.++ var1083 var981)))
(define-const var1984 String (var2498_toString/-575966009 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var419__ var1780))) ; Statement: $r11 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r10) 
(assert true)
(define-const var1423 String (append/672562846 var3133 var1984)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3133!1 String)
(assert (= var3133!1 (str.++ var3133 var1984)))
(assert true)
(define-const var3612 String (toString/-2075883882 var1423)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-966825728 var1968 var3612)) ; Statement: specialinvoke $r2.<java.lang.NoSuchMethodException: void <init>(java.lang.String)>($r14) 

(declare-const var1968!1 var1304)
(declare-const var3612!1 String)
 ; Statement: throw $r2 
(check-sat)
; {methods/2091696613=([org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker], org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker$MethodMeta[]), getLength-Arr-var1405-1=([org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker$MethodMeta[]], int), var1304-init=([], java.lang.NoSuchMethodException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2498_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var419__=([java.lang.Class[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-966825728=([java.lang.NoSuchMethodException, java.lang.String], void)}
; {var3455=org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker, var529=r0, var419=java.lang.Object, var104=r4, var981=r8, var2870=null_type, var1780=r10, var690=r17, var1405=org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker$MethodMeta, var3400=r1, var1499=i0, var619=i1, var1304=java.lang.NoSuchMethodException, var1968=$r2, var1618=$r3, var1347=$r5, var1723=$r6, var465=$r7, var1083=$r9, var3133=$r12, var2498=java.util.Arrays, var1984=$r11, var1423=$r13, var3612=$r14}
; {org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker=var3455, r0=var529, java.lang.Object=var419, r4=var104, r8=var981, null_type=var2870, r10=var1780, r17=var690, org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker$MethodMeta=var1405, r1=var3400, i0=var1499, i1=var619, java.lang.NoSuchMethodException=var1304, $r2=var1968, $r3=var1618, $r5=var1347, $r6=var1723, $r7=var465, $r9=var1083, $r12=var3133, java.util.Arrays=var2498, $r11=var1984, $r13=var1423, $r14=var3612}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker;	r4 := @parameter0: java.lang.Object;	r8 := @parameter1: java.lang.String;	r10 := @parameter2: java.lang.Class[];	r17 := @parameter3: java.lang.Object[];	r1 = r0.<org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker: org.apache.dubbo.rpc.proxy.MethodInvoker$OverloadMethodInvoker$MethodMeta[] methods>;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto $r2 = new java.lang.NoSuchMethodException;	$r2 = new java.lang.NoSuchMethodException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke r4.<java.lang.Object: java.lang.Class getClass()>();	$r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>();	$r7 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r11 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.NoSuchMethodException: void <init>(java.lang.String)>($r14);	throw $r2
;block_num 3
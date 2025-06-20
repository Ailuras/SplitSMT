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

(declare-sort var2197 0)
(declare-sort var2665 0)
(declare-sort var3618 0)
(declare-sort var2321 0)
(declare-sort var2041 0)
(declare-sort var3482 0)
(declare-sort var1114 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun invokers/-1714667604 (var2197) var2321)
(declare-fun var2321_get/1088891777 (var2321 var2665) var2665)
(declare-fun cast-from-String-to-var2665 (String) var2665)
(declare-fun cast-from-var2665-to-var2041 (var2665) var2041)
(declare-fun var3482-init () var3482)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var2665) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1114_toString/-575966009 ((Array Int var2665)) String)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2665__ ((Array Int ClassObject)) (Array Int var2665))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-966825728 (var3482 String) void)
(declare-const null-var2197 var2197)
(declare-const null-var2665 var2665)
(declare-const null-String String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-__Array__Int__var2665__ (Array Int var2665))
(declare-const null-var2041 var2041)
(declare-const var1579 var2197) ; Statement: r0 := @this: org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker 
(assert (not (= var1579 null-var2197)))
(declare-const var1728 var2665) ; Statement: r5 := @parameter0: java.lang.Object 
(assert (not (= var1728 null-var2665)))
(declare-const var326 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var326 null-String)))
(declare-const var3209 (Array Int ClassObject)) ; Statement: r6 := @parameter2: java.lang.Class[] 
(assert (not (= var3209 null-__Array__Int__ClassObject__)))
(declare-const var2232 (Array Int var2665)) ; Statement: r7 := @parameter3: java.lang.Object[] 
(assert (not (= var2232 null-__Array__Int__var2665__)))
(define-const var475 var2321 (invokers/-1714667604 var1579)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker: java.util.Map invokers> 
(define-const var3762 var2665 (var2321_get/1088891777 var475 (cast-from-String-to-var2665 var326))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var559 var2041 (cast-from-var2665-to-var2041 var3762)) ; Statement: r4 = (org.apache.dubbo.rpc.proxy.MethodInvoker) $r3 
 ; Statement: if r4 != null goto $r8 = interfaceinvoke r4.<org.apache.dubbo.rpc.proxy.MethodInvoker: java.lang.Object invoke(java.lang.Object,java.lang.String,java.lang.Class[],java.lang.Object[])>(r5, r1, r6, r7) 
(assert (not (not (= var559 null-var2041)))) ; Negate: Cond: r4 != null  
(define-const var3325 var3482 var3482-init) ; Statement: $r9 = new java.lang.NoSuchMethodException 
(define-const var3756 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3756)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3756!1 String)
(assert (= var3756!1 ""))
(assert true)
(define-const var2247 ClassObject (getClass/1258963082 var1728)) ; Statement: $r11 = virtualinvoke r5.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1725 String (getName/-1958580599 var2247)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1097 String (append/672562846 var3756!1 var1725)) ; Statement: $r13 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var3756!2 String)
(assert (= var3756!2 (str.++ var3756!1 var1725)))
(assert true)
(define-const var2814 String (append/672562846 var1097 ".")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var1097!1 String)
(assert (= var1097!1 (str.++ var1097 ".")))
(assert true)
(define-const var3014 String (append/672562846 var2814 var326)) ; Statement: $r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2814!1 String)
(assert (= var2814!1 (str.++ var2814 var326)))
(define-const var3665 String (var1114_toString/-575966009 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2665__ var3209))) ; Statement: $r15 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r6) 
(assert true)
(define-const var3100 String (append/672562846 var3014 var3665)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var3014!1 String)
(assert (= var3014!1 (str.++ var3014 var3665)))
(assert true)
(define-const var1125 String (toString/-2075883882 var3100)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-966825728 var3325 var1125)) ; Statement: specialinvoke $r9.<java.lang.NoSuchMethodException: void <init>(java.lang.String)>($r18) 

(declare-const var3325!1 var3482)
(declare-const var1125!1 String)
 ; Statement: throw $r9 
(check-sat)
; {invokers/-1714667604=([org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker], java.util.Map), var2321_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2665=([java.lang.String], java.lang.Object), cast-from-var2665-to-var2041=([java.lang.Object], org.apache.dubbo.rpc.proxy.MethodInvoker), var3482-init=([], java.lang.NoSuchMethodException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1114_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2665__=([java.lang.Class[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-966825728=([java.lang.NoSuchMethodException, java.lang.String], void)}
; {var2197=org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker, var1579=r0, var2665=java.lang.Object, var1728=r5, var326=r1, var3618=null_type, var3209=r6, var2232=r7, var2321=java.util.Map, var475=$r2, var3762=$r3, var2041=org.apache.dubbo.rpc.proxy.MethodInvoker, var559=r4, var3482=java.lang.NoSuchMethodException, var3325=$r9, var3756=$r10, var2247=$r11, var1725=$r12, var1097=$r13, var2814=$r14, var3014=$r16, var1114=java.util.Arrays, var3665=$r15, var3100=$r17, var1125=$r18}
; {org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker=var2197, r0=var1579, java.lang.Object=var2665, r5=var1728, r1=var326, null_type=var3618, r6=var3209, r7=var2232, java.util.Map=var2321, $r2=var475, $r3=var3762, org.apache.dubbo.rpc.proxy.MethodInvoker=var2041, r4=var559, java.lang.NoSuchMethodException=var3482, $r9=var3325, $r10=var3756, $r11=var2247, $r12=var1725, $r13=var1097, $r14=var2814, $r16=var3014, java.util.Arrays=var1114, $r15=var3665, $r17=var3100, $r18=var1125}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker;	r5 := @parameter0: java.lang.Object;	r1 := @parameter1: java.lang.String;	r6 := @parameter2: java.lang.Class[];	r7 := @parameter3: java.lang.Object[];	$r2 = r0.<org.apache.dubbo.rpc.proxy.MethodInvoker$CompositeMethodInvoker: java.util.Map invokers>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r4 = (org.apache.dubbo.rpc.proxy.MethodInvoker) $r3;	if r4 != null goto $r8 = interfaceinvoke r4.<org.apache.dubbo.rpc.proxy.MethodInvoker: java.lang.Object invoke(java.lang.Object,java.lang.String,java.lang.Class[],java.lang.Object[])>(r5, r1, r6, r7);	$r9 = new java.lang.NoSuchMethodException;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke r5.<java.lang.Object: java.lang.Class getClass()>();	$r12 = virtualinvoke $r11.<java.lang.Class: java.lang.String getName()>();	$r13 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r15 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r6);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r9.<java.lang.NoSuchMethodException: void <init>(java.lang.String)>($r18);	throw $r9
;block_num 2
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

(declare-sort var385 0)
(declare-sort var943 0)
(declare-sort var40 0)
(declare-sort var165 0)
(declare-sort var3309 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var385_modifier/746398253 (Int) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var40_getName/715767591 (ClassObject) String)
(declare-fun var165_isNotEmpty/-1514399294 ((Array Int var3309)) Bool)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3309__ ((Array Int ClassObject)) (Array Int var3309))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun addMethod/-429150454 (var385 String) var385)
(declare-const null-var385 var385)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-ClassObject ClassObject)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const var3851 var385) ; Statement: r14 := @this: org.apache.dubbo.common.bytecode.ClassGenerator 
(assert (not (= var3851 null-var385)))
(declare-const var1366 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var1366 null-String)))
(declare-const var1364 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1364 null-Int)))
(declare-const var1590 ClassObject) ; Statement: r3 := @parameter2: java.lang.Class 
(assert (not (= var1590 null-ClassObject)))
(declare-const var1641 (Array Int ClassObject)) ; Statement: r9 := @parameter3: java.lang.Class[] 
(assert (not (= var1641 null-__Array__Int__ClassObject__)))
(declare-const var3610 (Array Int ClassObject)) ; Statement: r10 := @parameter4: java.lang.Class[] 
(assert (not (= var3610 null-__Array__Int__ClassObject__)))
(declare-const var1953 String) ; Statement: r11 := @parameter5: java.lang.String 
(assert (not (= var1953 null-String)))
(define-const var581 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var581)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var581!1 String)
(assert (= var581!1 ""))
(define-const var2541 String (var385_modifier/746398253 var1364)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: java.lang.String modifier(int)>(i0) 
(assert true)
(define-const var2278 String (append/672562846 var581!1 var2541)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1) 
(declare-const var581!2 String)
(assert (= var581!2 (str.++ var581!1 var2541)))
(assert true)
(define-const var2409 String (append/-1166366385 var2278 32)) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var2278!1 String)
(assert (str.prefixof var2278 var2278!1))
(define-const var1323 String (var40_getName/715767591 var1590)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>(r3) 
(assert true)
(define-const var458 String (append/672562846 var2409 var1323)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2409!1 String)
(assert (= var2409!1 (str.++ var2409 var1323)))
(assert true)
(define-const var1536 String (append/-1166366385 var458 32)) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var458!1 String)
(assert (str.prefixof var458 var458!1))
(assert true)
;(assert (append/672562846 var1536 var1366)) ; Statement: virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var1536!1 String)
(assert (= var1536!1 (str.++ var1536 var1366)))
(assert true)
;(assert (append/-1166366385 var581!2 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var581!3 String)
(assert (str.prefixof var581!2 var581!3))
(define-const var887 Bool (var165_isNotEmpty/-1514399294 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3309__ var1641))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r9) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (= (ite var887 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/-1166366385 var581!3 41)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var581!4 String)
(assert (str.prefixof var581!3 var581!4))
(define-const var2957 Bool (var165_isNotEmpty/-1514399294 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3309__ var3610))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r10) 
 ; Statement: if $z1 == 0 goto $r12 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(123) 
(assert (= (ite var2957 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var2336 String (append/-1166366385 var581!4 123)) ; Statement: $r12 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(123) 
(declare-const var581!5 String)
(assert (str.prefixof var581!4 var581!5))
(assert true)
(define-const var981 String (append/672562846 var2336 var1953)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11) 
(declare-const var2336!1 String)
(assert (= var2336!1 (str.++ var2336 var1953)))
(assert true)
;(assert (append/-1166366385 var981 125)) ; Statement: virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var981!1 String)
(assert (str.prefixof var981 var981!1))
(assert true)
(define-const var3515 String (toString/-2075883882 var581!5)) ; Statement: $r15 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var225 var385 (addMethod/-429150454 var3851 var3515)) ; Statement: $r16 = virtualinvoke r14.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addMethod(java.lang.String)>($r15) 
 ; Statement: return $r16 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var385_modifier/746398253=([int], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var40_getName/715767591=([java.lang.Class], java.lang.String), var165_isNotEmpty/-1514399294=([java.lang.Object[]], boolean), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3309__=([java.lang.Class[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), addMethod/-429150454=([org.apache.dubbo.common.bytecode.ClassGenerator, java.lang.String], org.apache.dubbo.common.bytecode.ClassGenerator)}
; {var385=org.apache.dubbo.common.bytecode.ClassGenerator, var3851=r14, var1366=r7, var943=null_type, var1364=i0, var1590=r3, var1641=r9, var3610=r10, var1953=r11, var581=$r0, var2541=$r1, var2278=$r2, var2409=$r5, var40=org.apache.dubbo.common.utils.ReflectUtils, var1323=$r4, var458=$r6, var1536=$r8, var165=org.apache.dubbo.common.utils.ArrayUtils, var3309=java.lang.Object, var887=$z0, var2957=$z1, var2336=$r12, var981=$r13, var3515=$r15, var225=$r16}
; {org.apache.dubbo.common.bytecode.ClassGenerator=var385, r14=var3851, r7=var1366, null_type=var943, i0=var1364, r3=var1590, r9=var1641, r10=var3610, r11=var1953, $r0=var581, $r1=var2541, $r2=var2278, $r5=var2409, org.apache.dubbo.common.utils.ReflectUtils=var40, $r4=var1323, $r6=var458, $r8=var1536, org.apache.dubbo.common.utils.ArrayUtils=var165, java.lang.Object=var3309, $z0=var887, $z1=var2957, $r12=var2336, $r13=var981, $r15=var3515, $r16=var225}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r14 := @this: org.apache.dubbo.common.bytecode.ClassGenerator;	r7 := @parameter0: java.lang.String;	i0 := @parameter1: int;	r3 := @parameter2: java.lang.Class;	r9 := @parameter3: java.lang.Class[];	r10 := @parameter4: java.lang.Class[];	r11 := @parameter5: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: java.lang.String modifier(int)>(i0);	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1);	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$z0 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r9);	if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$z1 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r10);	if $z1 == 0 goto $r12 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(123);	$r12 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(123);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11);	virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r15 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r16 = virtualinvoke r14.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addMethod(java.lang.String)>($r15);	return $r16
;block_num 3
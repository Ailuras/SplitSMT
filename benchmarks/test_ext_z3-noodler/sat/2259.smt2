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

(declare-sort var2061 0)
(declare-sort var2507 0)
(declare-sort var2581 0)
(declare-sort var1718 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2581!class ClassObject)
(declare-const var1718!class ClassObject)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun arr-var2507-init () (Array Int var2507))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var2507 (String) var2507)
(declare-fun String_format/1339386452 (String (Array Int var2507)) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2061 var2061)
(declare-const null-__Array__Int__var2507__ (Array Int var2507))
(declare-const var411 var2061) ; Statement: r10 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var411 null-var2061)))
(define-const var2631 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2631)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2631!1 String)
(assert (= var2631!1 ""))
(define-const var2296 (Array Int var2507) arr-var2507-init) ; Statement: $r1 = newarray (java.lang.Object)[1] 
(define-const var273 ClassObject var2581!class) ; Statement: $r2 = class "Lorg/apache/dubbo/rpc/model/ScopeModel;" 
(assert true)
(define-const var3515 String (getName/-1958580599 var273)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2296!1 (Array Int var2507))
(assert (not (= var2296!1 null-__Array__Int__var2507__)))
(assert (= (select var2296!1 0) (cast-from-String-to-var2507 var3515))) ; Statement: $r1[0] = $r3 
(define-const var388 String (String_format/1339386452 "import %s;\n" var2296!1)) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("import %s;\n", $r1) 
(assert true)
;(assert (append/672562846 var2631!1 var388)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2631!2 String)
(assert (= var2631!2 (str.++ var2631!1 var388)))
(define-const var813 (Array Int var2507) arr-var2507-init) ; Statement: $r5 = newarray (java.lang.Object)[1] 
(define-const var2648 ClassObject var1718!class) ; Statement: $r6 = class "Lorg/apache/dubbo/rpc/model/ScopeModelUtil;" 
(assert true)
(define-const var1445 String (getName/-1958580599 var2648)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>() 
(declare-const var813!1 (Array Int var2507))
(assert (not (= var813!1 null-__Array__Int__var2507__)))
(assert (= (select var813!1 0) (cast-from-String-to-var2507 var1445))) ; Statement: $r5[0] = $r7 
(define-const var2466 String (String_format/1339386452 "import %s;\n" var813!1)) ; Statement: $r8 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("import %s;\n", $r5) 
(assert true)
;(assert (append/672562846 var2631!2 var2466)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var2631!3 String)
(assert (= var2631!3 (str.++ var2631!2 var2466)))
(assert true)
(define-const var3597 String (toString/-2075883882 var2631!3)) ; Statement: $r9 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), arr-var2507-init=([], java.lang.Object[]), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var2507=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2061=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var411=r10, var2631=$r0, var2507=java.lang.Object, var2296=$r1, var2581=org.apache.dubbo.rpc.model.ScopeModel, var273=$r2, var3515=$r3, var388=$r4, var813=$r5, var1718=org.apache.dubbo.rpc.model.ScopeModelUtil, var2648=$r6, var1445=$r7, var2466=$r8, var3597=$r9}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var2061, r10=var411, $r0=var2631, java.lang.Object=var2507, $r1=var2296, org.apache.dubbo.rpc.model.ScopeModel=var2581, $r2=var273, $r3=var3515, $r4=var388, $r5=var813, org.apache.dubbo.rpc.model.ScopeModelUtil=var1718, $r6=var2648, $r7=var1445, $r8=var2466, $r9=var3597}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = newarray (java.lang.Object)[1];	$r2 = class "Lorg/apache/dubbo/rpc/model/ScopeModel;";	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r1[0] = $r3;	$r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("import %s;\n", $r1);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r5 = newarray (java.lang.Object)[1];	$r6 = class "Lorg/apache/dubbo/rpc/model/ScopeModelUtil;";	$r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>();	$r5[0] = $r7;	$r8 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("import %s;\n", $r5);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r9 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1
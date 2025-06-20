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

(declare-sort var1174 0)
(declare-sort var720 0)
(declare-sort var1275 0)
(declare-sort var3166 0)
(declare-sort var921 0)
(declare-sort var1483 0)
(declare-sort var3097 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var720_get/1088891777 (var720 var3166) var3166)
(declare-fun cast-from-String-to-var3166 (String) var3166)
(declare-fun cast-from-var3166-to-var921 (var3166) var921)
(declare-fun var3097-init () var3097)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var3097 String var921) void)
(declare-fun cast-from-var1483-to-var921 (var1483) var921)
(declare-const null-String String)
(declare-const var1275-THROWABLE_MAP var720)
(declare-const null-var921 var921)
(declare-const null-var1483 var1483)
(declare-const var2873 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2873 null-String)))
(define-const var3479 var720 var1275-THROWABLE_MAP) ; Statement: $r1 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map THROWABLE_MAP> 
(define-const var3122 var3166 (var720_get/1088891777 var3479 (cast-from-String-to-var3166 var2873))) ; Statement: $r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>(r0) 
(define-const var2527 var921 (cast-from-var3166-to-var921 var3122)) ; Statement: r3 = (java.lang.Throwable) $r2 
 ; Statement: if r3 == null goto r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r0) 
(assert (not (= var2527 null-var921))) ; Negate: Cond: r3 == null  
(declare-const var2088 var1483) ; Statement: $r10 := @caughtexception 
(assert (not (= var2088 null-var1483)))
(define-const var2207 var3097 var3097-init) ; Statement: $r11 = new org.apache.dubbo.rpc.RpcException 
(define-const var2739 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2739)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2739!1 String)
(assert (= var2739!1 ""))
(assert true)
(define-const var1564 String (append/672562846 var2739!1 "mock throw error :")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("mock throw error :") 
(declare-const var2739!2 String)
(assert (= var2739!2 (str.++ var2739!1 "mock throw error :")))
(assert true)
(define-const var3464 String (append/672562846 var1564 var2873)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1564!1 String)
(assert (= var1564!1 (str.++ var1564 var2873)))
(assert true)
(define-const var1361 String (append/672562846 var3464 " argument error.")) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" argument error.") 
(declare-const var3464!1 String)
(assert (= var3464!1 (str.++ var3464 " argument error.")))
(assert true)
(define-const var1065 String (toString/-2075883882 var1361)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var2207 var1065 (cast-from-var1483-to-var921 var2088))) ; Statement: specialinvoke $r11.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r16, $r10) 

(declare-const var2207!1 var3097)
(declare-const var1065!1 String)
(declare-const var2088!1 var1483)
 ; Statement: throw $r11 
(check-sat)
; {var720_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3166=([java.lang.String], java.lang.Object), cast-from-var3166-to-var921=([java.lang.Object], java.lang.Throwable), var3097-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void), cast-from-var1483-to-var921=([java.lang.Exception], java.lang.Throwable)}
; {var2873=r0, var1174=null_type, var720=java.util.Map, var1275=org.apache.dubbo.rpc.support.MockInvoker, var3479=$r1, var3166=java.lang.Object, var3122=$r2, var921=java.lang.Throwable, var2527=r3, var1483=java.lang.Exception, var2088=$r10, var3097=org.apache.dubbo.rpc.RpcException, var2207=$r11, var2739=$r12, var1564=$r13, var3464=$r14, var1361=$r15, var1065=$r16}
; {r0=var2873, null_type=var1174, java.util.Map=var720, org.apache.dubbo.rpc.support.MockInvoker=var1275, $r1=var3479, java.lang.Object=var3166, $r2=var3122, java.lang.Throwable=var921, r3=var2527, java.lang.Exception=var1483, $r10=var2088, org.apache.dubbo.rpc.RpcException=var3097, $r11=var2207, $r12=var2739, $r13=var1564, $r14=var3464, $r15=var1361, $r16=var1065}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map THROWABLE_MAP>;	$r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>(r0);	r3 = (java.lang.Throwable) $r2;	if r3 == null goto r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r0);	$r10 := @caughtexception;	$r11 = new org.apache.dubbo.rpc.RpcException;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("mock throw error :");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" argument error.");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r16, $r10);	throw $r11
;block_num 2
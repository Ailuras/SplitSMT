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

(declare-sort var1561 0)
(declare-sort var3157 0)
(declare-sort var290 0)
(declare-sort var2835 0)
(declare-sort var3138 0)
(declare-sort var1093 0)
(declare-sort var1614 0)
(declare-sort var853 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun exporter/1594762807 (var1561) var290)
(declare-fun exporterMap/1594762807 (var1561) var2835)
(declare-fun getUrl/-945338117 (var1093) var3138)
(declare-fun cast-from-var1561-to-var1093 (var1561) var1093)
(declare-fun var1614_getExporter/-1061649167 (var2835 var3138) var290)
(declare-fun var853-init () var853)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun key/1594762807 (var1561) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1520188505 (var853 String) void)
(declare-const null-var1561 var1561)
(declare-const null-var3157 var3157)
(declare-const null-var290 var290)
(declare-const var1375 var1561) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker 
(assert (not (= var1375 null-var1561)))
(declare-const var3914 var3157) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3914 null-var3157)))
(define-const var3505 var290 (exporter/1594762807 var1375)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter> 
(assert (not (not (= var3505 null-var290)))) ; Negate: Cond: $r1 != null  
(define-const var375 var2835 (exporterMap/1594762807 var1375)) ; Statement: $r51 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: java.util.Map exporterMap> 
(assert true)
(define-const var2359 var3138 (getUrl/-945338117 (cast-from-var1561-to-var1093 var1375))) ; Statement: $r52 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var3326 var290 (var1614_getExporter/-1061649167 var375 var2359)) ; Statement: $r53 = staticinvoke <org.apache.dubbo.rpc.protocol.injvm.InjvmProtocol: org.apache.dubbo.rpc.Exporter getExporter(java.util.Map,org.apache.dubbo.common.URL)>($r51, $r52) 
(declare-const var1375!1 var1561)
(assert (not (= var1375!1 null-var1561)))
(assert (= (exporter/1594762807 var1375!1) var3326)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter> = $r53 
(define-const var2487 var290 (exporter/1594762807 var1375!1)) ; Statement: $r54 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter> 
 ; Statement: if $r54 != null goto $r2 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter> 
(assert (not (not (= var2487 null-var290)))) ; Negate: Cond: $r54 != null  
(define-const var1174 var853 var853-init) ; Statement: $r57 = new org.apache.dubbo.rpc.RpcException 
(define-const var3583 String String-init) ; Statement: $r58 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3583)) ; Statement: specialinvoke $r58.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3583!1 String)
(assert (= var3583!1 ""))
(assert true)
(define-const var1546 String (append/672562846 var3583!1 "Service [")) ; Statement: $r60 = virtualinvoke $r58.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service [") 
(declare-const var3583!2 String)
(assert (= var3583!2 (str.++ var3583!1 "Service [")))
(define-const var871 String (key/1594762807 var1375!1)) ; Statement: $r59 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: java.lang.String key> 
(assert true)
(define-const var2415 String (append/672562846 var1546 var871)) ; Statement: $r61 = virtualinvoke $r60.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r59) 
(declare-const var1546!1 String)
(assert (= var1546!1 (str.++ var1546 var871)))
(assert true)
(define-const var3830 String (append/672562846 var2415 "] not found.")) ; Statement: $r62 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] not found.") 
(declare-const var2415!1 String)
(assert (= var2415!1 (str.++ var2415 "] not found.")))
(assert true)
(define-const var3596 String (toString/-2075883882 var3830)) ; Statement: $r63 = virtualinvoke $r62.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1520188505 var1174 var3596)) ; Statement: specialinvoke $r57.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r63) 

(declare-const var1174!1 var853)
(declare-const var3596!1 String)
 ; Statement: throw $r57 
(check-sat)
; {exporter/1594762807=([org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker], org.apache.dubbo.rpc.Exporter), exporterMap/1594762807=([org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker], java.util.Map), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), cast-from-var1561-to-var1093=([org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker], org.apache.dubbo.rpc.protocol.AbstractInvoker), var1614_getExporter/-1061649167=([java.util.Map, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.Exporter), var853-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), key/1594762807=([org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1520188505=([org.apache.dubbo.rpc.RpcException, java.lang.String], void)}
; {var1561=org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker, var1375=r0, var3157=org.apache.dubbo.rpc.Invocation, var3914=r4, var290=org.apache.dubbo.rpc.Exporter, var3505=$r1, var2835=java.util.Map, var375=$r51, var3138=org.apache.dubbo.common.URL, var1093=org.apache.dubbo.rpc.protocol.AbstractInvoker, var2359=$r52, var1614=org.apache.dubbo.rpc.protocol.injvm.InjvmProtocol, var3326=$r53, var2487=$r54, var853=org.apache.dubbo.rpc.RpcException, var1174=$r57, var3583=$r58, var1546=$r60, var871=$r59, var2415=$r61, var3830=$r62, var3596=$r63}
; {org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker=var1561, r0=var1375, org.apache.dubbo.rpc.Invocation=var3157, r4=var3914, org.apache.dubbo.rpc.Exporter=var290, $r1=var3505, java.util.Map=var2835, $r51=var375, org.apache.dubbo.common.URL=var3138, org.apache.dubbo.rpc.protocol.AbstractInvoker=var1093, $r52=var2359, org.apache.dubbo.rpc.protocol.injvm.InjvmProtocol=var1614, $r53=var3326, $r54=var2487, org.apache.dubbo.rpc.RpcException=var853, $r57=var1174, $r58=var3583, $r60=var1546, $r59=var871, $r61=var2415, $r62=var3830, $r63=var3596}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker;	r4 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter>;	$r51 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: java.util.Map exporterMap>;	$r52 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.common.URL getUrl()>();	$r53 = staticinvoke <org.apache.dubbo.rpc.protocol.injvm.InjvmProtocol: org.apache.dubbo.rpc.Exporter getExporter(java.util.Map,org.apache.dubbo.common.URL)>($r51, $r52);	r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter> = $r53;	$r54 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter>;	if $r54 != null goto $r2 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: org.apache.dubbo.rpc.Exporter exporter>;	$r57 = new org.apache.dubbo.rpc.RpcException;	$r58 = new java.lang.StringBuilder;	specialinvoke $r58.<java.lang.StringBuilder: void <init>()>();	$r60 = virtualinvoke $r58.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service [");	$r59 = r0.<org.apache.dubbo.rpc.protocol.injvm.InjvmInvoker: java.lang.String key>;	$r61 = virtualinvoke $r60.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r59);	$r62 = virtualinvoke $r61.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] not found.");	$r63 = virtualinvoke $r62.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r57.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r63);	throw $r57
;block_num 3
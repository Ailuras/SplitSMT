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

(declare-sort var3243 0)
(declare-sort var1498 0)
(declare-sort var147 0)
(declare-sort var1028 0)
(declare-sort var3853 0)
(declare-sort var3594 0)
(declare-sort var3671 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1028-init () var1028)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3853) String)
(declare-fun cast-from-var1498-to-var3853 (var1498) var3853)
(declare-fun getUrl/866469067 (var3594) var1498)
(declare-fun cast-from-var3243-to-var3594 (var3243) var3594)
(declare-fun getMessage/849299655 (var3671) String)
(declare-fun cast-from-var147-to-var3671 (var147) var3671)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var1028 String var3671) void)
(declare-const null-var3243 var3243)
(declare-const null-var1498 var1498)
(declare-const null-var147 var147)
(declare-const var2192 var3243) ; Statement: r3 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2192 null-var3243)))
(declare-const var104 var1498) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var104 null-var1498)))
(define-const var3335 String "provider") ; Statement: $r2 = "provider" 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2970 var147) ; Statement: $r16 := @caughtexception 
(assert (not (= var2970 null-var147)))
(define-const var3581 var1028 var1028-init) ; Statement: $r17 = new org.apache.dubbo.rpc.RpcException 
(define-const var1746 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1746)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1746!1 String)
(assert (= var1746!1 ""))
(assert true)
(define-const var3340 String (append/672562846 var1746!1 "Failed to register ")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to register ") 
(declare-const var1746!2 String)
(assert (= var1746!2 (str.++ var1746!1 "Failed to register ")))
(assert true)
(define-const var360 String (append/-1031950772 var3340 (cast-from-var1498-to-var3853 var104))) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var3340!1 String)
(assert (str.prefixof var3340 var3340!1))
(assert true)
(define-const var2577 String (append/672562846 var360 " to nacos ")) ; Statement: $r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ") 
(declare-const var360!1 String)
(assert (= var360!1 (str.++ var360 " to nacos ")))
(assert true)
(define-const var2086 var1498 (getUrl/866469067 (cast-from-var3243-to-var3594 var2192))) ; Statement: $r21 = virtualinvoke r3.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var215 String (append/-1031950772 var2577 (cast-from-var1498-to-var3853 var2086))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r21) 
(declare-const var2577!1 String)
(assert (str.prefixof var2577 var2577!1))
(assert true)
(define-const var3246 String (append/672562846 var215 ", cause: ")) ; Statement: $r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var215!1 String)
(assert (= var215!1 (str.++ var215 ", cause: ")))
(assert true)
(define-const var2387 String (getMessage/849299655 (cast-from-var147-to-var3671 var2970))) ; Statement: $r24 = virtualinvoke $r16.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var2489 String (append/672562846 var3246 var2387)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24) 
(declare-const var3246!1 String)
(assert (= var3246!1 (str.++ var3246 var2387)))
(assert true)
(define-const var2129 String (toString/-2075883882 var2489)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var3581 var2129 (cast-from-var147-to-var3671 var2970))) ; Statement: specialinvoke $r17.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r27, $r16) 

(declare-const var3581!1 var1028)
(declare-const var2129!1 String)
(declare-const var2970!1 var147)
 ; Statement: throw $r17 
(check-sat)
; {var1028-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1498-to-var3853=([org.apache.dubbo.common.URL], java.lang.Object), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), cast-from-var3243-to-var3594=([org.apache.dubbo.registry.nacos.NacosRegistry], org.apache.dubbo.registry.support.AbstractRegistry), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var147-to-var3671=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var3243=org.apache.dubbo.registry.nacos.NacosRegistry, var2192=r3, var1498=org.apache.dubbo.common.URL, var104=r0, var3335=$r2, var147=java.lang.Exception, var2970=$r16, var1028=org.apache.dubbo.rpc.RpcException, var3581=$r17, var1746=$r18, var3340=$r19, var3853=java.lang.Object, var360=$r20, var2577=$r22, var3594=org.apache.dubbo.registry.support.AbstractRegistry, var2086=$r21, var215=$r23, var3246=$r25, var3671=java.lang.Throwable, var2387=$r24, var2489=$r26, var2129=$r27}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var3243, r3=var2192, org.apache.dubbo.common.URL=var1498, r0=var104, $r2=var3335, java.lang.Exception=var147, $r16=var2970, org.apache.dubbo.rpc.RpcException=var1028, $r17=var3581, $r18=var1746, $r19=var3340, java.lang.Object=var3853, $r20=var360, $r22=var2577, org.apache.dubbo.registry.support.AbstractRegistry=var3594, $r21=var2086, $r23=var215, $r25=var3246, java.lang.Throwable=var3671, $r24=var2387, $r26=var2489, $r27=var2129}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "provider";	$r16 := @caughtexception;	$r17 = new org.apache.dubbo.rpc.RpcException;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to register ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ");	$r21 = virtualinvoke r3.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>();	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r21);	$r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r24 = virtualinvoke $r16.<java.lang.Exception: java.lang.String getMessage()>();	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24);	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r17.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r27, $r16);	throw $r17
;block_num 2
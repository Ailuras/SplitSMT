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

(declare-sort var3210 0)
(declare-sort var1382 0)
(declare-sort var2698 0)
(declare-sort var1053 0)
(declare-sort var3234 0)
(declare-sort var1448 0)
(declare-sort var1024 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1053-init () var1053)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3234) String)
(declare-fun cast-from-var1382-to-var3234 (var1382) var3234)
(declare-fun getUrl/866469067 (var1448) var1382)
(declare-fun cast-from-var3210-to-var1448 (var3210) var1448)
(declare-fun getMessage/849299655 (var1024) String)
(declare-fun cast-from-var2698-to-var1024 (var2698) var1024)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var1053 String var1024) void)
(declare-const null-var3210 var3210)
(declare-const null-var1382 var1382)
(declare-const null-var2698 var2698)
(declare-const var2779 var3210) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2779 null-var3210)))
(declare-const var2695 var1382) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2695 null-var1382)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3821 var2698) ; Statement: $r12 := @caughtexception 
(assert (not (= var3821 null-var2698)))
(define-const var958 var1053 var1053-init) ; Statement: $r13 = new org.apache.dubbo.rpc.RpcException 
(define-const var1564 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1564)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1564!1 String)
(assert (= var1564!1 ""))
(assert true)
(define-const var2004 String (append/672562846 var1564!1 "Failed to unregister ")) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to unregister ") 
(declare-const var1564!2 String)
(assert (= var1564!2 (str.++ var1564!1 "Failed to unregister ")))
(assert true)
(define-const var3358 String (append/-1031950772 var2004 (cast-from-var1382-to-var3234 var2695))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var2004!1 String)
(assert (str.prefixof var2004 var2004!1))
(assert true)
(define-const var3161 String (append/672562846 var3358 " to nacos ")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ") 
(declare-const var3358!1 String)
(assert (= var3358!1 (str.++ var3358 " to nacos ")))
(assert true)
(define-const var3544 var1382 (getUrl/866469067 (cast-from-var3210-to-var1448 var2779))) ; Statement: $r17 = virtualinvoke r0.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var280 String (append/-1031950772 var3161 (cast-from-var1382-to-var3234 var3544))) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r17) 
(declare-const var3161!1 String)
(assert (str.prefixof var3161 var3161!1))
(assert true)
(define-const var477 String (append/672562846 var280 ", cause: ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var280!1 String)
(assert (= var280!1 (str.++ var280 ", cause: ")))
(assert true)
(define-const var1476 String (getMessage/849299655 (cast-from-var2698-to-var1024 var3821))) ; Statement: $r20 = virtualinvoke $r12.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var2955 String (append/672562846 var477 var1476)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20) 
(declare-const var477!1 String)
(assert (= var477!1 (str.++ var477 var1476)))
(assert true)
(define-const var1516 String (toString/-2075883882 var2955)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var958 var1516 (cast-from-var2698-to-var1024 var3821))) ; Statement: specialinvoke $r13.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r23, $r12) 

(declare-const var958!1 var1053)
(declare-const var1516!1 String)
(declare-const var3821!1 var2698)
 ; Statement: throw $r13 
(check-sat)
; {var1053-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1382-to-var3234=([org.apache.dubbo.common.URL], java.lang.Object), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), cast-from-var3210-to-var1448=([org.apache.dubbo.registry.nacos.NacosRegistry], org.apache.dubbo.registry.support.AbstractRegistry), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2698-to-var1024=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var3210=org.apache.dubbo.registry.nacos.NacosRegistry, var2779=r0, var1382=org.apache.dubbo.common.URL, var2695=r1, var2698=java.lang.Exception, var3821=$r12, var1053=org.apache.dubbo.rpc.RpcException, var958=$r13, var1564=$r14, var2004=$r15, var3234=java.lang.Object, var3358=$r16, var3161=$r18, var1448=org.apache.dubbo.registry.support.AbstractRegistry, var3544=$r17, var280=$r19, var477=$r21, var1024=java.lang.Throwable, var1476=$r20, var2955=$r22, var1516=$r23}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var3210, r0=var2779, org.apache.dubbo.common.URL=var1382, r1=var2695, java.lang.Exception=var2698, $r12=var3821, org.apache.dubbo.rpc.RpcException=var1053, $r13=var958, $r14=var1564, $r15=var2004, java.lang.Object=var3234, $r16=var3358, $r18=var3161, org.apache.dubbo.registry.support.AbstractRegistry=var1448, $r17=var3544, $r19=var280, $r21=var477, java.lang.Throwable=var1024, $r20=var1476, $r22=var2955, $r23=var1516}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r12 := @caughtexception;	$r13 = new org.apache.dubbo.rpc.RpcException;	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to unregister ");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ");	$r17 = virtualinvoke r0.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r20 = virtualinvoke $r12.<java.lang.Exception: java.lang.String getMessage()>();	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r13.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r23, $r12);	throw $r13
;block_num 2
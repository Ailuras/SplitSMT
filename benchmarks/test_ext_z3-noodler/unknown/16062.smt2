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

(declare-sort var1400 0)
(declare-sort var481 0)
(declare-sort var2546 0)
(declare-sort var1218 0)
(declare-sort var3548 0)
(declare-sort var1248 0)
(declare-sort var453 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1218-init () var1218)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/866469067 (var1248) var3548)
(declare-fun cast-from-var1400-to-var1248 (var1400) var1248)
(declare-fun append/-1031950772 (String var453) String)
(declare-fun cast-from-var3548-to-var453 (var3548) var453)
(declare-fun cast-from-var481-to-var453 (var481) var453)
(declare-fun getMessage/849299655 (var2546) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var1218 String var2546) void)
(declare-const null-var1400 var1400)
(declare-const null-var481 var481)
(declare-const null-var2546 var2546)
(declare-const var701 var1400) ; Statement: r1 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var701 null-var1400)))
(declare-const var1495 var481) ; Statement: r11 := @parameter0: org.apache.dubbo.registry.nacos.NacosServiceName 
(assert (not (= var1495 null-var481)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3375 var2546) ; Statement: $r20 := @caughtexception 
(assert (not (= var3375 null-var2546)))
(define-const var1600 var1218 var1218-init) ; Statement: $r21 = new org.apache.dubbo.rpc.RpcException 
(define-const var3452 String String-init) ; Statement: $r22 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3452)) ; Statement: specialinvoke $r22.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3452!1 String)
(assert (= var3452!1 ""))
(assert true)
(define-const var2938 String (append/672562846 var3452!1 "Failed to filter serviceName from nacos, url: ")) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to filter serviceName from nacos, url: ") 
(declare-const var3452!2 String)
(assert (= var3452!2 (str.++ var3452!1 "Failed to filter serviceName from nacos, url: ")))
(assert true)
(define-const var3866 var3548 (getUrl/866469067 (cast-from-var1400-to-var1248 var701))) ; Statement: $r23 = virtualinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2276 String (append/-1031950772 var2938 (cast-from-var3548-to-var453 var3866))) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var2938!1 String)
(assert (str.prefixof var2938 var2938!1))
(assert true)
(define-const var3469 String (append/672562846 var2276 ", serviceName: ")) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", serviceName: ") 
(declare-const var2276!1 String)
(assert (= var2276!1 (str.++ var2276 ", serviceName: ")))
(assert true)
(define-const var1920 String (append/-1031950772 var3469 (cast-from-var481-to-var453 var1495))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r11) 
(declare-const var3469!1 String)
(assert (str.prefixof var3469 var3469!1))
(assert true)
(define-const var1201 String (append/672562846 var1920 ", cause: ")) ; Statement: $r29 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var1920!1 String)
(assert (= var1920!1 (str.++ var1920 ", cause: ")))
(assert true)
(define-const var2735 String (getMessage/849299655 var3375)) ; Statement: $r28 = virtualinvoke $r20.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var2201 String (append/672562846 var1201 var2735)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28) 
(declare-const var1201!1 String)
(assert (= var1201!1 (str.++ var1201 var2735)))
(assert true)
(define-const var849 String (toString/-2075883882 var2201)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var1600 var849 var3375)) ; Statement: specialinvoke $r21.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r31, $r20) 

(declare-const var1600!1 var1218)
(declare-const var849!1 String)
(declare-const var3375!1 var2546)
 ; Statement: throw $r21 
(check-sat)
; {var1218-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), cast-from-var1400-to-var1248=([org.apache.dubbo.registry.nacos.NacosRegistry], org.apache.dubbo.registry.support.AbstractRegistry), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3548-to-var453=([org.apache.dubbo.common.URL], java.lang.Object), cast-from-var481-to-var453=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var1400=org.apache.dubbo.registry.nacos.NacosRegistry, var701=r1, var481=org.apache.dubbo.registry.nacos.NacosServiceName, var1495=r11, var2546=java.lang.Throwable, var3375=$r20, var1218=org.apache.dubbo.rpc.RpcException, var1600=$r21, var3452=$r22, var2938=$r24, var3548=org.apache.dubbo.common.URL, var1248=org.apache.dubbo.registry.support.AbstractRegistry, var3866=$r23, var453=java.lang.Object, var2276=$r25, var3469=$r26, var1920=$r27, var1201=$r29, var2735=$r28, var2201=$r30, var849=$r31}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var1400, r1=var701, org.apache.dubbo.registry.nacos.NacosServiceName=var481, r11=var1495, java.lang.Throwable=var2546, $r20=var3375, org.apache.dubbo.rpc.RpcException=var1218, $r21=var1600, $r22=var3452, $r24=var2938, org.apache.dubbo.common.URL=var3548, org.apache.dubbo.registry.support.AbstractRegistry=var1248, $r23=var3866, java.lang.Object=var453, $r25=var2276, $r26=var3469, $r27=var1920, $r29=var1201, $r28=var2735, $r30=var2201, $r31=var849}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r11 := @parameter0: org.apache.dubbo.registry.nacos.NacosServiceName;	$r20 := @caughtexception;	$r21 = new org.apache.dubbo.rpc.RpcException;	$r22 = new java.lang.StringBuilder;	specialinvoke $r22.<java.lang.StringBuilder: void <init>()>();	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to filter serviceName from nacos, url: ");	$r23 = virtualinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>();	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", serviceName: ");	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r11);	$r29 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r28 = virtualinvoke $r20.<java.lang.Throwable: java.lang.String getMessage()>();	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r21.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r31, $r20);	throw $r21
;block_num 2
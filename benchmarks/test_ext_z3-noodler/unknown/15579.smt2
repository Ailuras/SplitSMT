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

(declare-sort var3358 0)
(declare-sort var3399 0)
(declare-sort var2645 0)
(declare-sort var2523 0)
(declare-sort var1062 0)
(declare-sort var1358 0)
(declare-sort var351 0)
(declare-sort var3526 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1358-init () var1358)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var351) String)
(declare-fun cast-from-var3399-to-var351 (var3399) var351)
(declare-fun getUrl/866469067 (var3526) var3399)
(declare-fun cast-from-var3358-to-var3526 (var3358) var3526)
(declare-fun getMessage/849299655 (var1062) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var1358 String var1062) void)
(declare-const null-var3358 var3358)
(declare-const null-var3399 var3399)
(declare-const null-var2645 var2645)
(declare-const null-var2523 var2523)
(declare-const null-var1062 var1062)
(declare-const var2918 var3358) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2918 null-var3358)))
(declare-const var533 var3399) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var533 null-var3399)))
(declare-const var1045 var2645) ; Statement: r14 := @parameter1: org.apache.dubbo.registry.nacos.NacosAggregateListener 
(assert (not (= var1045 null-var2645)))
(declare-const var557 var2523) ; Statement: r2 := @parameter2: java.util.Set 
(assert (not (= var557 null-var2523)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3192 var1062) ; Statement: $r21 := @caughtexception 
(assert (not (= var3192 null-var1062)))
(define-const var1932 var1358 var1358-init) ; Statement: $r44 = new org.apache.dubbo.rpc.RpcException 
(define-const var3231 String String-init) ; Statement: $r43 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3231)) ; Statement: specialinvoke $r43.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3231!1 String)
(assert (= var3231!1 ""))
(assert true)
(define-const var1241 String (append/672562846 var3231!1 "Failed to subscribe ")) ; Statement: $r24 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to subscribe ") 
(declare-const var3231!2 String)
(assert (= var3231!2 (str.++ var3231!1 "Failed to subscribe ")))
(assert true)
(define-const var1089 String (append/-1031950772 var1241 (cast-from-var3399-to-var351 var533))) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var1241!1 String)
(assert (str.prefixof var1241 var1241!1))
(assert true)
(define-const var1517 String (append/672562846 var1089 " to nacos ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ") 
(declare-const var1089!1 String)
(assert (= var1089!1 (str.++ var1089 " to nacos ")))
(assert true)
(define-const var1858 var3399 (getUrl/866469067 (cast-from-var3358-to-var3526 var2918))) ; Statement: $r26 = virtualinvoke r0.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1647 String (append/-1031950772 var1517 (cast-from-var3399-to-var351 var1858))) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var1517!1 String)
(assert (str.prefixof var1517 var1517!1))
(assert true)
(define-const var820 String (append/672562846 var1647 ", cause: ")) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var1647!1 String)
(assert (= var1647!1 (str.++ var1647 ", cause: ")))
(assert true)
(define-const var1403 String (getMessage/849299655 var3192)) ; Statement: $r29 = virtualinvoke $r21.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1408 String (append/672562846 var820 var1403)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r29) 
(declare-const var820!1 String)
(assert (= var820!1 (str.++ var820 var1403)))
(assert true)
(define-const var3637 String (toString/-2075883882 var1408)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var1932 var3637 var3192)) ; Statement: specialinvoke $r44.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r32, $r21) 

(declare-const var1932!1 var1358)
(declare-const var3637!1 String)
(declare-const var3192!1 var1062)
 ; Statement: throw $r44 
(check-sat)
; {var1358-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3399-to-var351=([org.apache.dubbo.common.URL], java.lang.Object), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), cast-from-var3358-to-var3526=([org.apache.dubbo.registry.nacos.NacosRegistry], org.apache.dubbo.registry.support.AbstractRegistry), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var3358=org.apache.dubbo.registry.nacos.NacosRegistry, var2918=r0, var3399=org.apache.dubbo.common.URL, var533=r1, var2645=org.apache.dubbo.registry.nacos.NacosAggregateListener, var1045=r14, var2523=java.util.Set, var557=r2, var1062=java.lang.Throwable, var3192=$r21, var1358=org.apache.dubbo.rpc.RpcException, var1932=$r44, var3231=$r43, var1241=$r24, var351=java.lang.Object, var1089=$r25, var1517=$r27, var3526=org.apache.dubbo.registry.support.AbstractRegistry, var1858=$r26, var1647=$r28, var820=$r30, var1403=$r29, var1408=$r31, var3637=$r32}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var3358, r0=var2918, org.apache.dubbo.common.URL=var3399, r1=var533, org.apache.dubbo.registry.nacos.NacosAggregateListener=var2645, r14=var1045, java.util.Set=var2523, r2=var557, java.lang.Throwable=var1062, $r21=var3192, org.apache.dubbo.rpc.RpcException=var1358, $r44=var1932, $r43=var3231, $r24=var1241, java.lang.Object=var351, $r25=var1089, $r27=var1517, org.apache.dubbo.registry.support.AbstractRegistry=var3526, $r26=var1858, $r28=var1647, $r30=var820, $r29=var1403, $r31=var1408, $r32=var3637}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	r14 := @parameter1: org.apache.dubbo.registry.nacos.NacosAggregateListener;	r2 := @parameter2: java.util.Set;	$r21 := @caughtexception;	$r44 = new org.apache.dubbo.rpc.RpcException;	$r43 = new java.lang.StringBuilder;	specialinvoke $r43.<java.lang.StringBuilder: void <init>()>();	$r24 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to subscribe ");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to nacos ");	$r26 = virtualinvoke r0.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r29 = virtualinvoke $r21.<java.lang.Throwable: java.lang.String getMessage()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r29);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r44.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r32, $r21);	throw $r44
;block_num 2
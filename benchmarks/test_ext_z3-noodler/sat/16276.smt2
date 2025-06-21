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

(declare-sort var2860 0)
(declare-sort var3792 0)
(declare-sort var3301 0)
(declare-sort var3609 0)
(declare-sort var1678 0)
(declare-sort var1740 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3301-init () var3301)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/866469067 (var1678) var3609)
(declare-fun cast-from-var2860-to-var1678 (var2860) var1678)
(declare-fun append/-1031950772 (String var1740) String)
(declare-fun cast-from-var3609-to-var1740 (var3609) var1740)
(declare-fun getMessage/849299655 (var3792) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var3301 String var3792) void)
(declare-const null-var2860 var2860)
(declare-const null-var3792 var3792)
(declare-const var2375 var2860) ; Statement: r1 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2375 null-var2860)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var835 var3792) ; Statement: $r10 := @caughtexception 
(assert (not (= var835 null-var3792)))
(define-const var2842 var3301 var3301-init) ; Statement: $r11 = new org.apache.dubbo.rpc.RpcException 
(define-const var3087 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3087)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3087!1 String)
(assert (= var3087!1 ""))
(assert true)
(define-const var2074 String (append/672562846 var3087!1 "Failed to get all serviceName from nacos, url: ")) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to get all serviceName from nacos, url: ") 
(declare-const var3087!2 String)
(assert (= var3087!2 (str.++ var3087!1 "Failed to get all serviceName from nacos, url: ")))
(assert true)
(define-const var1159 var3609 (getUrl/866469067 (cast-from-var2860-to-var1678 var2375))) ; Statement: $r13 = virtualinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var109 String (append/-1031950772 var2074 (cast-from-var3609-to-var1740 var1159))) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13) 
(declare-const var2074!1 String)
(assert (str.prefixof var2074 var2074!1))
(assert true)
(define-const var2828 String (append/672562846 var109 ", cause: ")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var109!1 String)
(assert (= var109!1 (str.++ var109 ", cause: ")))
(assert true)
(define-const var2760 String (getMessage/849299655 var835)) ; Statement: $r16 = virtualinvoke $r10.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var933 String (append/672562846 var2828 var2760)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var2828!1 String)
(assert (= var2828!1 (str.++ var2828 var2760)))
(assert true)
(define-const var3926 String (toString/-2075883882 var933)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var2842 var3926 var835)) ; Statement: specialinvoke $r11.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r19, $r10) 

(declare-const var2842!1 var3301)
(declare-const var3926!1 String)
(declare-const var835!1 var3792)
 ; Statement: throw $r11 
(check-sat)
; {var3301-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), cast-from-var2860-to-var1678=([org.apache.dubbo.registry.nacos.NacosRegistry], org.apache.dubbo.registry.support.AbstractRegistry), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3609-to-var1740=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var2860=org.apache.dubbo.registry.nacos.NacosRegistry, var2375=r1, var3792=java.lang.Throwable, var835=$r10, var3301=org.apache.dubbo.rpc.RpcException, var2842=$r11, var3087=$r12, var2074=$r14, var3609=org.apache.dubbo.common.URL, var1678=org.apache.dubbo.registry.support.AbstractRegistry, var1159=$r13, var1740=java.lang.Object, var109=$r15, var2828=$r17, var2760=$r16, var933=$r18, var3926=$r19}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var2860, r1=var2375, java.lang.Throwable=var3792, $r10=var835, org.apache.dubbo.rpc.RpcException=var3301, $r11=var2842, $r12=var3087, $r14=var2074, org.apache.dubbo.common.URL=var3609, org.apache.dubbo.registry.support.AbstractRegistry=var1678, $r13=var1159, java.lang.Object=var1740, $r15=var109, $r17=var2828, $r16=var2760, $r18=var933, $r19=var3926}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	$r10 := @caughtexception;	$r11 = new org.apache.dubbo.rpc.RpcException;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to get all serviceName from nacos, url: ");	$r13 = virtualinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.URL getUrl()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13);	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r16 = virtualinvoke $r10.<java.lang.Throwable: java.lang.String getMessage()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r19, $r10);	throw $r11
;block_num 2
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

(declare-sort var3105 0)
(declare-sort var717 0)
(declare-sort var3189 0)
(declare-sort var1738 0)
(declare-sort var1445 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun destroyed/-1577131577 (var3105) Bool)
(declare-fun var3189-init () var3189)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var1738) ClassObject)
(declare-fun cast-from-var3105-to-var1738 (var3105) var1738)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun getConsumerUrl/-1144930813 (var3105) var1445)
(declare-fun getServiceKey/1456125852 (var1445) String)
(declare-fun getUrl/-950407827 (var3105) var1445)
(declare-fun append/-1031950772 (String var1738) String)
(declare-fun cast-from-var1445-to-var1738 (var1445) var1738)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1520188505 (var3189 String) void)
(declare-const null-var3105 var3105)
(declare-const null-var717 var717)
(declare-const var3521 var3105) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.directory.AbstractDirectory 
(assert (not (= var3521 null-var3105)))
(declare-const var531 var717) ; Statement: r5 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var531 null-var717)))
(define-const var1510 Bool (destroyed/-1577131577 var3521)) ; Statement: $z0 = r0.<org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: boolean destroyed> 
 ; Statement: if $z0 == 0 goto r61 = null 
(assert (not (= (ite var1510 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3839 var3189 var3189-init) ; Statement: $r39 = new org.apache.dubbo.rpc.RpcException 
(define-const var3630 String String-init) ; Statement: $r40 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3630)) ; Statement: specialinvoke $r40.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3630!1 String)
(assert (= var3630!1 ""))
(assert true)
(define-const var2183 String (append/672562846 var3630!1 "Directory of type ")) ; Statement: $r43 = virtualinvoke $r40.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Directory of type ") 
(declare-const var3630!2 String)
(assert (= var3630!2 (str.++ var3630!1 "Directory of type ")))
(assert true)
(define-const var640 ClassObject (getClass/1258963082 (cast-from-var3105-to-var1738 var3521))) ; Statement: $r41 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var2311 String (getSimpleName/-390194377 var640)) ; Statement: $r42 = virtualinvoke $r41.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var3151 String (append/672562846 var2183 var2311)) ; Statement: $r44 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r42) 
(declare-const var2183!1 String)
(assert (= var2183!1 (str.++ var2183 var2311)))
(assert true)
(define-const var3866 String (append/672562846 var3151 " already destroyed for service ")) ; Statement: $r47 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" already destroyed for service ") 
(declare-const var3151!1 String)
(assert (= var3151!1 (str.++ var3151 " already destroyed for service ")))
(assert true)
(define-const var2834 var1445 (getConsumerUrl/-1144930813 var3521)) ; Statement: $r45 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: org.apache.dubbo.common.URL getConsumerUrl()>() 
(assert true)
(define-const var3400 String (getServiceKey/1456125852 var2834)) ; Statement: $r46 = virtualinvoke $r45.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var515 String (append/672562846 var3866 var3400)) ; Statement: $r48 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r46) 
(declare-const var3866!1 String)
(assert (= var3866!1 (str.++ var3866 var3400)))
(assert true)
(define-const var3303 String (append/672562846 var515 " from registry ")) ; Statement: $r50 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from registry ") 
(declare-const var515!1 String)
(assert (= var515!1 (str.++ var515 " from registry ")))
(assert true)
(define-const var1660 var1445 (getUrl/-950407827 var3521)) ; Statement: $r49 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1441 String (append/-1031950772 var3303 (cast-from-var1445-to-var1738 var1660))) ; Statement: $r51 = virtualinvoke $r50.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r49) 
(declare-const var3303!1 String)
(assert (str.prefixof var3303 var3303!1))
(assert true)
(define-const var122 String (toString/-2075883882 var1441)) ; Statement: $r52 = virtualinvoke $r51.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1520188505 var3839 var122)) ; Statement: specialinvoke $r39.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r52) 

(declare-const var3839!1 var3189)
(declare-const var122!1 String)
 ; Statement: throw $r39 
(check-sat)
; {destroyed/-1577131577=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], boolean), var3189-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3105-to-var1738=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), getConsumerUrl/-1144930813=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.common.URL), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), getUrl/-950407827=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.common.URL), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1445-to-var1738=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1520188505=([org.apache.dubbo.rpc.RpcException, java.lang.String], void)}
; {var3105=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var3521=r0, var717=org.apache.dubbo.rpc.Invocation, var531=r5, var1510=$z0, var3189=org.apache.dubbo.rpc.RpcException, var3839=$r39, var3630=$r40, var2183=$r43, var1738=java.lang.Object, var640=$r41, var2311=$r42, var3151=$r44, var3866=$r47, var1445=org.apache.dubbo.common.URL, var2834=$r45, var3400=$r46, var515=$r48, var3303=$r50, var1660=$r49, var1441=$r51, var122=$r52}
; {org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var3105, r0=var3521, org.apache.dubbo.rpc.Invocation=var717, r5=var531, $z0=var1510, org.apache.dubbo.rpc.RpcException=var3189, $r39=var3839, $r40=var3630, $r43=var2183, java.lang.Object=var1738, $r41=var640, $r42=var2311, $r44=var3151, $r47=var3866, org.apache.dubbo.common.URL=var1445, $r45=var2834, $r46=var3400, $r48=var515, $r50=var3303, $r49=var1660, $r51=var1441, $r52=var122}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.directory.AbstractDirectory;	r5 := @parameter0: org.apache.dubbo.rpc.Invocation;	$z0 = r0.<org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: boolean destroyed>;	if $z0 == 0 goto r61 = null;	$r39 = new org.apache.dubbo.rpc.RpcException;	$r40 = new java.lang.StringBuilder;	specialinvoke $r40.<java.lang.StringBuilder: void <init>()>();	$r43 = virtualinvoke $r40.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Directory of type ");	$r41 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r42 = virtualinvoke $r41.<java.lang.Class: java.lang.String getSimpleName()>();	$r44 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r42);	$r47 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" already destroyed for service ");	$r45 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: org.apache.dubbo.common.URL getConsumerUrl()>();	$r46 = virtualinvoke $r45.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r48 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r46);	$r50 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from registry ");	$r49 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: org.apache.dubbo.common.URL getUrl()>();	$r51 = virtualinvoke $r50.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r49);	$r52 = virtualinvoke $r51.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r39.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String)>($r52);	throw $r39
;block_num 2
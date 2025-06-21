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

(declare-sort var969 0)
(declare-sort var3592 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/1906106355 (String Int) void)
(declare-fun getScheme/657926790 (var969) String)
(declare-fun getServerPort/653602027 (var969) Int)
(define-fun append/1560614132 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getServerName/82973725 (var969) String)
(declare-fun path/1524618772 (var3592) String)
(declare-fun cast-from-var969-to-var3592 (var969) var3592)
(declare-const null-var969 var969)
(declare-const var27 var969) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter 
(assert (not (= var27 null-var969)))
(define-const var1734 String String-init) ; Statement: $r0 = new java.lang.StringBuffer 
(assert true)
;(assert (<init>/1906106355 var1734 32)) ; Statement: specialinvoke $r0.<java.lang.StringBuffer: void <init>(int)>(32) 

(declare-const var1734!1 String)
(declare-const var494 Int)
(assert true)
(define-const var2234 String (getScheme/657926790 var27)) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String getScheme()>() 
(assert true)
(define-const var3627 Int (getServerPort/653602027 var27)) ; Statement: i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: int getServerPort()>() 
(assert true)
(define-const var2179 String (append/1560614132 var1734!1 var2234)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>(r2) 
(declare-const var1734!2 String)
(assert (str.prefixof var1734!1 var1734!2))
(assert true)
(define-const var2775 String (append/1560614132 var2179 "://")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("://") 
(declare-const var2179!1 String)
(assert (str.prefixof var2179 var2179!1))
(assert true)
(define-const var1125 String (getServerName/82973725 var27)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String getServerName()>() 
(assert true)
;(assert (append/1560614132 var2775 var1125)) ; Statement: virtualinvoke $r5.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>($r4) 
(declare-const var2775!1 String)
(assert (str.prefixof var2775 var2775!1))
(define-const var1291 String "http") ; Statement: $r6 = "http" 
(assert true)
(define-const var2796 Bool (= var1291 var2234)) ; Statement: $z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r7 = "https" 
(assert (= (ite var2796 1 0) 0)) ; Cond: $z0 == 0 
(define-const var100 String "https") ; Statement: $r7 = "https" 
(assert true)
(define-const var1947 Bool (= var100 var2234)) ; Statement: $z1 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String path()>() 
(assert (= (ite var1947 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var3159 String (path/1524618772 (cast-from-var969-to-var3592 var27))) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String path()>() 
(assert true)
;(assert (append/1560614132 var1734!2 var3159)) ; Statement: virtualinvoke $r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>($r8) 
(declare-const var1734!3 String)
(assert (str.prefixof var1734!2 var1734!3))
 ; Statement: return $r0 
(check-sat)
; {String-init=([], java.lang.StringBuffer), <init>/1906106355=([java.lang.StringBuffer, int], void), getScheme/657926790=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter], java.lang.String), getServerPort/653602027=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter], int), append/1560614132=([java.lang.StringBuffer, java.lang.String], java.lang.StringBuffer), getServerName/82973725=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter], java.lang.String), path/1524618772=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), cast-from-var969-to-var3592=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter], org.apache.dubbo.remoting.http12.message.DefaultHttpRequest)}
; {var969=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter, var27=r1, var1734=$r0, var494=32, var2234=r2, var3627=i0, var2179=$r3, var2775=$r5, var1125=$r4, var1291=$r6, var2796=$z0, var100=$r7, var1947=$z1, var3592=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var3159=$r8}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter=var969, r1=var27, $r0=var1734, 32=var494, r2=var2234, i0=var3627, $r3=var2179, $r5=var2775, $r4=var1125, $r6=var1291, $z0=var2796, $r7=var100, $z1=var1947, org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var3592, $r8=var3159}
;seq <java.lang.StringBuffer: void <init>(int)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>
;cnt {"<java.lang.StringBuffer: void <init>(int)>": 1,"<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>": 4,"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter;	$r0 = new java.lang.StringBuffer;	specialinvoke $r0.<java.lang.StringBuffer: void <init>(int)>(32);	r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String getScheme()>();	i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: int getServerPort()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>(r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("://");	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String getServerName()>();	virtualinvoke $r5.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>($r4);	$r6 = "http";	$z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r7 = "https";	$r7 = "https";	$z1 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String path()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String path()>();	virtualinvoke $r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>($r8);	return $r0
;block_num 3
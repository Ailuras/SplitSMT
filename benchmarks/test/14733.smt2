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

(declare-sort var1085 0)
(declare-sort var1735 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/1906106355 (String Int) void)
(declare-fun getScheme/210441858 (var1085) String)
(declare-fun getServerPort/676631919 (var1085) Int)
(define-fun append/1560614132 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getServerName/104309273 (var1085) String)
(declare-fun path/1524618772 (var1735) String)
(declare-fun cast-from-var1085-to-var1735 (var1085) var1735)
(declare-const null-var1085 var1085)
(declare-const var1017 var1085) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter 
(assert (not (= var1017 null-var1085)))
(define-const var1511 String String-init) ; Statement: $r0 = new java.lang.StringBuffer 
(assert true)
;(assert (<init>/1906106355 var1511 32)) ; Statement: specialinvoke $r0.<java.lang.StringBuffer: void <init>(int)>(32) 

(declare-const var1511!1 String)
(declare-const var3800 Int)
(assert true)
(define-const var3499 String (getScheme/210441858 var1017)) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String getScheme()>() 
(assert true)
(define-const var1132 Int (getServerPort/676631919 var1017)) ; Statement: i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: int getServerPort()>() 
(assert true)
(define-const var922 String (append/1560614132 var1511!1 var3499)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>(r2) 
(declare-const var1511!2 String)
(assert (str.prefixof var1511!1 var1511!2))
(assert true)
(define-const var3551 String (append/1560614132 var922 "://")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("://") 
(declare-const var922!1 String)
(assert (str.prefixof var922 var922!1))
(assert true)
(define-const var1920 String (getServerName/104309273 var1017)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String getServerName()>() 
(assert true)
;(assert (append/1560614132 var3551 var1920)) ; Statement: virtualinvoke $r5.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>($r4) 
(declare-const var3551!1 String)
(assert (str.prefixof var3551 var3551!1))
(define-const var2706 String "http") ; Statement: $r6 = "http" 
(assert true)
(define-const var2653 Bool (= var2706 var3499)) ; Statement: $z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r7 = "https" 
(assert (= (ite var2653 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3782 String "https") ; Statement: $r7 = "https" 
(assert true)
(define-const var2529 Bool (= var3782 var3499)) ; Statement: $z1 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String path()>() 
(assert (= (ite var2529 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var683 String (path/1524618772 (cast-from-var1085-to-var1735 var1017))) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String path()>() 
(assert true)
;(assert (append/1560614132 var1511!2 var683)) ; Statement: virtualinvoke $r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>($r8) 
(declare-const var1511!3 String)
(assert (str.prefixof var1511!2 var1511!3))
 ; Statement: return $r0 
(check-sat)
; {String-init=([], java.lang.StringBuffer), <init>/1906106355=([java.lang.StringBuffer, int], void), getScheme/210441858=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter], java.lang.String), getServerPort/676631919=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter], int), append/1560614132=([java.lang.StringBuffer, java.lang.String], java.lang.StringBuffer), getServerName/104309273=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter], java.lang.String), path/1524618772=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), cast-from-var1085-to-var1735=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter], org.apache.dubbo.remoting.http12.message.DefaultHttpRequest)}
; {var1085=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter, var1017=r1, var1511=$r0, var3800=32, var3499=r2, var1132=i0, var922=$r3, var3551=$r5, var1920=$r4, var2706=$r6, var2653=$z0, var3782=$r7, var2529=$z1, var1735=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var683=$r8}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter=var1085, r1=var1017, $r0=var1511, 32=var3800, r2=var3499, i0=var1132, $r3=var922, $r5=var3551, $r4=var1920, $r6=var2706, $z0=var2653, $r7=var3782, $z1=var2529, org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var1735, $r8=var683}
;seq <java.lang.StringBuffer: void <init>(int)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>
;cnt {"<java.lang.StringBuffer: void <init>(int)>": 1,"<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>": 4,"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter;	$r0 = new java.lang.StringBuffer;	specialinvoke $r0.<java.lang.StringBuffer: void <init>(int)>(32);	r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String getScheme()>();	i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: int getServerPort()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>(r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("://");	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String getServerName()>();	virtualinvoke $r5.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>($r4);	$r6 = "http";	$z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r7 = "https";	$r7 = "https";	$z1 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String path()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String path()>();	virtualinvoke $r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>($r8);	return $r0
;block_num 3
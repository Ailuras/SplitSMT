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

(declare-sort var3026 0)
(declare-sort var2335 0)
(declare-sort var2157 0)
(declare-sort var92 0)
(declare-sort var3615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var2335) ClassObject)
(declare-fun cast-from-var3026-to-var2335 (var3026) var2335)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun httpMetadata/-2089546551 (var3026) var2157)
(declare-fun append/-1031950772 (String var2335) String)
(declare-fun cast-from-var2157-to-var2335 (var2157) var2335)
(declare-fun context/-2089546551 (var3026) var3615)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3026 var3026)
(declare-const var92-VERBOSE_ENABLED Bool)
(declare-const null-var3615 var3615)
(declare-const var2960 var3026) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener 
(assert (not (= var2960 null-var3026)))
(define-const var3145 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var3145 128)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(128) 

(declare-const var3145!1 String)
(declare-const var2728 Int)
(assert true)
(define-const var2217 String (append/672562846 var3145!1 "An error occurred while processing the http request with ")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("An error occurred while processing the http request with ") 
(declare-const var3145!2 String)
(assert (= var3145!2 (str.++ var3145!1 "An error occurred while processing the http request with ")))
(assert true)
(define-const var3570 ClassObject (getClass/1258963082 (cast-from-var3026-to-var2335 var2960))) ; Statement: $r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1070 String (getSimpleName/-390194377 var3570)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var3519 String (append/672562846 var2217 var1070)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2217!1 String)
(assert (= var2217!1 (str.++ var2217 var1070)))
(assert true)
(define-const var775 String (append/672562846 var3519 ", ")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var3519!1 String)
(assert (= var3519!1 (str.++ var3519 ", ")))
(define-const var1950 var2157 (httpMetadata/-2089546551 var2960)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener: org.apache.dubbo.remoting.http12.RequestMetadata httpMetadata> 
(assert true)
;(assert (append/-1031950772 var775 (cast-from-var2157-to-var2335 var1950))) ; Statement: virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var775!1 String)
(assert (str.prefixof var775 var775!1))
(define-const var2077 Bool var92-VERBOSE_ENABLED) ; Statement: $z0 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean VERBOSE_ENABLED> 
 ; Statement: if $z0 == 0 goto $r8 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener: org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext context> 
(assert (= (ite var2077 1 0) 0)) ; Cond: $z0 == 0 
(define-const var403 var3615 (context/-2089546551 var2960)) ; Statement: $r8 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener: org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext context> 
 ; Statement: if $r8 == null goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var403 null-var3615)) ; Cond: $r8 == null 
(assert true)
(define-const var1497 String (toString/-2075883882 var3145!2)) ; Statement: $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r30 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3026-to-var2335=([org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), httpMetadata/-2089546551=([org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener], org.apache.dubbo.remoting.http12.RequestMetadata), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2157-to-var2335=([org.apache.dubbo.remoting.http12.RequestMetadata], java.lang.Object), context/-2089546551=([org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener], org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3026=org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener, var2960=r1, var3145=$r0, var2728=128, var2217=$r4, var2335=java.lang.Object, var3570=$r2, var1070=$r3, var3519=$r5, var775=$r7, var2157=org.apache.dubbo.remoting.http12.RequestMetadata, var1950=$r6, var92=org.apache.dubbo.rpc.protocol.tri.TripleProtocol, var2077=$z0, var3615=org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext, var403=$r8, var1497=$r30}
; {org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener=var3026, r1=var2960, $r0=var3145, 128=var2728, $r4=var2217, java.lang.Object=var2335, $r2=var3570, $r3=var1070, $r5=var3519, $r7=var775, org.apache.dubbo.remoting.http12.RequestMetadata=var2157, $r6=var1950, org.apache.dubbo.rpc.protocol.tri.TripleProtocol=var92, $z0=var2077, org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext=var3615, $r8=var403, $r30=var1497}
;seq <java.lang.StringBuilder: void <init>(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(128);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("An error occurred while processing the http request with ");	$r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r6 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener: org.apache.dubbo.remoting.http12.RequestMetadata httpMetadata>;	virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$z0 = <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean VERBOSE_ENABLED>;	if $z0 == 0 goto $r8 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener: org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext context>;	$r8 = r1.<org.apache.dubbo.rpc.protocol.tri.h12.AbstractServerTransportListener: org.apache.dubbo.rpc.protocol.tri.RpcInvocationBuildContext context>;	if $r8 == null goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r30
;block_num 3
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

(declare-sort var3962 0)
(declare-sort var2339 0)
(declare-sort var1246 0)
(declare-sort var298 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun transportError/538743485 (var3962) var1246)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var298) String)
(declare-fun cast-from-var2339-to-var298 (var2339) var298)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun appendDescription/1676533930 (var1246 String) var1246)
(declare-const null-var3962 var3962)
(declare-const null-var2339 var2339)
(declare-const null-var1246 var1246)
(declare-const var2779 var3962) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener 
(assert (not (= var2779 null-var3962)))
(declare-const var3026 var2339) ; Statement: r2 := @parameter0: io.netty.handler.codec.http2.Http2Headers 
(assert (not (= var3026 null-var2339)))
(define-const var3813 var1246 (transportError/538743485 var2779)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
 ; Statement: if $r1 == null goto $z0 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: boolean headerReceived> 
(assert (not (= var3813 null-var1246))) ; Negate: Cond: $r1 == null  
(define-const var3700 var1246 (transportError/538743485 var2779)) ; Statement: $r23 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
(define-const var3622 String String-init) ; Statement: $r22 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3622)) ; Statement: specialinvoke $r22.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3622!1 String)
(assert (= var3622!1 ""))
(assert true)
(define-const var3647 String (append/672562846 var3622!1 "headers:")) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("headers:") 
(declare-const var3622!2 String)
(assert (= var3622!2 (str.++ var3622!1 "headers:")))
(assert true)
(define-const var3242 String (append/-1031950772 var3647 (cast-from-var2339-to-var298 var3026))) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var3647!1 String)
(assert (str.prefixof var3647 var3647!1))
(assert true)
(define-const var19 String (toString/-2075883882 var3242)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (appendDescription/1676533930 var3700 var19)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus appendDescription(java.lang.String)>($r26) 

(declare-const var3700!1 var1246)
(declare-const var19!1 String)
 ; Statement: return 
(check-sat)
; {transportError/538743485=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener], org.apache.dubbo.rpc.TriRpcStatus), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2339-to-var298=([io.netty.handler.codec.http2.Http2Headers], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), appendDescription/1676533930=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus)}
; {var3962=org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener, var2779=r0, var2339=io.netty.handler.codec.http2.Http2Headers, var3026=r2, var1246=org.apache.dubbo.rpc.TriRpcStatus, var3813=$r1, var3700=$r23, var3622=$r22, var3647=$r24, var298=java.lang.Object, var3242=$r25, var19=$r26}
; {org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener=var3962, r0=var2779, io.netty.handler.codec.http2.Http2Headers=var2339, r2=var3026, org.apache.dubbo.rpc.TriRpcStatus=var1246, $r1=var3813, $r23=var3700, $r22=var3622, $r24=var3647, java.lang.Object=var298, $r25=var3242, $r26=var19}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener;	r2 := @parameter0: io.netty.handler.codec.http2.Http2Headers;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	if $r1 == null goto $z0 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: boolean headerReceived>;	$r23 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	$r22 = new java.lang.StringBuilder;	specialinvoke $r22.<java.lang.StringBuilder: void <init>()>();	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("headers:");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r23.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus appendDescription(java.lang.String)>($r26);	return
;block_num 2
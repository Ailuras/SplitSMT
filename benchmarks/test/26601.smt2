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

(declare-sort var2441 0)
(declare-sort var2694 0)
(declare-sort var863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2694_status/-1019238160 (var2694) String)
(declare-fun String_toString/-1426662429 (String) String)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun withDescription/65961942 (var863 String) var863)
(declare-const null-var2441 var2441)
(declare-const null-var2694 var2694)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var863-INTERNAL var863)
(declare-const var1975 var2441) ; Statement: r19 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener 
(assert (not (= var1975 null-var2441)))
(declare-const var2738 var2694) ; Statement: r0 := @parameter0: io.netty.handler.codec.http2.Http2Headers 
(assert (not (= var2738 null-var2694)))
(define-const var240 String (var2694_status/-1019238160 var2738)) ; Statement: $r1 = interfaceinvoke r0.<io.netty.handler.codec.http2.Http2Headers: java.lang.CharSequence status()>() 
 ; Statement: if $r1 != null goto $r2 = interfaceinvoke r0.<io.netty.handler.codec.http2.Http2Headers: java.lang.CharSequence status()>() 
(assert (not (= var240 null-String))) ; Cond: $r1 != null 
(define-const var2590 String (var2694_status/-1019238160 var2738)) ; Statement: $r2 = interfaceinvoke r0.<io.netty.handler.codec.http2.Http2Headers: java.lang.CharSequence status()>() 
(define-const var309 String (String_toString/-1426662429 var2590)) ; Statement: $r3 = interfaceinvoke $r2.<java.lang.CharSequence: java.lang.String toString()>() 
(define-const var711 Int (Int_parseInt/1370970945 var309)) ; Statement: $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r3) 
(define-const var1153 Int (Int_valueOf/-1371140006 var711)) ; Statement: $r20 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i0) 
(assert true) ; Non Conditional
(define-const var1137 Int var1153) ; Statement: r4 = $r20 
 ; Statement: if $r20 != null goto $r5 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_TYPE> 
(assert (not (not (= var1153 null-Int)))) ; Negate: Cond: $r20 != null  
(define-const var173 var863 var863-INTERNAL) ; Statement: $r17 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus INTERNAL> 
(assert true)
(define-const var1523 var863 (withDescription/65961942 var173 "Missing HTTP status code")) ; Statement: $r18 = virtualinvoke $r17.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>("Missing HTTP status code") 
 ; Statement: return $r18 
(check-sat)
; {var2694_status/-1019238160=([io.netty.handler.codec.http2.Http2Headers], java.lang.CharSequence), String_toString/-1426662429=([java.lang.CharSequence], java.lang.String), Int_parseInt/1370970945=([java.lang.String], int), Int_valueOf/-1371140006=([int], java.lang.Integer), withDescription/65961942=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus)}
; {var2441=org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener, var1975=r19, var2694=io.netty.handler.codec.http2.Http2Headers, var2738=r0, var240=$r1, var2590=$r2, var309=$r3, var711=$i0, var1153=$r20, var1137=r4, var863=org.apache.dubbo.rpc.TriRpcStatus, var173=$r17, var1523=$r18}
; {org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener=var2441, r19=var1975, io.netty.handler.codec.http2.Http2Headers=var2694, r0=var2738, $r1=var240, $r2=var2590, $r3=var309, $i0=var711, $r20=var1153, r4=var1137, org.apache.dubbo.rpc.TriRpcStatus=var863, $r17=var173, $r18=var1523}
;seq <java.lang.CharSequence: java.lang.String toString()>
;cnt {"<java.lang.CharSequence: java.lang.String toString()>": 1}
;stmts r19 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener;	r0 := @parameter0: io.netty.handler.codec.http2.Http2Headers;	$r1 = interfaceinvoke r0.<io.netty.handler.codec.http2.Http2Headers: java.lang.CharSequence status()>();	if $r1 != null goto $r2 = interfaceinvoke r0.<io.netty.handler.codec.http2.Http2Headers: java.lang.CharSequence status()>();	$r2 = interfaceinvoke r0.<io.netty.handler.codec.http2.Http2Headers: java.lang.CharSequence status()>();	$r3 = interfaceinvoke $r2.<java.lang.CharSequence: java.lang.String toString()>();	$i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r3);	$r20 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i0);	r4 = $r20;	if $r20 != null goto $r5 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_TYPE>;	$r17 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus INTERNAL>;	$r18 = virtualinvoke $r17.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>("Missing HTTP status code");	return $r18
;block_num 4
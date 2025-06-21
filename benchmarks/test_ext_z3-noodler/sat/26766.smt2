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

(declare-sort var3879 0)
(declare-sort var208 0)
(declare-sort var456 0)
(declare-sort var2044 0)
(declare-sort var339 0)
(declare-sort var647 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun transportError/538743485 (var3879) var456)
(declare-fun trailers/538743485 (var3879) var208)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2044) String)
(declare-fun cast-from-var208-to-var2044 (var208) var2044)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun appendDescription/1676533930 (var456 String) var456)
(declare-fun this$0/538743485 (var3879) var339)
(declare-fun var339_access$600/1812528808 (var339) var647)
(declare-fun var647_close/-491654434 (var647) void)
(declare-const null-var3879 var3879)
(declare-const null-var208 var208)
(declare-const null-var456 var456)
(declare-const null-var647 var647)
(declare-const var311 var3879) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener 
(assert (not (= var311 null-var3879)))
(declare-const var1384 var208) ; Statement: r2 := @parameter0: io.netty.handler.codec.http2.Http2Headers 
(assert (not (= var1384 null-var208)))
(define-const var701 var456 (transportError/538743485 var311)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
 ; Statement: if $r1 != null goto r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: io.netty.handler.codec.http2.Http2Headers trailers> = r2 
(assert (not (= var701 null-var456))) ; Cond: $r1 != null 
(declare-const var311!1 var3879)
(assert (not (= var311!1 null-var3879)))
(assert (= (trailers/538743485 var311!1) var1384)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: io.netty.handler.codec.http2.Http2Headers trailers> = r2 
(define-const var754 var456 (transportError/538743485 var311!1)) ; Statement: $r14 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
 ; Statement: if $r14 != null goto $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
(assert (not (= var754 null-var456))) ; Cond: $r14 != null 
(define-const var3217 var456 (transportError/538743485 var311!1)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
(define-const var3623 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3623)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3623!1 String)
(assert (= var3623!1 ""))
(assert true)
(define-const var3241 String (append/672562846 var3623!1 "trailers: ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("trailers: ") 
(declare-const var3623!2 String)
(assert (= var3623!2 (str.++ var3623!1 "trailers: ")))
(assert true)
(define-const var626 String (append/-1031950772 var3241 (cast-from-var208-to-var2044 var1384))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var3241!1 String)
(assert (str.prefixof var3241 var3241!1))
(assert true)
(define-const var288 String (toString/-2075883882 var626)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var1543 var456 (appendDescription/1676533930 var3217 var288)) ; Statement: $r8 = virtualinvoke $r4.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus appendDescription(java.lang.String)>($r7) 
(declare-const var311!2 var3879)
(assert (not (= var311!2 null-var3879)))
(assert (= (transportError/538743485 var311!2) var1543)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> = $r8 
(define-const var351 var456 (transportError/538743485 var311!2)) ; Statement: r15 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
(assert true) ; Non Conditional
(define-const var3037 var339 (this$0/538743485 var311!2)) ; Statement: $r9 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0> 
(define-const var3764 var647 (var339_access$600/1812528808 var3037)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream: org.apache.dubbo.rpc.protocol.tri.frame.Deframer access$600(org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream)>($r9) 
 ; Statement: if $r10 != null goto $r11 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0> 
(assert (not (= var3764 null-var647))) ; Cond: $r10 != null 
(define-const var3038 var339 (this$0/538743485 var311!2)) ; Statement: $r11 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0> 
(define-const var1882 var647 (var339_access$600/1812528808 var3038)) ; Statement: $r12 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream: org.apache.dubbo.rpc.protocol.tri.frame.Deframer access$600(org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream)>($r11) 
;(assert (var647_close/-491654434 var1882)) ; Statement: interfaceinvoke $r12.<org.apache.dubbo.rpc.protocol.tri.frame.Deframer: void close()>() 

(declare-const var1882!1 var647)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {transportError/538743485=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener], org.apache.dubbo.rpc.TriRpcStatus), trailers/538743485=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener], io.netty.handler.codec.http2.Http2Headers), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var208-to-var2044=([io.netty.handler.codec.http2.Http2Headers], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), appendDescription/1676533930=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus), this$0/538743485=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener], org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream), var339_access$600/1812528808=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream], org.apache.dubbo.rpc.protocol.tri.frame.Deframer), var647_close/-491654434=([org.apache.dubbo.rpc.protocol.tri.frame.Deframer], void)}
; {var3879=org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener, var311=r0, var208=io.netty.handler.codec.http2.Http2Headers, var1384=r2, var456=org.apache.dubbo.rpc.TriRpcStatus, var701=$r1, var754=$r14, var3217=$r4, var3623=$r3, var3241=$r5, var2044=java.lang.Object, var626=$r6, var288=$r7, var1543=$r8, var351=r15, var339=org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream, var3037=$r9, var647=org.apache.dubbo.rpc.protocol.tri.frame.Deframer, var3764=$r10, var3038=$r11, var1882=$r12}
; {org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener=var3879, r0=var311, io.netty.handler.codec.http2.Http2Headers=var208, r2=var1384, org.apache.dubbo.rpc.TriRpcStatus=var456, $r1=var701, $r14=var754, $r4=var3217, $r3=var3623, $r5=var3241, java.lang.Object=var2044, $r6=var626, $r7=var288, $r8=var1543, r15=var351, org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream=var339, $r9=var3037, org.apache.dubbo.rpc.protocol.tri.frame.Deframer=var647, $r10=var3764, $r11=var3038, $r12=var1882}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener;	r2 := @parameter0: io.netty.handler.codec.http2.Http2Headers;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	if $r1 != null goto r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: io.netty.handler.codec.http2.Http2Headers trailers> = r2;	r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: io.netty.handler.codec.http2.Http2Headers trailers> = r2;	$r14 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	if $r14 != null goto $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	$r4 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("trailers: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = virtualinvoke $r4.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus appendDescription(java.lang.String)>($r7);	r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> = $r8;	r15 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	$r9 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0>;	$r10 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream: org.apache.dubbo.rpc.protocol.tri.frame.Deframer access$600(org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream)>($r9);	if $r10 != null goto $r11 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0>;	$r11 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0>;	$r12 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream: org.apache.dubbo.rpc.protocol.tri.frame.Deframer access$600(org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream)>($r11);	interfaceinvoke $r12.<org.apache.dubbo.rpc.protocol.tri.frame.Deframer: void close()>();	return
;block_num 6
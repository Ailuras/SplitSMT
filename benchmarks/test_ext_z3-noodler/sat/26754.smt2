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

(declare-sort var1432 0)
(declare-sort var2160 0)
(declare-sort var489 0)
(declare-sort var887 0)
(declare-sort var273 0)
(declare-sort var2278 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun transportError/538743485 (var1432) var489)
(declare-fun trailers/538743485 (var1432) var2160)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var887) String)
(declare-fun cast-from-var2160-to-var887 (var2160) var887)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun appendDescription/1676533930 (var489 String) var489)
(declare-fun this$0/538743485 (var1432) var273)
(declare-fun var273_access$600/1812528808 (var273) var2278)
(declare-fun finishProcess/-761355745 (var1432 var489 var2160 Bool) void)
(declare-const null-var1432 var1432)
(declare-const null-var2160 var2160)
(declare-const null-var489 var489)
(declare-const null-var2278 var2278)
(declare-const var1242 var1432) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener 
(assert (not (= var1242 null-var1432)))
(declare-const var2633 var2160) ; Statement: r2 := @parameter0: io.netty.handler.codec.http2.Http2Headers 
(assert (not (= var2633 null-var2160)))
(define-const var3074 var489 (transportError/538743485 var1242)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
 ; Statement: if $r1 != null goto r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: io.netty.handler.codec.http2.Http2Headers trailers> = r2 
(assert (not (= var3074 null-var489))) ; Cond: $r1 != null 
(declare-const var1242!1 var1432)
(assert (not (= var1242!1 null-var1432)))
(assert (= (trailers/538743485 var1242!1) var2633)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: io.netty.handler.codec.http2.Http2Headers trailers> = r2 
(define-const var2259 var489 (transportError/538743485 var1242!1)) ; Statement: $r14 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
 ; Statement: if $r14 != null goto $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
(assert (not (= var2259 null-var489))) ; Cond: $r14 != null 
(define-const var346 var489 (transportError/538743485 var1242!1)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
(define-const var2354 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2354)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2354!1 String)
(assert (= var2354!1 ""))
(assert true)
(define-const var2855 String (append/672562846 var2354!1 "trailers: ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("trailers: ") 
(declare-const var2354!2 String)
(assert (= var2354!2 (str.++ var2354!1 "trailers: ")))
(assert true)
(define-const var2514 String (append/-1031950772 var2855 (cast-from-var2160-to-var887 var2633))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var2855!1 String)
(assert (str.prefixof var2855 var2855!1))
(assert true)
(define-const var2877 String (toString/-2075883882 var2514)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var1117 var489 (appendDescription/1676533930 var346 var2877)) ; Statement: $r8 = virtualinvoke $r4.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus appendDescription(java.lang.String)>($r7) 
(declare-const var1242!2 var1432)
(assert (not (= var1242!2 null-var1432)))
(assert (= (transportError/538743485 var1242!2) var1117)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> = $r8 
(define-const var2105 var489 (transportError/538743485 var1242!2)) ; Statement: r15 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
(assert true) ; Non Conditional
(define-const var33 var273 (this$0/538743485 var1242!2)) ; Statement: $r9 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0> 
(define-const var2357 var2278 (var273_access$600/1812528808 var33)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream: org.apache.dubbo.rpc.protocol.tri.frame.Deframer access$600(org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream)>($r9) 
 ; Statement: if $r10 != null goto $r11 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0> 
(assert (not (not (= var2357 null-var2278)))) ; Negate: Cond: $r10 != null  
(assert true)
;(assert (finishProcess/-761355745 var1242!2 var2105 var2633 (ite (= 1 0) true false))) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: void finishProcess(org.apache.dubbo.rpc.TriRpcStatus,io.netty.handler.codec.http2.Http2Headers,boolean)>(r15, r2, 0) 

(declare-const var1242!3 var1432)
(declare-const var2105!1 var489)
(declare-const var2633!1 var2160)
(declare-const var3044 Int)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {transportError/538743485=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener], org.apache.dubbo.rpc.TriRpcStatus), trailers/538743485=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener], io.netty.handler.codec.http2.Http2Headers), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2160-to-var887=([io.netty.handler.codec.http2.Http2Headers], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), appendDescription/1676533930=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus), this$0/538743485=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener], org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream), var273_access$600/1812528808=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream], org.apache.dubbo.rpc.protocol.tri.frame.Deframer), finishProcess/-761355745=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener, org.apache.dubbo.rpc.TriRpcStatus, io.netty.handler.codec.http2.Http2Headers, boolean], void)}
; {var1432=org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener, var1242=r0, var2160=io.netty.handler.codec.http2.Http2Headers, var2633=r2, var489=org.apache.dubbo.rpc.TriRpcStatus, var3074=$r1, var2259=$r14, var346=$r4, var2354=$r3, var2855=$r5, var887=java.lang.Object, var2514=$r6, var2877=$r7, var1117=$r8, var2105=r15, var273=org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream, var33=$r9, var2278=org.apache.dubbo.rpc.protocol.tri.frame.Deframer, var2357=$r10, var3044=0}
; {org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener=var1432, r0=var1242, io.netty.handler.codec.http2.Http2Headers=var2160, r2=var2633, org.apache.dubbo.rpc.TriRpcStatus=var489, $r1=var3074, $r14=var2259, $r4=var346, $r3=var2354, $r5=var2855, java.lang.Object=var887, $r6=var2514, $r7=var2877, $r8=var1117, r15=var2105, org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream=var273, $r9=var33, org.apache.dubbo.rpc.protocol.tri.frame.Deframer=var2278, $r10=var2357, 0=var3044}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener;	r2 := @parameter0: io.netty.handler.codec.http2.Http2Headers;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	if $r1 != null goto r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: io.netty.handler.codec.http2.Http2Headers trailers> = r2;	r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: io.netty.handler.codec.http2.Http2Headers trailers> = r2;	$r14 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	if $r14 != null goto $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	$r4 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("trailers: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = virtualinvoke $r4.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus appendDescription(java.lang.String)>($r7);	r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> = $r8;	r15 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	$r9 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0>;	$r10 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream: org.apache.dubbo.rpc.protocol.tri.frame.Deframer access$600(org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream)>($r9);	if $r10 != null goto $r11 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream this$0>;	virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: void finishProcess(org.apache.dubbo.rpc.TriRpcStatus,io.netty.handler.codec.http2.Http2Headers,boolean)>(r15, r2, 0);	goto [?= return];	return
;block_num 6
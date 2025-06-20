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

(declare-sort var3113 0)
(declare-sort var1955 0)
(declare-sort var1361 0)
(declare-sort var1010 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun withDescription/65961942 (var1955 String) var1955)
(declare-fun transportError/538743485 (var3113) var1955)
(declare-fun finishProcess/-761355745 (var3113 var1955 var1361 Bool) void)
(declare-const null-var3113 var3113)
(declare-const null-Int Int)
(declare-const var1955-CANCELLED var1955)
(declare-const null-NullType var1010)
(declare-const null-var1361 var1361)
(declare-const var2295 var3113) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener 
(assert (not (= var2295 null-var3113)))
(declare-const var2650 Int) ; Statement: l0 := @parameter0: long 
(assert (not (= var2650 null-Int)))
(define-const var1890 var1955 var1955-CANCELLED) ; Statement: $r2 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus CANCELLED> 
(define-const var2413 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2413)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2413!1 String)
(assert (= var2413!1 ""))
(assert true)
(define-const var1252 String (append/672562846 var2413!1 "Canceled by remote peer, errorCode=")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Canceled by remote peer, errorCode=") 
(declare-const var2413!2 String)
(assert (= var2413!2 (str.++ var2413!1 "Canceled by remote peer, errorCode=")))
(assert true)
(define-const var238 String (append/-901862667 var1252 var2650)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0) 
(declare-const var1252!1 String)
(assert (str.prefixof var1252 var1252!1))
(assert true)
(define-const var1641 String (toString/-2075883882 var238)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var192 var1955 (withDescription/65961942 var1890 var1641)) ; Statement: $r6 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r5) 
(declare-const var2295!1 var3113)
(assert (not (= var2295!1 null-var3113)))
(assert (= (transportError/538743485 var2295!1) var192)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> = $r6 
(define-const var1917 var1955 (transportError/538743485 var2295!1)) ; Statement: $r7 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> 
(assert true)
;(assert (finishProcess/-761355745 var2295!1 var1917 null-var1361 (ite (= 1 0) true false))) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: void finishProcess(org.apache.dubbo.rpc.TriRpcStatus,io.netty.handler.codec.http2.Http2Headers,boolean)>($r7, null, 0) 

(declare-const var2295!2 var3113)
(declare-const var1917!1 var1955)
(declare-const var146 var1010)
(declare-const var479 Int)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), withDescription/65961942=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus), transportError/538743485=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener], org.apache.dubbo.rpc.TriRpcStatus), finishProcess/-761355745=([org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener, org.apache.dubbo.rpc.TriRpcStatus, io.netty.handler.codec.http2.Http2Headers, boolean], void)}
; {var3113=org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener, var2295=r0, var2650=l0, var1955=org.apache.dubbo.rpc.TriRpcStatus, var1890=$r2, var2413=$r1, var1252=$r3, var238=$r4, var1641=$r5, var192=$r6, var1917=$r7, var1361=io.netty.handler.codec.http2.Http2Headers, var146=null, var1010=null_type, var479=0}
; {org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener=var3113, r0=var2295, l0=var2650, org.apache.dubbo.rpc.TriRpcStatus=var1955, $r2=var1890, $r1=var2413, $r3=var1252, $r4=var238, $r5=var1641, $r6=var192, $r7=var1917, io.netty.handler.codec.http2.Http2Headers=var1361, null=var146, null_type=var1010, 0=var479}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener;	l0 := @parameter0: long;	$r2 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus CANCELLED>;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Canceled by remote peer, errorCode=");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r5);	r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError> = $r6;	$r7 = r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: org.apache.dubbo.rpc.TriRpcStatus transportError>;	virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.stream.AbstractTripleClientStream$ClientTransportListener: void finishProcess(org.apache.dubbo.rpc.TriRpcStatus,io.netty.handler.codec.http2.Http2Headers,boolean)>($r7, null, 0);	return
;block_num 1
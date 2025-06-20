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

(declare-sort var718 0)
(declare-sort var2401 0)
(declare-sort var1 0)
(declare-sort var1284 0)
(declare-sort var1526 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun this$0/-765150024 (var718) var2401)
(declare-fun var1284-init () var1284)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun cast-from-var1-to-var1526 (var1) var1526)
(declare-fun getMessage/-836356268 (var1526) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var1284 String var1) void)
(declare-const null-var718 var718)
(declare-const null-Int Int)
(declare-const null-var1 var1)
(declare-const var1006 var718) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController$FlowState 
(assert (not (= var1006 null-var718)))
(declare-const var2411 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2411 null-Int)))
(define-const var1358 Int (- var2411)) ; Statement: i1 = neg i0 
(define-const var1804 var2401 (this$0/-765150024 var1006)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController$FlowState: org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController this$0> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3951 var1) ; Statement: $r3 := @caughtexception 
(assert (not (= var3951 null-var1)))
(define-const var3735 var1284 var1284-init) ; Statement: $r11 = new java.lang.IllegalStateException 
(define-const var3007 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3007)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3007!1 String)
(assert (= var3007!1 ""))
(assert true)
(define-const var232 String (append/672562846 var3007!1 "Invalid window state when writing frame: ")) ; Statement: $r7 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid window state when writing frame: ") 
(declare-const var3007!2 String)
(assert (= var3007!2 (str.++ var3007!1 "Invalid window state when writing frame: ")))
(define-const var2882 var1526 (cast-from-var1-to-var1526 var3951)) ; Statement: $r12 = (io.netty.handler.codec.http2.Http2Exception) $r3 
(assert true)
(define-const var1197 String (getMessage/-836356268 var2882)) ; Statement: $r6 = virtualinvoke $r12.<io.netty.handler.codec.http2.Http2Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var1778 String (append/672562846 var232 var1197)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var232!1 String)
(assert (= var232!1 (str.++ var232 var1197)))
(assert true)
(define-const var3731 String (toString/-2075883882 var1778)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var3735 var3731 var3951)) ; Statement: specialinvoke $r11.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r3) 

(declare-const var3735!1 var1284)
(declare-const var3731!1 String)
(declare-const var3951!1 var1)
 ; Statement: throw $r11 
(check-sat)
; {this$0/-765150024=([org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController$FlowState], org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController), var1284-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), cast-from-var1-to-var1526=([java.lang.Throwable], io.netty.handler.codec.http2.Http2Exception), getMessage/-836356268=([io.netty.handler.codec.http2.Http2Exception], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var718=org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController$FlowState, var1006=r0, var2411=i0, var1358=i1, var2401=org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController, var1804=$r1, var1=java.lang.Throwable, var3951=$r3, var1284=java.lang.IllegalStateException, var3735=$r11, var3007=$r10, var232=$r7, var1526=io.netty.handler.codec.http2.Http2Exception, var2882=$r12, var1197=$r6, var1778=$r8, var3731=$r9}
; {org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController$FlowState=var718, r0=var1006, i0=var2411, i1=var1358, org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController=var2401, $r1=var1804, java.lang.Throwable=var1, $r3=var3951, java.lang.IllegalStateException=var1284, $r11=var3735, $r10=var3007, $r7=var232, io.netty.handler.codec.http2.Http2Exception=var1526, $r12=var2882, $r6=var1197, $r8=var1778, $r9=var3731}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController$FlowState;	i0 := @parameter0: int;	i1 = neg i0;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController$FlowState: org.apache.dubbo.rpc.protocol.tri.TriHttp2RemoteFlowController this$0>;	$r3 := @caughtexception;	$r11 = new java.lang.IllegalStateException;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid window state when writing frame: ");	$r12 = (io.netty.handler.codec.http2.Http2Exception) $r3;	$r6 = virtualinvoke $r12.<io.netty.handler.codec.http2.Http2Exception: java.lang.String getMessage()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r11.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r9, $r3);	throw $r11
;block_num 2
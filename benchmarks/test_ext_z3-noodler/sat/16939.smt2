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

(declare-sort var367 0)
(declare-sort var738 0)
(declare-sort var3185 0)
(declare-sort var2536 0)
(declare-sort var1065 0)
(declare-sort var1424 0)
(declare-sort var3275 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSharedExecutorService/-955553454 (var1065) var2536)
(declare-fun cast-from-var367-to-var1065 (var367) var1065)
(declare-fun var1424-init () var1424)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var3275) ClassObject)
(declare-fun cast-from-var367-to-var3275 (var367) var3275)
(declare-fun append/-1031950772 (String var3275) String)
(declare-fun cast-from-ClassObject-to-var3275 (ClassObject) var3275)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var1424 var3275 var738 String var3185) void)
(declare-fun cast-from-String-to-var3275 (String) var3275)
(declare-const null-var367 var367)
(declare-const null-var738 var738)
(declare-const null-var3185 var3185)
(declare-const var2354 var367) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler 
(assert (not (= var2354 null-var367)))
(declare-const var3191 var738) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3191 null-var738)))
(declare-const var1105 var3185) ; Statement: r4 := @parameter1: java.lang.Throwable 
(assert (not (= var1105 null-var3185)))
(assert true)
(define-const var569 var2536 (getSharedExecutorService/-955553454 (cast-from-var367-to-var1065 var2354))) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1625 var3185) ; Statement: $r7 := @caughtexception 
(assert (not (= var1625 null-var3185)))
(define-const var2304 var1424 var1424-init) ; Statement: $r8 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var376 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var376)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var376!1 String)
(assert (= var376!1 ""))
(assert true)
(define-const var2880 ClassObject (getClass/1258963082 (cast-from-var367-to-var3275 var2354))) ; Statement: $r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var627 String (append/-1031950772 var376!1 (cast-from-ClassObject-to-var3275 var2880))) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10) 
(declare-const var376!2 String)
(assert (str.prefixof var376!1 var376!2))
(assert true)
(define-const var2996 String (append/672562846 var627 " error when process caught event .")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process caught event .") 
(declare-const var627!1 String)
(assert (= var627!1 (str.++ var627 " error when process caught event .")))
(assert true)
(define-const var3292 String (toString/-2075883882 var2996)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var2304 (cast-from-String-to-var3275 "caught event") var3191 var3292 var1625)) ; Statement: specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("caught event", r3, $r13, $r7) 

(declare-const var2304!1 var1424)
(declare-const var2837 String)
(declare-const var3191!1 var738)
(declare-const var3292!1 String)
(declare-const var1625!1 var3185)
 ; Statement: throw $r8 
(check-sat)
; {getSharedExecutorService/-955553454=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler], java.util.concurrent.ExecutorService), cast-from-var367-to-var1065=([org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var1424-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var367-to-var3275=([org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3275=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-String-to-var3275=([java.lang.String], java.lang.Object)}
; {var367=org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler, var2354=r0, var738=org.apache.dubbo.remoting.Channel, var3191=r3, var3185=java.lang.Throwable, var1105=r4, var2536=java.util.concurrent.ExecutorService, var1065=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var569=r1, var1625=$r7, var1424=org.apache.dubbo.remoting.ExecutionException, var2304=$r8, var376=$r9, var3275=java.lang.Object, var2880=$r10, var627=$r11, var2996=$r12, var3292=$r13, var2837="caught event"}
; {org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler=var367, r0=var2354, org.apache.dubbo.remoting.Channel=var738, r3=var3191, java.lang.Throwable=var3185, r4=var1105, java.util.concurrent.ExecutorService=var2536, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var1065, r1=var569, $r7=var1625, org.apache.dubbo.remoting.ExecutionException=var1424, $r8=var2304, $r9=var376, java.lang.Object=var3275, $r10=var2880, $r11=var627, $r12=var2996, $r13=var3292, "caught event"=var2837}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r4 := @parameter1: java.lang.Throwable;	r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>();	$r7 := @caughtexception;	$r8 = new org.apache.dubbo.remoting.ExecutionException;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process caught event .");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("caught event", r3, $r13, $r7);	throw $r8
;block_num 2
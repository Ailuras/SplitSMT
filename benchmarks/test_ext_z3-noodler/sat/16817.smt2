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

(declare-sort var1502 0)
(declare-sort var614 0)
(declare-sort var434 0)
(declare-sort var3298 0)
(declare-sort var3348 0)
(declare-sort var281 0)
(declare-sort var1386 0)
(declare-sort var2969 0)
(declare-sort var2458 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSharedExecutorService/-955553454 (var3298) var434)
(declare-fun cast-from-var1502-to-var3298 (var1502) var3298)
(declare-fun var3348-init () var3348)
(declare-fun handler/-1222735057 (var3298) var281)
(declare-fun var2969-init () var2969)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var2458) ClassObject)
(declare-fun cast-from-var1502-to-var2458 (var1502) var2458)
(declare-fun append/-1031950772 (String var2458) String)
(declare-fun cast-from-ClassObject-to-var2458 (ClassObject) var2458)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var2969 var2458 var614 String var1386) void)
(declare-fun cast-from-String-to-var2458 (String) var2458)
(declare-const null-var1502 var1502)
(declare-const null-var614 var614)
(declare-const null-var1386 var1386)
(declare-const var2014 var1502) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler 
(assert (not (= var2014 null-var1502)))
(declare-const var1529 var614) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1529 null-var614)))
(assert true)
(define-const var790 var434 (getSharedExecutorService/-955553454 (cast-from-var1502-to-var3298 var2014))) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>() 
(assert true) ; Non Conditional
(define-const var80 var3348 var3348-init) ; Statement: $r2 = new org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable 
(assert true) ; Non Conditional
(define-const var2850 var281 (handler/-1222735057 (cast-from-var1502-to-var3298 var2014))) ; Statement: $r5 = r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: org.apache.dubbo.remoting.ChannelHandler handler> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1629 var1386) ; Statement: $r6 := @caughtexception 
(assert (not (= var1629 null-var1386)))
(define-const var1960 var2969 var2969-init) ; Statement: $r7 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var442 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var442)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var442!1 String)
(assert (= var442!1 ""))
(assert true)
(define-const var2952 ClassObject (getClass/1258963082 (cast-from-var1502-to-var2458 var2014))) ; Statement: $r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1673 String (append/-1031950772 var442!1 (cast-from-ClassObject-to-var2458 var2952))) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var442!2 String)
(assert (str.prefixof var442!1 var442!2))
(assert true)
(define-const var1152 String (append/672562846 var1673 " error when process disconnected event .")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process disconnected event .") 
(declare-const var1673!1 String)
(assert (= var1673!1 (str.++ var1673 " error when process disconnected event .")))
(assert true)
(define-const var3262 String (toString/-2075883882 var1152)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var1960 (cast-from-String-to-var2458 "disconnect event") var1529 var3262 var1629)) ; Statement: specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("disconnect event", r3, $r12, $r6) 

(declare-const var1960!1 var2969)
(declare-const var1703 String)
(declare-const var1529!1 var614)
(declare-const var3262!1 String)
(declare-const var1629!1 var1386)
 ; Statement: throw $r7 
(check-sat)
; {getSharedExecutorService/-955553454=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler], java.util.concurrent.ExecutorService), cast-from-var1502-to-var3298=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var3348-init=([], org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable), handler/-1222735057=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler], org.apache.dubbo.remoting.ChannelHandler), var2969-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var1502-to-var2458=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var2458=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-String-to-var2458=([java.lang.String], java.lang.Object)}
; {var1502=org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler, var2014=r0, var614=org.apache.dubbo.remoting.Channel, var1529=r3, var434=java.util.concurrent.ExecutorService, var3298=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var790=r1, var3348=org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable, var80=$r2, var281=org.apache.dubbo.remoting.ChannelHandler, var2850=$r5, var1386=java.lang.Throwable, var1629=$r6, var2969=org.apache.dubbo.remoting.ExecutionException, var1960=$r7, var442=$r8, var2458=java.lang.Object, var2952=$r9, var1673=$r10, var1152=$r11, var3262=$r12, var1703="disconnect event"}
; {org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler=var1502, r0=var2014, org.apache.dubbo.remoting.Channel=var614, r3=var1529, java.util.concurrent.ExecutorService=var434, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var3298, r1=var790, org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable=var3348, $r2=var80, org.apache.dubbo.remoting.ChannelHandler=var281, $r5=var2850, java.lang.Throwable=var1386, $r6=var1629, org.apache.dubbo.remoting.ExecutionException=var2969, $r7=var1960, $r8=var442, java.lang.Object=var2458, $r9=var2952, $r10=var1673, $r11=var1152, $r12=var3262, "disconnect event"=var1703}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>();	$r2 = new org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable;	$r5 = r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: org.apache.dubbo.remoting.ChannelHandler handler>;	$r6 := @caughtexception;	$r7 = new org.apache.dubbo.remoting.ExecutionException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process disconnected event .");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("disconnect event", r3, $r12, $r6);	throw $r7
;block_num 4
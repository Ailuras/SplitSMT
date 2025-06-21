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

(declare-sort var3100 0)
(declare-sort var2522 0)
(declare-sort var490 0)
(declare-sort var3369 0)
(declare-sort var66 0)
(declare-sort var914 0)
(declare-sort var570 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPreferredExecutorService/166314845 (var66 var490) var3369)
(declare-fun cast-from-var3100-to-var66 (var3100) var66)
(declare-fun var570-init () var570)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var490) ClassObject)
(declare-fun cast-from-var3100-to-var490 (var3100) var490)
(declare-fun append/-1031950772 (String var490) String)
(declare-fun cast-from-ClassObject-to-var490 (ClassObject) var490)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var570 var490 var2522 String var914) void)
(declare-const null-var3100 var3100)
(declare-const null-var2522 var2522)
(declare-const null-var490 var490)
(declare-const null-var914 var914)
(declare-const var3412 var3100) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler 
(assert (not (= var3412 null-var3100)))
(declare-const var2286 var2522) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2286 null-var2522)))
(declare-const var1487 var490) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var1487 null-var490)))
(assert true)
(define-const var872 var3369 (getPreferredExecutorService/166314845 (cast-from-var3100-to-var66 var3412) var1487)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1) 
(define-const var2863 Bool true) ; Statement: $z0 = r2 instanceof org.apache.dubbo.common.threadpool.ThreadlessExecutor 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler: org.apache.dubbo.remoting.ChannelHandler handler> 
(assert (not (= (ite var2863 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var3979 var914) ; Statement: $r8 := @caughtexception 
(assert (not (= var3979 null-var914)))
(define-const var1449 var570 var570-init) ; Statement: $r9 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var2335 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2335)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2335!1 String)
(assert (= var2335!1 ""))
(assert true)
(define-const var2039 ClassObject (getClass/1258963082 (cast-from-var3100-to-var490 var3412))) ; Statement: $r11 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1623 String (append/-1031950772 var2335!1 (cast-from-ClassObject-to-var490 var2039))) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11) 
(declare-const var2335!2 String)
(assert (str.prefixof var2335!1 var2335!2))
(assert true)
(define-const var2388 String (append/672562846 var1623 " error when process received event .")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event .") 
(declare-const var1623!1 String)
(assert (= var1623!1 (str.++ var1623 " error when process received event .")))
(assert true)
(define-const var1328 String (toString/-2075883882 var2388)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var1449 var1487 var2286 var1328 var3979)) ; Statement: specialinvoke $r9.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r3, $r14, $r8) 

(declare-const var1449!1 var570)
(declare-const var1487!1 var490)
(declare-const var2286!1 var2522)
(declare-const var1328!1 String)
(declare-const var3979!1 var914)
 ; Statement: throw $r9 
(check-sat)
; {getPreferredExecutorService/166314845=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, java.lang.Object], java.util.concurrent.ExecutorService), cast-from-var3100-to-var66=([org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var570-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3100-to-var490=([org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var490=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void)}
; {var3100=org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler, var3412=r0, var2522=org.apache.dubbo.remoting.Channel, var2286=r3, var490=java.lang.Object, var1487=r1, var3369=java.util.concurrent.ExecutorService, var66=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var872=r2, var2863=$z0, var914=java.lang.Throwable, var3979=$r8, var570=org.apache.dubbo.remoting.ExecutionException, var1449=$r9, var2335=$r10, var2039=$r11, var1623=$r12, var2388=$r13, var1328=$r14}
; {org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler=var3100, r0=var3412, org.apache.dubbo.remoting.Channel=var2522, r3=var2286, java.lang.Object=var490, r1=var1487, java.util.concurrent.ExecutorService=var3369, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var66, r2=var872, $z0=var2863, java.lang.Throwable=var914, $r8=var3979, org.apache.dubbo.remoting.ExecutionException=var570, $r9=var1449, $r10=var2335, $r11=var2039, $r12=var1623, $r13=var2388, $r14=var1328}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 := @parameter1: java.lang.Object;	r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1);	$z0 = r2 instanceof org.apache.dubbo.common.threadpool.ThreadlessExecutor;	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.remoting.transport.dispatcher.direct.DirectChannelHandler: org.apache.dubbo.remoting.ChannelHandler handler>;	$r8 := @caughtexception;	$r9 = new org.apache.dubbo.remoting.ExecutionException;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event .");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r9.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r3, $r14, $r8);	throw $r9
;block_num 2
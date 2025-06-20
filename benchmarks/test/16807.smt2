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

(declare-sort var2996 0)
(declare-sort var2399 0)
(declare-sort var3403 0)
(declare-sort var846 0)
(declare-sort var2671 0)
(declare-sort var1881 0)
(declare-sort var1121 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSharedExecutorService/-955553454 (var846) var3403)
(declare-fun cast-from-var2996-to-var846 (var2996) var846)
(declare-fun var1881-init () var1881)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var1121) ClassObject)
(declare-fun cast-from-var2996-to-var1121 (var2996) var1121)
(declare-fun append/-1031950772 (String var1121) String)
(declare-fun cast-from-ClassObject-to-var1121 (ClassObject) var1121)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var1881 var1121 var2399 String var2671) void)
(declare-fun cast-from-String-to-var1121 (String) var1121)
(declare-const null-var2996 var2996)
(declare-const null-var2399 var2399)
(declare-const null-var2671 var2671)
(declare-const var990 var2996) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler 
(assert (not (= var990 null-var2996)))
(declare-const var251 var2399) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var251 null-var2399)))
(assert true)
(define-const var2485 var3403 (getSharedExecutorService/-955553454 (cast-from-var2996-to-var846 var990))) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3291 var2671) ; Statement: $r6 := @caughtexception 
(assert (not (= var3291 null-var2671)))
(define-const var2315 var1881 var1881-init) ; Statement: $r7 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var900 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var900)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var900!1 String)
(assert (= var900!1 ""))
(assert true)
(define-const var818 ClassObject (getClass/1258963082 (cast-from-var2996-to-var1121 var990))) ; Statement: $r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var427 String (append/-1031950772 var900!1 (cast-from-ClassObject-to-var1121 var818))) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var900!2 String)
(assert (str.prefixof var900!1 var900!2))
(assert true)
(define-const var1658 String (append/672562846 var427 " error when process disconnected event .")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process disconnected event .") 
(declare-const var427!1 String)
(assert (= var427!1 (str.++ var427 " error when process disconnected event .")))
(assert true)
(define-const var1582 String (toString/-2075883882 var1658)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var2315 (cast-from-String-to-var1121 "disconnect event") var251 var1582 var3291)) ; Statement: specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("disconnect event", r3, $r12, $r6) 

(declare-const var2315!1 var1881)
(declare-const var2760 String)
(declare-const var251!1 var2399)
(declare-const var1582!1 String)
(declare-const var3291!1 var2671)
 ; Statement: throw $r7 
(check-sat)
; {getSharedExecutorService/-955553454=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler], java.util.concurrent.ExecutorService), cast-from-var2996-to-var846=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var1881-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var2996-to-var1121=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var1121=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-String-to-var1121=([java.lang.String], java.lang.Object)}
; {var2996=org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler, var990=r0, var2399=org.apache.dubbo.remoting.Channel, var251=r3, var3403=java.util.concurrent.ExecutorService, var846=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var2485=r1, var2671=java.lang.Throwable, var3291=$r6, var1881=org.apache.dubbo.remoting.ExecutionException, var2315=$r7, var900=$r8, var1121=java.lang.Object, var818=$r9, var427=$r10, var1658=$r11, var1582=$r12, var2760="disconnect event"}
; {org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler=var2996, r0=var990, org.apache.dubbo.remoting.Channel=var2399, r3=var251, java.util.concurrent.ExecutorService=var3403, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var846, r1=var2485, java.lang.Throwable=var2671, $r6=var3291, org.apache.dubbo.remoting.ExecutionException=var1881, $r7=var2315, $r8=var900, java.lang.Object=var1121, $r9=var818, $r10=var427, $r11=var1658, $r12=var1582, "disconnect event"=var2760}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>();	$r6 := @caughtexception;	$r7 = new org.apache.dubbo.remoting.ExecutionException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process disconnected event .");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("disconnect event", r3, $r12, $r6);	throw $r7
;block_num 2
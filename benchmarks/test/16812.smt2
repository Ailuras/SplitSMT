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

(declare-sort var3019 0)
(declare-sort var2607 0)
(declare-sort var1990 0)
(declare-sort var3273 0)
(declare-sort var3628 0)
(declare-sort var1664 0)
(declare-sort var3132 0)
(declare-sort var417 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSharedExecutorService/-955553454 (var3273) var1990)
(declare-fun cast-from-var3019-to-var3273 (var3019) var3273)
(declare-fun var3628-init () var3628)
(declare-fun var3132-init () var3132)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var417) ClassObject)
(declare-fun cast-from-var3019-to-var417 (var3019) var417)
(declare-fun append/-1031950772 (String var417) String)
(declare-fun cast-from-ClassObject-to-var417 (ClassObject) var417)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var3132 var417 var2607 String var1664) void)
(declare-fun cast-from-String-to-var417 (String) var417)
(declare-const null-var3019 var3019)
(declare-const null-var2607 var2607)
(declare-const null-var1664 var1664)
(declare-const var2441 var3019) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler 
(assert (not (= var2441 null-var3019)))
(declare-const var2971 var2607) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2971 null-var2607)))
(assert true)
(define-const var673 var1990 (getSharedExecutorService/-955553454 (cast-from-var3019-to-var3273 var2441))) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>() 
(assert true) ; Non Conditional
(define-const var3467 var3628 var3628-init) ; Statement: $r2 = new org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var665 var1664) ; Statement: $r6 := @caughtexception 
(assert (not (= var665 null-var1664)))
(define-const var2856 var3132 var3132-init) ; Statement: $r7 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var2244 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2244)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2244!1 String)
(assert (= var2244!1 ""))
(assert true)
(define-const var850 ClassObject (getClass/1258963082 (cast-from-var3019-to-var417 var2441))) ; Statement: $r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3431 String (append/-1031950772 var2244!1 (cast-from-ClassObject-to-var417 var850))) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var2244!2 String)
(assert (str.prefixof var2244!1 var2244!2))
(assert true)
(define-const var1370 String (append/672562846 var3431 " error when process disconnected event .")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process disconnected event .") 
(declare-const var3431!1 String)
(assert (= var3431!1 (str.++ var3431 " error when process disconnected event .")))
(assert true)
(define-const var3087 String (toString/-2075883882 var1370)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var2856 (cast-from-String-to-var417 "disconnect event") var2971 var3087 var665)) ; Statement: specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("disconnect event", r3, $r12, $r6) 

(declare-const var2856!1 var3132)
(declare-const var1577 String)
(declare-const var2971!1 var2607)
(declare-const var3087!1 String)
(declare-const var665!1 var1664)
 ; Statement: throw $r7 
(check-sat)
; {getSharedExecutorService/-955553454=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler], java.util.concurrent.ExecutorService), cast-from-var3019-to-var3273=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var3628-init=([], org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable), var3132-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3019-to-var417=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var417=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-String-to-var417=([java.lang.String], java.lang.Object)}
; {var3019=org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler, var2441=r0, var2607=org.apache.dubbo.remoting.Channel, var2971=r3, var1990=java.util.concurrent.ExecutorService, var3273=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var673=r1, var3628=org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable, var3467=$r2, var1664=java.lang.Throwable, var665=$r6, var3132=org.apache.dubbo.remoting.ExecutionException, var2856=$r7, var2244=$r8, var417=java.lang.Object, var850=$r9, var3431=$r10, var1370=$r11, var3087=$r12, var1577="disconnect event"}
; {org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler=var3019, r0=var2441, org.apache.dubbo.remoting.Channel=var2607, r3=var2971, java.util.concurrent.ExecutorService=var1990, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var3273, r1=var673, org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable=var3628, $r2=var3467, java.lang.Throwable=var1664, $r6=var665, org.apache.dubbo.remoting.ExecutionException=var3132, $r7=var2856, $r8=var2244, java.lang.Object=var417, $r9=var850, $r10=var3431, $r11=var1370, $r12=var3087, "disconnect event"=var1577}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>();	$r2 = new org.apache.dubbo.remoting.transport.dispatcher.ChannelEventRunnable;	$r6 := @caughtexception;	$r7 = new org.apache.dubbo.remoting.ExecutionException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process disconnected event .");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("disconnect event", r3, $r12, $r6);	throw $r7
;block_num 3
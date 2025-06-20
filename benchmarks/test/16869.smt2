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

(declare-sort var2484 0)
(declare-sort var2418 0)
(declare-sort var875 0)
(declare-sort var3565 0)
(declare-sort var156 0)
(declare-sort var2832 0)
(declare-sort var2518 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSharedExecutorService/-955553454 (var156) var3565)
(declare-fun cast-from-var2484-to-var156 (var2484) var156)
(declare-fun var2832-init () var2832)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var2518) ClassObject)
(declare-fun cast-from-var2484-to-var2518 (var2484) var2518)
(declare-fun append/-1031950772 (String var2518) String)
(declare-fun cast-from-ClassObject-to-var2518 (ClassObject) var2518)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var2832 var2518 var2418 String var875) void)
(declare-fun cast-from-String-to-var2518 (String) var2518)
(declare-const null-var2484 var2484)
(declare-const null-var2418 var2418)
(declare-const null-var875 var875)
(declare-const var1456 var2484) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler 
(assert (not (= var1456 null-var2484)))
(declare-const var3007 var2418) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3007 null-var2418)))
(declare-const var433 var875) ; Statement: r4 := @parameter1: java.lang.Throwable 
(assert (not (= var433 null-var875)))
(assert true)
(define-const var1129 var3565 (getSharedExecutorService/-955553454 (cast-from-var2484-to-var156 var1456))) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3062 var875) ; Statement: $r7 := @caughtexception 
(assert (not (= var3062 null-var875)))
(define-const var3979 var2832 var2832-init) ; Statement: $r8 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var933 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var933)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var933!1 String)
(assert (= var933!1 ""))
(assert true)
(define-const var2992 ClassObject (getClass/1258963082 (cast-from-var2484-to-var2518 var1456))) ; Statement: $r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3547 String (append/-1031950772 var933!1 (cast-from-ClassObject-to-var2518 var2992))) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10) 
(declare-const var933!2 String)
(assert (str.prefixof var933!1 var933!2))
(assert true)
(define-const var262 String (append/672562846 var3547 " error when process caught event .")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process caught event .") 
(declare-const var3547!1 String)
(assert (= var3547!1 (str.++ var3547 " error when process caught event .")))
(assert true)
(define-const var3078 String (toString/-2075883882 var262)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var3979 (cast-from-String-to-var2518 "caught event") var3007 var3078 var3062)) ; Statement: specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("caught event", r3, $r13, $r7) 

(declare-const var3979!1 var2832)
(declare-const var2226 String)
(declare-const var3007!1 var2418)
(declare-const var3078!1 String)
(declare-const var3062!1 var875)
 ; Statement: throw $r8 
(check-sat)
; {getSharedExecutorService/-955553454=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler], java.util.concurrent.ExecutorService), cast-from-var2484-to-var156=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var2832-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var2484-to-var2518=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var2518=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-String-to-var2518=([java.lang.String], java.lang.Object)}
; {var2484=org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler, var1456=r0, var2418=org.apache.dubbo.remoting.Channel, var3007=r3, var875=java.lang.Throwable, var433=r4, var3565=java.util.concurrent.ExecutorService, var156=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var1129=r1, var3062=$r7, var2832=org.apache.dubbo.remoting.ExecutionException, var3979=$r8, var933=$r9, var2518=java.lang.Object, var2992=$r10, var3547=$r11, var262=$r12, var3078=$r13, var2226="caught event"}
; {org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler=var2484, r0=var1456, org.apache.dubbo.remoting.Channel=var2418, r3=var3007, java.lang.Throwable=var875, r4=var433, java.util.concurrent.ExecutorService=var3565, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var156, r1=var1129, $r7=var3062, org.apache.dubbo.remoting.ExecutionException=var2832, $r8=var3979, $r9=var933, java.lang.Object=var2518, $r10=var2992, $r11=var3547, $r12=var262, $r13=var3078, "caught event"=var2226}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r4 := @parameter1: java.lang.Throwable;	r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>();	$r7 := @caughtexception;	$r8 = new org.apache.dubbo.remoting.ExecutionException;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process caught event .");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("caught event", r3, $r13, $r7);	throw $r8
;block_num 2
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

(declare-sort var1099 0)
(declare-sort var2168 0)
(declare-sort var2872 0)
(declare-sort var3188 0)
(declare-sort var3024 0)
(declare-sort var1640 0)
(declare-sort var3155 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSharedExecutorService/-955553454 (var3188) var2872)
(declare-fun cast-from-var1099-to-var3188 (var1099) var3188)
(declare-fun var1640-init () var1640)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var3155) ClassObject)
(declare-fun cast-from-var1099-to-var3155 (var1099) var3155)
(declare-fun append/-1031950772 (String var3155) String)
(declare-fun cast-from-ClassObject-to-var3155 (ClassObject) var3155)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var1640 var3155 var2168 String var3024) void)
(declare-fun cast-from-String-to-var3155 (String) var3155)
(declare-const null-var1099 var1099)
(declare-const null-var2168 var2168)
(declare-const null-var3024 var3024)
(declare-const var1234 var1099) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler 
(assert (not (= var1234 null-var1099)))
(declare-const var50 var2168) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var50 null-var2168)))
(assert true)
(define-const var147 var2872 (getSharedExecutorService/-955553454 (cast-from-var1099-to-var3188 var1234))) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var618 var3024) ; Statement: $r6 := @caughtexception 
(assert (not (= var618 null-var3024)))
(define-const var3481 var1640 var1640-init) ; Statement: $r7 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var83 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var83)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var83!1 String)
(assert (= var83!1 ""))
(assert true)
(define-const var2552 ClassObject (getClass/1258963082 (cast-from-var1099-to-var3155 var1234))) ; Statement: $r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3207 String (append/-1031950772 var83!1 (cast-from-ClassObject-to-var3155 var2552))) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var83!2 String)
(assert (str.prefixof var83!1 var83!2))
(assert true)
(define-const var1781 String (append/672562846 var3207 " error when process connected event .")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process connected event .") 
(declare-const var3207!1 String)
(assert (= var3207!1 (str.++ var3207 " error when process connected event .")))
(assert true)
(define-const var1591 String (toString/-2075883882 var1781)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var3481 (cast-from-String-to-var3155 "connect event") var50 var1591 var618)) ; Statement: specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("connect event", r3, $r12, $r6) 

(declare-const var3481!1 var1640)
(declare-const var3548 String)
(declare-const var50!1 var2168)
(declare-const var1591!1 String)
(declare-const var618!1 var3024)
 ; Statement: throw $r7 
(check-sat)
; {getSharedExecutorService/-955553454=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler], java.util.concurrent.ExecutorService), cast-from-var1099-to-var3188=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var1640-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var1099-to-var3155=([org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3155=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-String-to-var3155=([java.lang.String], java.lang.Object)}
; {var1099=org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler, var1234=r0, var2168=org.apache.dubbo.remoting.Channel, var50=r3, var2872=java.util.concurrent.ExecutorService, var3188=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var147=r1, var3024=java.lang.Throwable, var618=$r6, var1640=org.apache.dubbo.remoting.ExecutionException, var3481=$r7, var83=$r8, var3155=java.lang.Object, var2552=$r9, var3207=$r10, var1781=$r11, var1591=$r12, var3548="connect event"}
; {org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler=var1099, r0=var1234, org.apache.dubbo.remoting.Channel=var2168, r3=var50, java.util.concurrent.ExecutorService=var2872, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var3188, r1=var147, java.lang.Throwable=var3024, $r6=var618, org.apache.dubbo.remoting.ExecutionException=var1640, $r7=var3481, $r8=var83, java.lang.Object=var3155, $r9=var2552, $r10=var3207, $r11=var1781, $r12=var1591, "connect event"=var3548}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.all.AllChannelHandler: java.util.concurrent.ExecutorService getSharedExecutorService()>();	$r6 := @caughtexception;	$r7 = new org.apache.dubbo.remoting.ExecutionException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process connected event .");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("connect event", r3, $r12, $r6);	throw $r7
;block_num 2
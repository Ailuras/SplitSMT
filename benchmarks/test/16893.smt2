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

(declare-sort var2016 0)
(declare-sort var739 0)
(declare-sort var1935 0)
(declare-sort var2539 0)
(declare-sort var714 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2539-init () var2539)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var714) ClassObject)
(declare-fun cast-from-var2016-to-var714 (var2016) var714)
(declare-fun append/-1031950772 (String var714) String)
(declare-fun cast-from-ClassObject-to-var714 (ClassObject) var714)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var2539 var714 var739 String var1935) void)
(declare-fun cast-from-String-to-var714 (String) var714)
(declare-const null-var2016 var2016)
(declare-const null-var739 var739)
(declare-const null-var1935 var1935)
(declare-const var3081 var2016) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler 
(assert (not (= var3081 null-var2016)))
(declare-const var2337 var739) ; Statement: r2 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2337 null-var739)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var389 var1935) ; Statement: $r6 := @caughtexception 
(assert (not (= var389 null-var1935)))
(define-const var1205 var2539 var2539-init) ; Statement: $r7 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var1742 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1742)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1742!1 String)
(assert (= var1742!1 ""))
(assert true)
(define-const var1482 ClassObject (getClass/1258963082 (cast-from-var2016-to-var714 var3081))) ; Statement: $r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var808 String (append/-1031950772 var1742!1 (cast-from-ClassObject-to-var714 var1482))) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var1742!2 String)
(assert (str.prefixof var1742!1 var1742!2))
(assert true)
(define-const var1116 String (append/672562846 var808 " error when process disconnected event .")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process disconnected event .") 
(declare-const var808!1 String)
(assert (= var808!1 (str.++ var808 " error when process disconnected event .")))
(assert true)
(define-const var825 String (toString/-2075883882 var1116)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var1205 (cast-from-String-to-var714 "disconnected event") var2337 var825 var389)) ; Statement: specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("disconnected event", r2, $r12, $r6) 

(declare-const var1205!1 var2539)
(declare-const var1005 String)
(declare-const var2337!1 var739)
(declare-const var825!1 String)
(declare-const var389!1 var1935)
 ; Statement: throw $r7 
(check-sat)
; {var2539-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var2016-to-var714=([org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var714=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-String-to-var714=([java.lang.String], java.lang.Object)}
; {var2016=org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler, var3081=r0, var739=org.apache.dubbo.remoting.Channel, var2337=r2, var1935=java.lang.Throwable, var389=$r6, var2539=org.apache.dubbo.remoting.ExecutionException, var1205=$r7, var1742=$r8, var714=java.lang.Object, var1482=$r9, var808=$r10, var1116=$r11, var825=$r12, var1005="disconnected event"}
; {org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler=var2016, r0=var3081, org.apache.dubbo.remoting.Channel=var739, r2=var2337, java.lang.Throwable=var1935, $r6=var389, org.apache.dubbo.remoting.ExecutionException=var2539, $r7=var1205, $r8=var1742, java.lang.Object=var714, $r9=var1482, $r10=var808, $r11=var1116, $r12=var825, "disconnected event"=var1005}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.connection.ConnectionOrderedChannelHandler;	r2 := @parameter0: org.apache.dubbo.remoting.Channel;	$r6 := @caughtexception;	$r7 = new org.apache.dubbo.remoting.ExecutionException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process disconnected event .");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>("disconnected event", r2, $r12, $r6);	throw $r7
;block_num 2
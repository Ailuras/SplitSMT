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

(declare-sort var1445 0)
(declare-sort var1049 0)
(declare-sort var2885 0)
(declare-sort var250 0)
(declare-sort var548 0)
(declare-sort var2404 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun closed/967243351 (var1445) Bool)
(declare-fun var250-init () var250)
(declare-fun getLocalAddress/-1826531475 (var1445) var548)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1049) String)
(declare-fun cast-from-var1445-to-var1049 (var1445) var1049)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/2011950133 (var250 var548 var548 String) void)
(declare-const null-var1445 var1445)
(declare-const null-var1049 var1049)
(declare-const null-Int Int)
(declare-const null-var2885 var2885)
(declare-const null-NullType var2404)
(declare-const null-var548 var548)
(declare-const var3474 var1445) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel 
(assert (not (= var3474 null-var1445)))
(declare-const var3226 var1049) ; Statement: r1 := @parameter0: java.lang.Object 
(assert (not (= var3226 null-var1049)))
(declare-const var3326 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3326 null-Int)))
(declare-const var934 var2885) ; Statement: r4 := @parameter2: java.util.concurrent.ExecutorService 
(assert (not (= var934 null-var2885)))
(define-const var865 Bool (closed/967243351 var3474)) ; Statement: $z0 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: boolean closed> 
 ; Statement: if $z0 == 0 goto $z1 = r1 instanceof org.apache.dubbo.remoting.exchange.Request 
(assert (not (= (ite var865 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3801 var250 var250-init) ; Statement: $r8 = new org.apache.dubbo.remoting.RemotingException 
(assert true)
(define-const var3296 var548 (getLocalAddress/-1826531475 var3474)) ; Statement: $r16 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: java.net.InetSocketAddress getLocalAddress()>() 
(define-const var2534 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2534)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2534!1 String)
(assert (= var2534!1 ""))
(assert true)
(define-const var740 String (append/672562846 var2534!1 "Failed to send request ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send request ") 
(declare-const var2534!2 String)
(assert (= var2534!2 (str.++ var2534!1 "Failed to send request ")))
(assert true)
(define-const var2817 String (append/-1031950772 var740 var3226)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var740!1 String)
(assert (str.prefixof var740 var740!1))
(assert true)
(define-const var3462 String (append/672562846 var2817 ", cause: The channel ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The channel ") 
(declare-const var2817!1 String)
(assert (= var2817!1 (str.++ var2817 ", cause: The channel ")))
(assert true)
(define-const var2202 String (append/-1031950772 var3462 (cast-from-var1445-to-var1049 var3474))) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var3462!1 String)
(assert (str.prefixof var3462 var3462!1))
(assert true)
(define-const var2509 String (append/672562846 var2202 " is closed!")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!") 
(declare-const var2202!1 String)
(assert (= var2202!1 (str.++ var2202 " is closed!")))
(assert true)
(define-const var1308 String (toString/-2075883882 var2509)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/2011950133 var3801 var3296 null-var548 var1308)) ; Statement: specialinvoke $r8.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>($r16, null, $r15) 

(declare-const var3801!1 var250)
(declare-const var3296!1 var548)
(declare-const var3795 var2404)
(declare-const var1308!1 String)
 ; Statement: throw $r8 
(check-sat)
; {closed/967243351=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel], boolean), var250-init=([], org.apache.dubbo.remoting.RemotingException), getLocalAddress/-1826531475=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel], java.net.InetSocketAddress), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1445-to-var1049=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/2011950133=([org.apache.dubbo.remoting.RemotingException, java.net.InetSocketAddress, java.net.InetSocketAddress, java.lang.String], void)}
; {var1445=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel, var3474=r0, var1049=java.lang.Object, var3226=r1, var3326=i0, var2885=java.util.concurrent.ExecutorService, var934=r4, var865=$z0, var250=org.apache.dubbo.remoting.RemotingException, var3801=$r8, var548=java.net.InetSocketAddress, var3296=$r16, var2534=$r9, var740=$r10, var2817=$r11, var3462=$r12, var2202=$r13, var2509=$r14, var1308=$r15, var3795=null, var2404=null_type}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel=var1445, r0=var3474, java.lang.Object=var1049, r1=var3226, i0=var3326, java.util.concurrent.ExecutorService=var2885, r4=var934, $z0=var865, org.apache.dubbo.remoting.RemotingException=var250, $r8=var3801, java.net.InetSocketAddress=var548, $r16=var3296, $r9=var2534, $r10=var740, $r11=var2817, $r12=var3462, $r13=var2202, $r14=var2509, $r15=var1308, null=var3795, null_type=var2404}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel;	r1 := @parameter0: java.lang.Object;	i0 := @parameter1: int;	r4 := @parameter2: java.util.concurrent.ExecutorService;	$z0 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: boolean closed>;	if $z0 == 0 goto $z1 = r1 instanceof org.apache.dubbo.remoting.exchange.Request;	$r8 = new org.apache.dubbo.remoting.RemotingException;	$r16 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeChannel: java.net.InetSocketAddress getLocalAddress()>();	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send request ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The channel ");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>($r16, null, $r15);	throw $r8
;block_num 2
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

(declare-sort var277 0)
(declare-sort var1642 0)
(declare-sort var2227 0)
(declare-sort var220 0)
(declare-sort var3235 0)
(declare-sort var145 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun closed/-1591198865 (var277) var2227)
(declare-fun get/2135855162 (var2227) Bool)
(declare-fun var220-init () var220)
(declare-fun getLocalAddress/-63303331 (var277) var3235)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1642) String)
(declare-fun cast-from-var3235-to-var1642 (var3235) var1642)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/2011950133 (var220 var3235 var3235 String) void)
(declare-const null-var277 var277)
(declare-const null-var1642 var1642)
(declare-const null-NullType var145)
(declare-const null-var3235 var3235)
(declare-const var2545 var277) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer 
(assert (not (= var2545 null-var277)))
(declare-const var2352 var1642) ; Statement: r2 := @parameter0: java.lang.Object 
(assert (not (= var2352 null-var1642)))
(define-const var836 var2227 (closed/-1591198865 var2545)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.util.concurrent.atomic.AtomicBoolean closed> 
(assert true)
(define-const var1022 Bool (get/2135855162 var836)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server> 
(assert (not (= (ite var1022 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2120 var220 var220-init) ; Statement: $r4 = new org.apache.dubbo.remoting.RemotingException 
(assert true)
(define-const var3798 var3235 (getLocalAddress/-63303331 var2545)) ; Statement: $r13 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.net.InetSocketAddress getLocalAddress()>() 
(define-const var2139 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2139)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2139!1 String)
(assert (= var2139!1 ""))
(assert true)
(define-const var617 String (append/672562846 var2139!1 "Failed to send message ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ") 
(declare-const var2139!2 String)
(assert (= var2139!2 (str.++ var2139!1 "Failed to send message ")))
(assert true)
(define-const var187 String (append/-1031950772 var617 var2352)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var617!1 String)
(assert (str.prefixof var617 var617!1))
(assert true)
(define-const var209 String (append/672562846 var187 ", cause: The server ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The server ") 
(declare-const var187!1 String)
(assert (= var187!1 (str.++ var187 ", cause: The server ")))
(assert true)
(define-const var1439 var3235 (getLocalAddress/-63303331 var2545)) ; Statement: $r8 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var2600 String (append/-1031950772 var209 (cast-from-var3235-to-var1642 var1439))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var209!1 String)
(assert (str.prefixof var209 var209!1))
(assert true)
(define-const var2203 String (append/672562846 var2600 " is closed!")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!") 
(declare-const var2600!1 String)
(assert (= var2600!1 (str.++ var2600 " is closed!")))
(assert true)
(define-const var994 String (toString/-2075883882 var2203)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/2011950133 var2120 var3798 null-var3235 var994)) ; Statement: specialinvoke $r4.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>($r13, null, $r12) 

(declare-const var2120!1 var220)
(declare-const var3798!1 var3235)
(declare-const var3100 var145)
(declare-const var994!1 String)
 ; Statement: throw $r4 
(check-sat)
; {closed/-1591198865=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean), var220-init=([], org.apache.dubbo.remoting.RemotingException), getLocalAddress/-63303331=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer], java.net.InetSocketAddress), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3235-to-var1642=([java.net.InetSocketAddress], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/2011950133=([org.apache.dubbo.remoting.RemotingException, java.net.InetSocketAddress, java.net.InetSocketAddress, java.lang.String], void)}
; {var277=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer, var2545=r0, var1642=java.lang.Object, var2352=r2, var2227=java.util.concurrent.atomic.AtomicBoolean, var836=$r1, var1022=$z0, var220=org.apache.dubbo.remoting.RemotingException, var2120=$r4, var3235=java.net.InetSocketAddress, var3798=$r13, var2139=$r5, var617=$r6, var187=$r7, var209=$r9, var1439=$r8, var2600=$r10, var2203=$r11, var994=$r12, var3100=null, var145=null_type}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer=var277, r0=var2545, java.lang.Object=var1642, r2=var2352, java.util.concurrent.atomic.AtomicBoolean=var2227, $r1=var836, $z0=var1022, org.apache.dubbo.remoting.RemotingException=var220, $r4=var2120, java.net.InetSocketAddress=var3235, $r13=var3798, $r5=var2139, $r6=var617, $r7=var187, $r9=var209, $r8=var1439, $r10=var2600, $r11=var2203, $r12=var994, null=var3100, null_type=var145}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer;	r2 := @parameter0: java.lang.Object;	$r1 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.util.concurrent.atomic.AtomicBoolean closed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server>;	$r4 = new org.apache.dubbo.remoting.RemotingException;	$r13 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.net.InetSocketAddress getLocalAddress()>();	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The server ");	$r8 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.net.InetSocketAddress getLocalAddress()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>($r13, null, $r12);	throw $r4
;block_num 2